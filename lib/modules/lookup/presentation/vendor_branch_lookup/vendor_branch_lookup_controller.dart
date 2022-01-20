import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/vendor_branch_lookup/vendor_branch_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/vendor_branch_lookup/vendor_branch_lookup_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorBranchLookupController extends GetxController {
  var client = Get.find<BaseApiClient>();
  var defaultPagingSize = 25.obs;

  final int vendorId;
  final int vendorBranchId;

  var searchByVendorSiteCodeTextController = TextEditingController();
  var searchByVendorSiteNameTextController = TextEditingController();

  var state = AppPagingState<VendorBranch>();

  // Search filters
  var vendorSiteCodeFilter = '';
  var vendorSiteNameFilter = '';

  VendorBranchLookupController(this.vendorId, this.vendorBranchId);

  void resetState() {
    state = AppPagingState<VendorBranch>();

    searchByVendorSiteCodeTextController.text = '';
    searchByVendorSiteNameTextController.text = '';
    vendorSiteCodeFilter = '';
    vendorSiteNameFilter = '';
  }

  searchInputFocused(VendorBranchSearchFieldType selectedField) {
    if (selectedField == VendorBranchSearchFieldType.SEARCH_BY_SITE_CODE) {
      searchByVendorSiteCodeTextController.text = '';
    }
    if (selectedField == VendorBranchSearchFieldType.SEARCH_BY_SITE_NAME) {
      searchByVendorSiteCodeTextController.text = '';
      searchByVendorSiteNameTextController.text = '';
    }
  }

  resetSearchFilter() {
    searchByVendorSiteCodeTextController.text = '';
    searchByVendorSiteNameTextController.text = '';
  }

  onSearchTap({int? start, int? limit}) {
    vendorSiteCodeFilter = searchByVendorSiteCodeTextController.text;
    vendorSiteNameFilter = searchByVendorSiteNameTextController.text;
    getVendorBranch(start: start!, limit: limit!, reset: true);
  }

  getVendorBranch({int? start, int? limit, bool reset: false}) async {
    if (reset) {
      state.notifyReset();
    }
    state.notifyLoading();

    try {
      var request = VendorBranchLookupRequest(
          start: start,
          limit: limit,
          activeFlag: 'Y',
          vendorId: this.vendorId,
          vendorBranchId: this.vendorBranchId,
          vendorSiteCode: vendorSiteCodeFilter,
          vendorSiteName: vendorSiteNameFilter,);
      var response = await client.get('${URLs.vendorBranchLookup}',
          queryParameters: request.toJson());
      var res = VendorBranchLookupResponse.fromJson(response);
      state.addItems(res.data!, res.start!, res.limit!, defaultPagingSize.value,
          res.totalRecords!);
    } on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }
}

enum VendorBranchSearchFieldType { SEARCH_BY_SITE_CODE, SEARCH_BY_SITE_NAME }
