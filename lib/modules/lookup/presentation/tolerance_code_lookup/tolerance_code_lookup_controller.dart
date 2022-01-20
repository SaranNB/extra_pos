import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/branch_lookup/branch_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/branch_lookup/branches_response.dart';
import 'package:extra_pos/modules/lookup/data/tolerance_code_lookup/tolerance_code_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/tolerance_code_lookup/tolerance_code_lookup_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../branch_info_controller.dart';

class ToleranceCodeLookupController extends GetxController {
  var client = Get.find<BaseApiClient>();

  var defaultPagingSize = 25.obs;

  var searchByToleranceCodeTextController = TextEditingController();
  var searchByToleranceDescriptionTextController = TextEditingController();

  var state = AppPagingState<ToleranceCode>();

  // Search filters
  var toleranceCodeFilter = '';
  var toleranceDescriptionFilter = '';

  void resetState() {
    state = AppPagingState<ToleranceCode>();
  }

  searchInputFocused(ToleranceCodeSearchFieldType selectedField) {
    if (selectedField == ToleranceCodeSearchFieldType.SEARCH_BY_CODE) {
      searchByToleranceDescriptionTextController.text = '';
    }
    if (selectedField == ToleranceCodeSearchFieldType.SEARCH_BY_DESCRIPTION) {
      searchByToleranceCodeTextController.text = '';
      searchByToleranceCodeTextController.text = '';
    }
  }

  resetSearchFilter() {
    searchByToleranceCodeTextController.text = '';
    searchByToleranceDescriptionTextController.text = '';
  }

  onSearchTap({int? start, int? limit}) {
    toleranceCodeFilter = searchByToleranceCodeTextController.text;
    toleranceDescriptionFilter = searchByToleranceDescriptionTextController.text;
    getToleranceCodes(start: start!, limit: limit!, reset: true);
  }

  getToleranceCodes({int? start, int? limit, bool reset: false}) async {
    if (reset) {
      state.notifyReset();
    }
    state.notifyLoading();

    try {
      var request = ToleranceCodeLookupRequest(
          start: start, limit: limit, toleranceCode: toleranceCodeFilter, description: toleranceDescriptionFilter
      );
      var response = await client.get(
          '${URLs.toleranceCodeLookup}', queryParameters: request.toJson());
      var res = ToleranceCodeLookupResponse.fromJson(response);
      state.addItems(res.data!, res.start!, res.limit!, defaultPagingSize.value, res.totalRecords!);
    } on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }
}


enum ToleranceCodeSearchFieldType { SEARCH_BY_CODE, SEARCH_BY_DESCRIPTION }