import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/branch_lookup/branch_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/branch_lookup/branches_response.dart';
import 'package:extra_pos/modules/lookup/data/vendor_lookup/vendor_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/vendor_lookup/vendor_lookup_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../branch_info_controller.dart';

class VendorLookupController extends GetxController {
  var client = Get.find<BaseApiClient>();
  var branchInfoController = Get.put(BranchInfoController());

  var defaultPagingSize = 25.obs;

  var searchByVendorCodeTextController = TextEditingController();
  var searchByVendorNameTextController = TextEditingController();

  var state = AppPagingState<Vendor>();

  // Search filters
  var vendorCodeFilter = '';
  var vendorNameFilter = '';

  @override
  void onInit() {
    resetState();
  }

  void resetState() {
    state = AppPagingState<Vendor>();
    searchByVendorCodeTextController.text = '';
    searchByVendorNameTextController.text = '';
    vendorCodeFilter = '';
    vendorNameFilter = '';
  }

  searchInputFocused(VendorSearchFieldType selectedField) {
    if (selectedField == VendorSearchFieldType.SEARCH_BY_CODE) {
      searchByVendorNameTextController.text = '';
    }
    if (selectedField == VendorSearchFieldType.SEARCH_BY_NAME) {
      searchByVendorCodeTextController.text = '';
      searchByVendorCodeTextController.text = '';
    }
  }

  resetSearchFilter() {
    searchByVendorCodeTextController.text = '';
    searchByVendorNameTextController.text = '';
  }

  onSearchTap({int? start, int? limit}) {
    vendorCodeFilter = searchByVendorCodeTextController.text;
    vendorNameFilter = searchByVendorNameTextController.text;
    getVendors(start: start!, limit: limit!, reset: true);
  }

  getVendors({int? start, int? limit, bool reset: false}) async {
    if (reset) {
      state.notifyReset();
    }
    state.notifyLoading();

    try {
      var request = VendorLookupRequest(
          start: start, limit: limit, activeFlag: 'Y', vendorCode: vendorCodeFilter, vendorName: vendorNameFilter
      );
      var response = await client.get(
          '${URLs.vendorLookup}', queryParameters: request.toJson());
      var res = VendorLookupResponse.fromJson(response);
      state.addItems(res.data!, res.start!, res.limit!, defaultPagingSize.value, res.totalRecords!);
    } on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }
}

enum VendorSearchFieldType { SEARCH_BY_CODE, SEARCH_BY_NAME }
