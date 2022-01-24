 import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/app_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/branch_lookup/branches_response.dart';
import 'package:extra_pos/modules/lookup/data/status_lookup/requisition_status_response.dart';
import 'package:extra_pos/modules/lookup/data/user_lookup/users_response.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/requisition_header_lookup/requisition_header_lookup_controller.dart';
import 'package:extra_pos/modules/requisition/data/list_requisition/list_requisition_request.dart';
import 'package:extra_pos/modules/requisition/data/list_requisition/list_requisition_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/base_api_client.dart';

class ListRequisitionController extends GetxController {
  var client = Get.find<BaseApiClient>();

  var branchInfoController = Get.put(BranchInfoController());
  var headerLookupController = Get.put(RequisitionHeaderLookupController());

  var defaultPagingSize = 25.obs;

  var trnTextController = TextEditingController();
  var branchTextController = TextEditingController();
  var userTextController = TextEditingController();
  var trnStatusTextController = TextEditingController();

  var selectedBranch = Branch();
  var selectedUser = User();
  RxString selectedRequisitionStatus = ''.obs;

  var state = AppPagingState<Requisition>();
  var requisitionStatusListState = AppState<RequisitionStatusListResponse>();


  // Search Filters
  var branchCodeFilter = '';
  var branchIdFilter = '';
  var trnFilter = '';
  var userNameFilter = '';
  var requisitionStatusFilter = '';

  @override
  void onInit() {
    super.onInit();
  }

  resetSearchFilter() {
    trnTextController.text = '';
    branchTextController.text = '';
    userTextController.text = '';
    trnStatusTextController.text = '';

    selectedBranch = Branch();
    selectedUser = User();
    selectedRequisitionStatus.value != null;
  }

  onSearchTap({int? start, int? limit}) {
    branchCodeFilter = selectedBranch.branchCode ?? '';
    branchIdFilter = selectedBranch.branchId?.toString() ?? '';
    trnFilter = trnTextController.text ;
    userNameFilter = selectedUser.userName ?? '';
    requisitionStatusFilter = selectedRequisitionStatus.value;

    getRequisitions(start: start!, limit: limit!, reset: true);
  }

  getRequisitions({int? start, int? limit, bool reset: false}) async {
    if (reset) {
      state.notifyReset();
    }
    state.notifyLoading();

    try {
      var request = ListRequisitionRequest(
          start: start,
          limit: limit,
          branchCode: branchCodeFilter,
          tempRequisitionNumber: trnFilter,
          userName: userNameFilter,
          branchId: branchIdFilter,
          requisitionStatus: requisitionStatusFilter);

      var response = await client.get(URLs.getRequisitions,
          queryParameters: request.toJson());
      var result = ListRequisitionResponse.fromJson(response);
      state.addItems(result.data!, result.start!, result.limit!,
          defaultPagingSize.value, result.totalRecords!);
    } on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }

  getRequisitionStatusList() async {
    requisitionStatusListState.notifyLoading();
    try {
      var response = await client.get(URLs.requisitionStatusListLookup);
      var res = RequisitionStatusListResponse.fromJson(response);
      requisitionStatusListState.notifyCompleted(res);
    } on NetworkException catch (e) {
      requisitionStatusListState.notifyError(e.getErrorMessage());
    }
  }
}
