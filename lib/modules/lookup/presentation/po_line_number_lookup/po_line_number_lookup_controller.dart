import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/po_line_number_lookup/po_line_number_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/po_line_number_lookup/po_line_number_lookup_response.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class POLineNumberLookupController extends GetxController {

  var client = Get.find<BaseApiClient>();
  var defaultPagingSize = 25.obs;

  final String itemCode;
  final int headerId;
  final int headerBranchId;
  final int itemId;
  final int itemBranchId;
  
  var branchInfoController = Get.find<BranchInfoController>();

  var searchByPONumberTextController = TextEditingController();

  var state = AppPagingState<POLineNumber>();

  POLineNumberLookupController(this.itemCode, this.headerId, this.headerBranchId, this.itemId, this.itemBranchId);
  
  void resetState() {
    state = AppPagingState<POLineNumber>();

    searchByPONumberTextController.text = '';
  }
  
  onSearchTap({int? start, int? limit}) {
    getPOLineNumbers(start: start, limit: limit, reset: true);
  }

  getPOLineNumbers({int? start, int? limit, bool reset: false}) async {
    if (reset) {
      state.notifyReset();
    }
    state.notifyLoading();

    try {

      var request = POLineNumberLookupRequest(
        itemCode: this.itemCode,
          headerId: this.headerId,
          headerBranchId: this.headerBranchId,
          itemId: this.itemId,
          itemBranchId: this.itemBranchId,
          start: start,
          limit: limit);
      var response = await client.get('${URLs.poLineNumberLookup}',
          queryParameters: request.toJson());
      var res = POLineNumberLookupResponse.fromJson(response);
      state.addItems(res.data!, res.start!, res.limit!, defaultPagingSize.value,
          res.totalRecords!);
    } on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }


}