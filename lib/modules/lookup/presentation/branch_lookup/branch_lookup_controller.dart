import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/branch_lookup/branch_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/branch_lookup/branches_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../branch_info_controller.dart';

class BranchLookupController extends GetxController {
  var client = Get.find<BaseApiClient>();
  var branchInfoController = Get.put(BranchInfoController());

  var defaultPagingSize = 25.obs;

  var searchByBranchCodeTextController = TextEditingController();
  var searchByBranchDescriptionTextController = TextEditingController();

  var state = AppPagingState<Branch>();

  // Search filters
  var branchCodeFilter = '';
  var branchDescriptionFilter = '';

  void resetState() {
    state = AppPagingState<Branch>();
  }

  searchInputFocused(BranchSearchFieldType selectedField) {
    if (selectedField == BranchSearchFieldType.SEARCH_BY_CODE) {
      searchByBranchDescriptionTextController.text = '';
    }
    if (selectedField == BranchSearchFieldType.SEARCH_BY_DESCRIPTION) {
      searchByBranchCodeTextController.text = '';
      searchByBranchCodeTextController.text = '';
    }
  }

  resetSearchFilter() {
    searchByBranchCodeTextController.text = '';
    searchByBranchDescriptionTextController.text = '';
  }

  onSearchTap({int? start, int? limit}) {
    branchCodeFilter = searchByBranchCodeTextController.text;
    branchDescriptionFilter = searchByBranchDescriptionTextController.text;
    getBranches(start: start!, limit: limit!, reset: true);
  }

  getBranches({int? start, int? limit, bool reset: false}) async {
    if (reset) {
      state.notifyReset();
    }
    state.notifyLoading();

    try {
      var request = BranchLookupRequest(
        start: start, limit: limit, activeFlag: 'Y', branchCode: branchCodeFilter, branchDescription: branchDescriptionFilter
      );
      var response = await client.get(
          '${URLs.branchLookup}', queryParameters: request.toJson());
      var res = BranchesResponse.fromJson(response);
      state.addItems(res.data!, res.start!, res.limit!, defaultPagingSize.value, res.totalRecords!);
    }  on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }
}

enum BranchSearchFieldType { SEARCH_BY_CODE, SEARCH_BY_DESCRIPTION }
