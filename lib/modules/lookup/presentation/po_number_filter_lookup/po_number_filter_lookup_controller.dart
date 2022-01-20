import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/po_number_filter_lookup/po_number_filter_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/po_number_filter_lookup/po_number_filter_lookup_response.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PONumberFilterLookupController extends GetxController {

  var client = Get.find<BaseApiClient>();
  var defaultPagingSize = 25.obs;

  var branchInfoController = Get.find<BranchInfoController>();


  var searchByPONumberTextController = TextEditingController();

  var state = AppPagingState<PONumber>();

  // Search filters
  var poNumberFilter = '';


  void resetState() {
    state = AppPagingState<PONumber>();
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
      var request = PONumberFilterLookupRequest(
          start: start,
          limit: limit,
          poNumber: poNumberFilter);
      var response = await client.get('${URLs.poNumberFilterLookup}',
          queryParameters: request.toJson());
      var res = PONumberFilterLookupResponse.fromJson(response);
      state.addItems(res.data!, res.start!, res.limit!, defaultPagingSize.value,
          res.totalRecords!);
    } on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }


}