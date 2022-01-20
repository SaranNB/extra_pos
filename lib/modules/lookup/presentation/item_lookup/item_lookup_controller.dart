import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/item_lookup/item_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/item_lookup/items_response.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ItemLookupController extends GetxController {
  var client = Get.find<BaseApiClient>();
  var branchInfoController = Get.put(BranchInfoController());

  var defaultPagingSize = 25.obs;

  var searchByItemCodeTextController = TextEditingController();
  var searchByItemDescriptionTextController = TextEditingController();

  var state = AppPagingState<Item>();
  var barcodeBasedItemsState = AppPagingState<Item>();

  var itemCodeFilter = '';
  var itemDescriptionFilter = '';

  void resetState() {
    state = AppPagingState<Item>();
    barcodeBasedItemsState = AppPagingState<Item>();
    searchByItemCodeTextController.text = '';
    searchByItemDescriptionTextController.text = '';

    itemCodeFilter = '';
    itemDescriptionFilter = '';
  }

  searchInputFocused(ItemSearchFieldType selectedField) {
    if (selectedField == ItemSearchFieldType.SEARCH_BY_CODE) {
      searchByItemDescriptionTextController.text = '';
    }
    if (selectedField == ItemSearchFieldType.SEARCH_BY_DESCRIPTION) {
      searchByItemCodeTextController.text = '';
    }
  }

  resetSearchFilter() {
    searchByItemCodeTextController.text = '';
    searchByItemDescriptionTextController.text = '';
  }

  onSearchTap({int? start, int? limit}) {
    itemCodeFilter = searchByItemCodeTextController.text;
    itemDescriptionFilter = searchByItemDescriptionTextController.text;
    getItems(start: start!, limit: limit!, reset: true);
  }

  getItems({int? start, int? limit, bool reset: false}) async {
    if (reset) {
      state.notifyReset();
    }
    state.notifyLoading();

    try {
      var currentBranch = await branchInfoController.getCurrentBranchInfo();
      var currentBranchCodeId = currentBranch.data![0].branchId;

      var request = ItemLookupRequest(
        start: start,
        limit: limit,
        itemNumber: itemCodeFilter,
        itemDescription: itemDescriptionFilter,
        branchCodeId: currentBranchCodeId
      );

      var response = await client.get(URLs.getItemInfo, queryParameters: request.toJson());
      var res = ItemsResponse.fromJson(response);
      state.addItems(res.data!, res.start!, res.limit!, defaultPagingSize.value, res.totalRecords!);
    } on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }

  getPartsBasedOnBarcode({int? start, int? limit, bool reset: false, String? scannedBarcode}) async {
    if (reset) {
      barcodeBasedItemsState.notifyReset();
    }
    barcodeBasedItemsState.notifyLoading();

    try {
      var currentBranch = await branchInfoController.getCurrentBranchInfo();
      var currentBranchCodeId = currentBranch.data![0].branchId;
      var response = await client.get(
          '${URLs.getItemInfo}?start=$start&limit=$limit&itemNumber=$scannedBarcode&&branchCodeId=$currentBranchCodeId');
      var res = ItemsResponse.fromJson(response);
      barcodeBasedItemsState.addItems(res.data!, res.start!, res.limit!, defaultPagingSize.value, res.totalRecords!);
    } on NetworkException catch (e) {
      barcodeBasedItemsState.notifyError(e.getErrorMessage());
    }
  }
}

enum ItemSearchFieldType { SEARCH_BY_CODE, SEARCH_BY_DESCRIPTION }
