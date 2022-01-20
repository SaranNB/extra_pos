import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_constants.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/core/widgets/dialogs/circular_progress_loader_dialog.dart';
import 'package:extra_pos/core/widgets/dialogs/message_dialog.dart';
import 'package:extra_pos/modules/lookup/data/item_lookup/items_response.dart';
import 'package:extra_pos/modules/lookup/data/po_receipt_header_lookup/po_receipt_header_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/po_receipt_line_lookup/po_receipt_line_request.dart';
import 'package:extra_pos/modules/lookup/data/po_receipt_line_lookup/po_receipt_line_response.dart';
import 'package:extra_pos/modules/lookup/presentation/barcode_based_item_lookup/barcode_based_item_lookup_page.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/po_receipt_header_lookup/po_receipt_header_lookup_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/user_info_controller.dart';
import 'package:extra_pos/modules/po_receipts/data/submit_po_receipt/submit_po_receipt_request.dart';
import 'package:extra_pos/modules/po_receipts/data/submit_po_receipt/submit_po_receipt_response.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class POReceiptReviewController extends GetxController {
  var client = Get.find<BaseApiClient>();
  var state = AppPagingState<POReceiptLine>();

  var branchInfoController = Get.find<BranchInfoController>();
  var userInfoController = Get.find<UserInfoController>();
  var headerLookupController = Get.put(POReceiptHeaderLookupController());

  var poReceiptInfo = POReceiptHeader.fromJson(Get.arguments).obs;
  var selectedItem = Rx<Item?>(null);

  var defaultPagingSize = 25.obs;
  var isMoreInfoSwitchOn = AppConstants.isMoreInfoSwitchOn.obs;

  var itemNumberFilter = '';

  var isPOReceiptSubmitted = false.obs;

  @override
  void onInit() async {
    userInfoController.getUserInfoAndNotify();
    branchInfoController.getBranchInfoAndNotify();
    updatePOReceiptStatus();
    super.onInit();
  }

  setMoreInfoSwitchState(bool value) {
    this.isMoreInfoSwitchOn.value = value;
  }

  resetSearchFilter() {
    selectedItem.value = Item();
  }

  onSearchTap({int? start, int? limit}) {
    itemNumberFilter = selectedItem.value!.itemNumber ?? '';

    getItems(start: start!, limit: limit!, reset: true);
  }

  getItems({int? start, int? limit, bool reset: false}) async {
    if (reset) {
      state.notifyReset();
    }
    state.notifyLoading();
    try {
      var request = POReceiptLineRequest(
          start: start,
          limit: limit,
          headerBranchId: poReceiptInfo.value.branchId,
          headerId: poReceiptInfo.value.headerId,
          itemCode: itemNumberFilter);
      var response = await client.get(URLs.getPOReceiptLines,
          queryParameters: request.toJson(), removeNulls: true);
      var result = POReceiptLineListResponse.fromJson(response);
      state.addItems(result.data!, result.start!, result.limit!,
          defaultPagingSize.value, result.totalRecords!);
    } on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }

  submitPOReceipt() async {
    CircularProgressLoaderDialog.showLoader(
        Get.context!, 'Submitting PO Receipt, please wait...');
    try {
      var request = SubmitPOReceiptRequest(
          branchId: poReceiptInfo.value.branchId,
          headerId: poReceiptInfo.value.headerId,
          receiptNumber: poReceiptInfo.value.receiptNumber,
      isWarningAccepted: 'N');
      var response =
          await client.post(URLs.submitPOReceipt, body: request.toJson());
      var result = SubmitPOReceiptResponse.fromJson(response);
      Get.back();
      showMessageDialog(mainMessage: result.message);
      reloadPOReceiptInfo();
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

      if (itemsResponse.totalRecords !<= 0) {
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

  refreshData() async {
    await reloadPOReceiptInfo();
    getItems(start: 1, limit: defaultPagingSize.value, reset: true);
  }

  Future reloadPOReceiptInfo() async {
    var requisitions = await headerLookupController.getPOReceiptHeaders(
        headerId: poReceiptInfo.value.headerId,
        branchId: poReceiptInfo.value.branchId,
        start: 1,
        limit: 1);
    if (requisitions!.data!.length <= 0) {
      return;
    }
    poReceiptInfo.value = requisitions.data![0];
    updatePOReceiptStatus();
  }

  updatePOReceiptStatus() {
    if (poReceiptInfo.value.receiptStatus == null)
      isPOReceiptSubmitted.value = false;

    if (poReceiptInfo.value.receiptStatus?.toUpperCase() == 'OPEN')
      isPOReceiptSubmitted.value = false;

    if (poReceiptInfo.value.receiptStatus?.toUpperCase() == 'COMPLETED')
      isPOReceiptSubmitted.value = true;
  }
}
