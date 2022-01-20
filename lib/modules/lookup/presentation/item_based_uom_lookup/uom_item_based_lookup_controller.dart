import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/date_time_utils.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/item_lookup/items_response.dart';
import 'package:extra_pos/modules/lookup/data/uom_item_based_lookup/uom_item_based_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/uom_item_based_lookup/uom_item_based_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UomItemBasedLookupController extends GetxController {
  var client = Get.find<BaseApiClient>();
  var itemInfo = Item();

  var defaultPagingSize = 25.obs;

  var searchByUomController = TextEditingController();

  var state = AppPagingState<UomItemBased>();

  var uomFilter = '';

  void resetState() {
    state = AppPagingState<UomItemBased>();
  }


  resetSearchFilter() {
    searchByUomController.text = '';
  }

  onSearchTap({int? start, int? limit}) {
    uomFilter = searchByUomController.text;
    getUoms(start: start!, limit: limit!, reset: true);
  }

  getUoms({int? start, int? limit, bool reset: false}) async {
    if (reset) {
      state.notifyReset();
    }
    state.notifyLoading();

    try {

      var request = UomItemBasedLookupRequest(
        start: start,
        limit: limit,
        activeFlag: 'Y',
        endDate: getCurrentDateString(),
        itemBranchId: itemInfo.branchId,
        itemId: itemInfo.itemId,
        uom: uomFilter
      );

      var response = await client.get(URLs.getItemBasedUom, queryParameters: request.toJson());
      var res = UomItemBasedResponse.fromJson(response);
      state.addItems(res.data!, res.start!, res.limit!, defaultPagingSize.value, res.totalRecords!);
    } on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }
}

