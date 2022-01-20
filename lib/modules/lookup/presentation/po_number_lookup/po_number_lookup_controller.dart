import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/po_line_number_lookup/po_line_number_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/po_number_lookup/po_number_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/po_number_lookup/po_number_lookup_response.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PONumberLookupController extends GetxController {

  var client = Get.find<BaseApiClient>();
  var defaultPagingSize = 25.obs;

  var branchInfoController = Get.find<BranchInfoController>();

   int? vendorBranchId;
   int? vendorId;
   int? vendorSiteBranchId;
   int? vendorSiteId;
   String? allowBackOrders;

  var searchByPONumberTextController = TextEditingController();

  var state = AppPagingState<PONumber>();

  // Search filters
  var poNumberFilter = '';

  PONumberLookupController(int vendorBranchId, int vendorId, int vendorSiteBranchId, int vendorSiteId, String allowBackOrders) {
    this.vendorBranchId = vendorBranchId;
    this.vendorId = vendorId;
    this.vendorSiteBranchId = vendorSiteBranchId;
    this.vendorSiteId = vendorSiteId;
    this.allowBackOrders = allowBackOrders;
  }

  void resetState() {
    state = AppPagingState<PONumber>();
    searchByPONumberTextController.text = '';
    poNumberFilter = '';
  }

  resetSearchFilter() {
    poNumberFilter = '';
  }

  onSearchTap({int? start, int? limit}) {
    poNumberFilter = searchByPONumberTextController.text;
    getPONumbers(start: start!, limit: limit!, reset: true);
  }

  getPONumbers({int? start, int? limit, bool reset: false}) async {
    if (reset) {
      state.notifyReset();
    }
    state.notifyLoading();

    try {
      var currentBranch = await branchInfoController.getCurrentBranchInfo();
      var currentBranchCodeId = currentBranch.data![0].branchId;
      var request = PONumberLookupRequest(
          start: start,
          limit: limit,
          shipToBranchId: currentBranchCodeId,
          vendorBranchId: vendorBranchId,
          vendorId: vendorId,
          vendorSiteBranchId: vendorSiteBranchId,
          vendorSiteId: vendorSiteId,
          poNumber: poNumberFilter,
          allowBackOrders: this.allowBackOrders);
      var response = await client.get('${URLs.poNumberLookup}',
          queryParameters: request.toJson());
      var res = PONumberLookupResponse.fromJson(response);
      state.addItems(res.data!, res.start!, res.limit!, defaultPagingSize.value,
          res.totalRecords!);
    } on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }


}