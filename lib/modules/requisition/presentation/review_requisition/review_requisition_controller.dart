import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_constants.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/core/widgets/dialogs/circular_progress_loader_dialog.dart';
import 'package:extra_pos/core/widgets/dialogs/message_dialog.dart';
import 'package:extra_pos/modules/lookup/data/item_lookup/items_response.dart';
import 'package:extra_pos/modules/lookup/data/requisition_header_lookup/requisition_header_response.dart';
import 'package:extra_pos/modules/lookup/presentation/barcode_based_item_lookup/barcode_based_item_lookup_page.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/requisition_header_lookup/requisition_header_lookup_controller.dart';
import 'package:extra_pos/modules/requisition/data/delete_requisition/delete_requisition_request.dart';
import 'package:extra_pos/modules/requisition/data/delete_requisition/delete_requisition_response.dart';
import 'package:extra_pos/modules/requisition/data/list_requisition/list_requisition_response.dart';
import 'package:extra_pos/modules/requisition/data/requisition_line_list/requisition_line_list_request.dart';
import 'package:extra_pos/modules/requisition/data/requisition_line_list/requisition_line_list_response.dart';
import 'package:extra_pos/modules/requisition/data/submit_temp_requisition/submit_temp_requisition_request.dart';
import 'package:extra_pos/modules/requisition/data/submit_temp_requisition/submit_temp_requisition_response.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class RequisitionReviewController extends GetxController {
  var client = Get.find<BaseApiClient>();
  var state = AppPagingState<RequisitionLine>();

  var branchInfoController = Get.find<BranchInfoController>();
  var headerLookupController = Get.put(RequisitionHeaderLookupController());

  var requisitionInfo = RequisitionHeader.fromJson(Get.arguments).obs;
  var selectedItem = Item().obs;

  var defaultPagingSize = 25.obs;
  var isMoreInfoSwitchOn = AppConstants.isMoreInfoSwitchOn.obs;

  var itemNumberFilter = '';

  setMoreInfoSwitchState(bool value) {
    this.isMoreInfoSwitchOn.value = value;
  }

  resetSearchFilter() {
    selectedItem.value = Item();
  }

  onSearchTap({int? start, int? limit}) {
    itemNumberFilter = selectedItem.value.itemNumber ?? '';

    getItems(start: start!, limit: limit!, reset: true);
  }

  getItems({int? start, int? limit, bool reset: false}) async {
    if (reset) {
      state.notifyReset();
    }
    state.notifyLoading();
    try {
      var request = RequisitionLineListRequest(
          start: start!,
          limit: limit!,
          headerBranchId: requisitionInfo.value.branchId!,
          headerId: requisitionInfo.value.headerId,
          itemNumber: itemNumberFilter);
      var response = await client.get(URLs.getRequisitionLines,
          queryParameters: request.toJson());
      var result = RequisitionLineListResponse.fromJson(response);
      state.addItems(result.data!, result.start!, result.limit!,
          defaultPagingSize.value, result.totalRecords!);
    } on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }

  submitTempRequisition() async {
    CircularProgressLoaderDialog.showLoader(
        Get.context!, 'Submitting requisition, please wait...');
    try {
      var request = SubmitTempRequisitionRequest(
          branchId: requisitionInfo.value.branchId,
          headerId: requisitionInfo.value.headerId);
      var response =
          await client.put(URLs.submitTempRequisition, body: request.toJson());
      var result = SubmitRequisitionResponse.fromJson(response);
      Get.back();
      showMessageDialog(mainMessage: result.message);
      reloadTrnInfo();
    } on NetworkException catch (e) {
      Get.back();
    }
  }

  void deleteTempRequisition() async{
    CircularProgressLoaderDialog.showLoader(
        Get.context!, 'Deleting requisition, please wait...');
    try {
      var request = DeleteRequisitionRequest(
          branchId: requisitionInfo.value.branchId,
          headerId: requisitionInfo.value.headerId,
          trn: requisitionInfo.value.trn);

      var response = await client.put(URLs.deleteTempRequisition, body: request.toJson());
      var result = DeleteRequisitionResponse.fromJson(response);
      Get.back();
      await showMessageDialog(mainMessage: result.message);
      Get.back(result: true);
    } on NetworkException catch (e) {
      Get.back();
    }
  }

  void openBarcodeScanner() async {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", 'Cancel', false, ScanMode.BARCODE);

    if (barcodeScanResult == "-1") {
      return;
    }

    CircularProgressLoaderDialog.showLoader(
        Get.context!, 'Processing barcode, Please wait...');

    try {
      var currentBranch = await branchInfoController.getCurrentBranchInfo();
      var currentBranchCodeId = currentBranch.data![0].branchId;
      var response = await client.get(
          '${URLs.getItemInfo}?start=1&limit=1&branchCodeId=$currentBranchCodeId&itemNumber=$barcodeScanResult');
      var itemsResponse = ItemsResponse.fromJson(response);

      Get.back();

      if (itemsResponse.totalRecords! <= 0) {
        print('No items found');
        return;
      }
      if (itemsResponse.totalRecords == 1) {
        this.selectedItem.value = itemsResponse.data![0];
        return;
      }

      Get.to(BarCodeBasedItemLookupPage(
          onItemSelected: (selectedItem) {
            this.selectedItem.value = selectedItem;
          },
          scannedBarcode: barcodeScanResult));
    } on NetworkException catch (e) {
      Get.back();
    }
  }

  Future reloadTrnInfo() async {
    var requisitions = await headerLookupController.getRequisition(
        headerId: requisitionInfo.value.headerId,
        branchId: requisitionInfo.value.branchId,
        start: 1,
        limit: 1);
    if (requisitions!.data!.length <= 0) {
      return;
    }
    requisitionInfo.value = requisitions.data![0];
  }

  refreshData() async {
    await reloadTrnInfo();
    getItems(start: 1, limit: defaultPagingSize.value, reset: true);
  }
}
