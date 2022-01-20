import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/app_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/branch_lookup/branches_response.dart';
import 'package:extra_pos/modules/lookup/data/po_number_filter_lookup/po_number_filter_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/po_receipt_header_lookup/po_receipt_header_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/po_receipt_header_lookup/po_receipt_header_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/user_lookup/users_response.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/po_receipt_header_lookup/po_receipt_header_lookup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPOReceiptController extends GetxController {
  var client = Get.find<BaseApiClient>();
  var branchInfoController = Get.put(BranchInfoController());
  var headerLookupController = Get.put(POReceiptHeaderLookupController());

  var defaultPagingSize = 25.obs;

  var receiptNumberTextController = TextEditingController();
  var branchTextController = TextEditingController();
  var userNameTextController = TextEditingController();
  var vendorInvoiceNumberTextController = TextEditingController();
  var poNumberTextController = TextEditingController();
  var receiptDateTextController = TextEditingController();

  var selectedBranch = Rx<Branch?>(null);
  var selectedUser = Rx<User?>(null);
  var selectedPONumber = Rx<PONumber?>(null);
  var selectedDate = Rx<DateTime?>(null);

  var state = AppPagingState<POReceiptHeader>();
  var requisitionStatusListState = AppState<POReceiptHeaderLookupResponse>();

  var scrollController = ScrollController();

  // Search Filters
  var receiptNumberFilter = '';
  var receivingBranchFilter = '';
  var userNameFilter = '';
  var vendorInvoiceNumberFilter = '';
  var poNumberFilter = '';
  String? receiptDateFilter = null;

  @override
  void onInit() {
    super.onInit();
  }

  resetSearchFilter() {
    receiptNumberTextController.text = '';
    branchTextController.text = '';
    userNameTextController.text = '';
    vendorInvoiceNumberTextController.text = '';
    poNumberTextController.text = '';
    receiptDateTextController.text = '';

    selectedBranch.value = null;
    selectedUser.value = null;
    selectedPONumber.value = null;
    selectedDate.value = null;
  }

  onSearchTap({int? start, int? limit}) {
    scrollController.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    receiptNumberFilter = receiptNumberTextController.text;
    receivingBranchFilter = selectedBranch.value!.branchCode ?? '';
    userNameFilter = selectedUser.value!.userName!;
    vendorInvoiceNumberFilter = vendorInvoiceNumberTextController.text;
    poNumberFilter = selectedPONumber.value?.poNumber ?? '';
    receiptDateFilter = selectedDate.value?.toIso8601String() ?? null;

    getPoReceipts(start: start, limit: limit, reset: true);
  }

  getPoReceipts({int? start, int? limit, bool reset: false}) async {
    if (reset) {
      state.notifyReset();
    }
    state.notifyLoading();

    try {
      var request = POReceiptHeaderLookupRequest(
          start: start,
          limit: limit,
          receiptNumber: receiptDateFilter,
      receivingBranch: receivingBranchFilter,
      userName: userNameFilter,
      vendorInvoiceNo: vendorInvoiceNumberFilter,
      poNumber: poNumberFilter,
      receiptDate: null);

      var response = await client.get(URLs.getPOReceipts,
          queryParameters: request.toJson(), removeNulls: true);
      var result = POReceiptHeaderLookupResponse.fromJson(response);
      state.addItems(result.data!, result.start!, result.limit!,
          defaultPagingSize.value, result.totalRecords!);
    } on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }
}
