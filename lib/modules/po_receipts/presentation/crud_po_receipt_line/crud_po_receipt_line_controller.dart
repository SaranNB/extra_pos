import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_constants.dart';
import 'package:extra_pos/core/utils/debounce.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/core/utils/validation_message.dart';
import 'package:extra_pos/core/widgets/dialogs/circular_progress_loader_dialog.dart';
import 'package:extra_pos/core/widgets/dialogs/message_dialog.dart';
import 'package:extra_pos/modules/lookup/data/item_lookup/items_response.dart';
import 'package:extra_pos/modules/lookup/data/po_line_number_lookup/po_line_number_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/po_receipt_header_lookup/po_receipt_header_lookup_response.dart';
import 'package:extra_pos/modules/lookup/presentation/barcode_based_item_lookup/barcode_based_item_lookup_page.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/item_lookup/item_lookup_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/po_receipt_header_lookup/po_receipt_header_lookup_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/po_receipt_line_lookup/po_receipt_line_lookup_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/user_info_controller.dart';
import 'package:extra_pos/modules/po_receipts/data/crud_po_receipt_line/create_po_receipt_line_request.dart';
import 'package:extra_pos/modules/po_receipts/data/crud_po_receipt_line/cud_po_receipt_response.dart';
import 'package:extra_pos/modules/po_receipts/data/crud_po_receipt_line/delete_po_receipt_line_request.dart';
import 'package:extra_pos/modules/po_receipts/data/crud_po_receipt_line/info_for_po_line_crud.dart';
import 'package:extra_pos/modules/po_receipts/data/crud_po_receipt_line/update_po_receipt_line_request.dart';
import 'package:extra_pos/modules/requisition/presentation/crud_requisition_line/crud_requisition_line_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:extra_pos/extensions.dart';

class CrudPOReceiptLineController extends GetxController {
  var client = Get.find<BaseApiClient>();
  var userInfoController = Get.put(UserInfoController());
  var branchInfoController = Get.put(BranchInfoController());
  var poReceiptHeaderLookupController =
      Get.put(POReceiptHeaderLookupController());
  var poReceiptLineLookupController = Get.put(POReceiptLineLookupController());
  var itemLookupController = Get.put(ItemLookupController());

  var isMoreInfoSwitchOn = AppConstants.isMoreInfoSwitchOn.obs;

  var selectedItem = Rx<Item?>(null);
  var selectedPOLineNumber = Rx<POLineNumber?>(null);

  // var itemController = TextEditingController();
  var poLineNumberTextController = TextEditingController();
  var orderReceivedNowQuantityTextController = TextEditingController();

  // Validations
  var itemValidation = ValidationMessage().obs;
  var poLineNumberValidation = ValidationMessage().obs;
  var orderReceivedNowQuantityValidation = ValidationMessage().obs;

  bool isAddSelected = false;

  var isFormValid = true.obs;

  var savedLineResult = CudPOReceiptLineResponse();

  var formState = AppFormState.NEW;

  setMoreInfoSwitchState(bool value) {
    this.isMoreInfoSwitchOn.value = value;
  }

  // Extra data from other page to create/update line
  var poReceiptLineInfo = InfoForPOReceiptLineCrud();
  var poReceiptHeader = Rx<POReceiptHeader?>(null);

  @override
  void onInit() async {
    var arguments = Get.arguments;
    var poReceiptInfo = InfoForPOReceiptLineCrud.fromJson(arguments);
    this.poReceiptLineInfo = poReceiptInfo;

    var poReceiptHeader =
        await poReceiptHeaderLookupController.getPOReceiptHeaders(
            headerId: poReceiptInfo.poReceiptHeaderInfo!.headerId,
            branchId: poReceiptInfo.poReceiptHeaderInfo!.branchId,
            start: 1,
            limit: 1);
    this.poReceiptHeader.value = poReceiptHeader!.data![0];

    userInfoController.getUserInfoAndNotify();
    branchInfoController.getBranchInfoAndNotify();

    // Checking for extra data given to this page
    // If the line info is null the page is opened from the create po receipt page
    // and If the line info has data, the page is open from the line info page
    if (poReceiptInfo.poReceiptLineInfo != null) {
      // Updating form state to saved because the request comes from line info page
      formState = AppFormState.SAVED;

      var poReceiptLines =
          await poReceiptLineLookupController.getPOReceiptLines(
              branchId: poReceiptInfo.poReceiptLineInfo!.branchId,
              lineId: poReceiptInfo.poReceiptLineInfo!.lineId,
              headerBranchId: poReceiptInfo.poReceiptLineInfo!.headerBranchId,
              headerId: poReceiptInfo.poReceiptLineInfo!.headerId,
              itemCode: poReceiptInfo.poReceiptLineInfo!.itemNumber,
              start: 1,
              limit: 1);
      var poReceiptLine = poReceiptLines!.data![0];

      // var itemRequest = ItemLookupRequest(
      //     start: 1,
      //     limit: 1,
      //     itemNumber: poReceiptInfo.poReceiptLineInfo.itemNumber
      // );
      //
      // var response = await client.get(URLs.getItemInfo, queryParameters: itemRequest.toJson());
      //
      // var itemResponse = ItemsResponse.fromJson(response);

      Debouncer(milliseconds: 10).run(() {

        selectedItem.value = Item(
            branchId: poReceiptLine.itemBranchId,
            itemId: poReceiptLine.itemId,
            itemNumber: poReceiptLine.itemNumber,
            itemDescription: poReceiptLine.itemDescription,
            itemSaleUom: poReceiptLine.uom);

        selectedPOLineNumber.value = POLineNumber(
            branchId: poReceiptLine.branchId,
            lineId: poReceiptLine.lineId,
            uomId: poReceiptLine.uomId,
            uomBranchId: poReceiptLine.uomBranchId,
            uom: poReceiptLine.uom,
            orderedQuantity: poReceiptLine.orderedQuantity,
            unitCostVip: poReceiptLine.unitCostVip,
            unitCostVep: poReceiptLine.unitCostVep,
            taxAmount: poReceiptLine.tax);
        poLineNumberTextController.text = poReceiptLine.itemNumber.toString();
        orderReceivedNowQuantityTextController.text =
            poReceiptLine.recdNowQuantity.toString();
      });
    }

    super.onInit();
  }

  void handleSaveClick() async {
    if (!validateForm()) {
      return;
    }

    var headersResponse =
        await poReceiptHeaderLookupController.getPOReceiptHeaders(
            headerId: poReceiptLineInfo.poReceiptHeaderInfo!.headerId,
            branchId: poReceiptLineInfo.poReceiptHeaderInfo!.branchId,
            start: 1,
            limit: 1);
    if (headersResponse!.data!.length <= 0) {
      return;
    }
    var headerInfo = headersResponse.data![0];
    saveOrUpdate(headerInfo);
  }

  void handleAddClick() {
    if (!validateForm()) {
      return;
    }
    isAddSelected = true;
    handleSaveClick();
  }

  void handleDeleteClick() async {
    if (formState == AppFormState.NEW) {
      clearAllSelection();
      return;
    }

    var headersResponse =
        await poReceiptHeaderLookupController.getPOReceiptHeaders(
            headerId: poReceiptLineInfo.poReceiptHeaderInfo!.headerId,
            branchId: poReceiptLineInfo.poReceiptHeaderInfo!.branchId,
            start: 1,
            limit: 1);

    if (headersResponse!.data!.length <= 0) {
      return;
    }
    var headerInfo = headersResponse.data![0];

    var lines = await poReceiptLineLookupController.getPOReceiptLines(
        branchId: this.poReceiptLineInfo.poReceiptLineInfo!.branchId,
        lineId: this.poReceiptLineInfo.poReceiptLineInfo!.lineId,
        headerBranchId: this.poReceiptLineInfo.poReceiptLineInfo!.headerBranchId,
        headerId: this.poReceiptLineInfo.poReceiptLineInfo!.headerId,
        itemCode: this.poReceiptLineInfo.poReceiptLineInfo!.itemNumber,
        start: 1,
        limit: 1);

    var poReceiptLine = lines!.data![0];
    if (lines.data!.length <= 0) {
      return;
    }

    var request = DeletePOReceiptLineRequest(
      branchId: poReceiptLine.branchId,
      lineId: poReceiptLine.lineId,
      headerBranchId: poReceiptLine.headerBranchId,
      headerId: poReceiptLine.headerId,
      statementType: 'Delete',
      lastUpdateNo: poReceiptLine.lastUpdateNo
    );

    try {

      CircularProgressLoaderDialog.showLoader(
          Get.context!, 'Deleting line, please wait...');
      var response = await client.put(URLs.createOrUpdatePOReceiptLine, body: request.toJson());
      var deleteResult = CudPOReceiptLineResponse.fromJson(response);
      Get.back();
      clearAllSelection();
      formState = AppFormState.NEW;
      showMessageDialog(mainMessage: deleteResult.message);
    } on NetworkException catch(e) {
      Get.back();
    }

  }

  void saveOrUpdate(POReceiptHeader headerInfo) {
    if (formState == AppFormState.NEW) {
      insertLine(headerInfo: headerInfo);
    } else if (formState == AppFormState.SAVED) {
      updateLine(headerInfo: headerInfo);
    }
  }

  void insertLine({POReceiptHeader? headerInfo}) async {
    var recdNowQuantity =
        double.tryParse(orderReceivedNowQuantityTextController.value.text);
    var request = CreatePOReceiptLineRequest(
        headerBranchId: headerInfo!.branchId,
        headerId: headerInfo.headerId,
        poLineBranchId: selectedPOLineNumber.value!.branchId,
        poLineId: selectedPOLineNumber.value!.lineId,
        itemBranchId: selectedItem.value!.branchId,
        itemId: selectedItem.value!.itemId,
        itemNumber: selectedItem.value!.itemNumber,
        uomBranchId: selectedPOLineNumber.value!.uomBranchId,
        uomId: selectedPOLineNumber.value!.uomId,
        uom: selectedPOLineNumber.value!.uom,
        orderedQuantity: selectedPOLineNumber.value!.orderedQuantity,
        recdNowQuantity: recdNowQuantity,
        recdNowUomBranchId: selectedPOLineNumber.value!.uomBranchId,
        recdNowUomId: selectedPOLineNumber.value!.uomId,
        unitCostVip: selectedPOLineNumber.value!.unitCostVip,
        unitCostVep: selectedPOLineNumber.value!.unitCostVep,
        tax: selectedPOLineNumber.value!.taxAmount,
        extCostVep: selectedPOLineNumber.value!.unitCostVep !* recdNowQuantity!,
        extCostVip: selectedPOLineNumber.value!.unitCostVip !* recdNowQuantity,
        extTax: selectedPOLineNumber.value!.unitCostVep !* recdNowQuantity,
        statementType: "Insert");

    var response = await client.put(URLs.createOrUpdatePOReceiptLine,
        body: request.toJson());

    try {
      CircularProgressLoaderDialog.showLoader(
          Get.context!, 'Creating line, please wait...');
      var response = await client.put(URLs.createOrUpdatePOReceiptLine,
          body: request.toJson());
      savedLineResult = CudPOReceiptLineResponse.fromJson(response);
      // createOrUpdatedLineResponse = RequisitionLineInfo.fromJson(response);
      Get.back();
      showMessageDialog(mainMessage: savedLineResult.message);
      handleFormAfterSave();
    } on NetworkException catch (e) {
      Get.back();
    }
  }

  void updateLine({POReceiptHeader? headerInfo}) async {
    var recdNowQuantity =
        double.tryParse(orderReceivedNowQuantityTextController.value.text);

    var poReceiptLines = await poReceiptLineLookupController.getPOReceiptLines(
        branchId: this.poReceiptLineInfo.poReceiptLineInfo!.branchId,
        lineId: this.poReceiptLineInfo.poReceiptLineInfo!.lineId,
        headerBranchId: this.poReceiptLineInfo.poReceiptLineInfo!.headerBranchId,
        headerId: this.poReceiptLineInfo.poReceiptLineInfo!.headerId,
        itemCode: this.poReceiptLineInfo.poReceiptLineInfo!.itemNumber,
        start: 1,
        limit: 1);

    var poReceiptLine = poReceiptLines!.data![0];

    var request = UpdatePOReceiptLineRequest(
        branchId: poReceiptLine.branchId,
        lineId: poReceiptLine.lineId,
        headerBranchId: headerInfo!.branchId,
        headerId: headerInfo.headerId,
        poLineBranchId: selectedPOLineNumber.value!.branchId,
        poLineId: selectedPOLineNumber.value!.lineId,
        itemBranchId: selectedItem.value!.branchId,
        itemId: selectedItem.value!.itemId,
        itemNumber: selectedItem.value!.itemNumber,
        uomBranchId: selectedPOLineNumber.value!.uomBranchId,
        uomId: selectedPOLineNumber.value!.uomId,
        uom: selectedPOLineNumber.value!.uom,
        orderedQuantity: selectedPOLineNumber.value!.orderedQuantity,
        recdNowQuantity: recdNowQuantity,
        recdNowUomBranchId: selectedPOLineNumber.value!.uomBranchId,
        recdNowUomId: selectedPOLineNumber.value!.uomId,
        unitCostVip: selectedPOLineNumber.value!.unitCostVip,
        unitCostVep: selectedPOLineNumber.value!.unitCostVep,
        tax: selectedPOLineNumber.value!.taxAmount,
        extCostVep: selectedPOLineNumber.value!.unitCostVep !* recdNowQuantity!,
        extCostVip: selectedPOLineNumber.value!.unitCostVip !* recdNowQuantity,
        extTax: selectedPOLineNumber.value!.unitCostVep !* recdNowQuantity,
        statementType: "Update",
        lastUpdateNo: poReceiptLine.lastUpdateNo);

    CircularProgressLoaderDialog.showLoader(
        Get.context!, 'Updating line, please wait...');

    try {
      var response = await client.put(URLs.createOrUpdatePOReceiptLine,
          body: request.toJson());
      Get.back();
      savedLineResult = CudPOReceiptLineResponse.fromJson(response);
      showMessageDialog(mainMessage: savedLineResult.message);
      handleFormAfterSave();
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
        // clearAllSelection();
        return;
      }
      if (itemsResponse.totalRecords == 1) {
        this.selectedItem.value = itemsResponse.data![0];
        return;
      }

      Get.to(BarCodeBasedItemLookupPage(
          onItemSelected: (selectedItem) {
            handleItemSelection(selectedItem);
          },
          scannedBarcode: barcodeScanResult));
    } on NetworkException catch (e) {
      Get.back();
    }
  }

  void handleItemSelection(Item selectedItem) {
    if (selectedItem.itemId == this.selectedItem.value?.itemId) return;

    this.selectedItem.value = selectedItem;
    this.selectedPOLineNumber.value = null;
    this.poLineNumberTextController.text = "";
    this.orderReceivedNowQuantityTextController.text = "";
  }

  void handleFormAfterSave() {
    if (isAddSelected) {
      clearAllSelection();
      formState = AppFormState.NEW;
      isAddSelected = false;
      return;
    }

    formState = AppFormState.SAVED;
  }

  void clearAllSelection() {
    selectedItem.value = null;
    selectedPOLineNumber.value = null;
    poLineNumberTextController.text = "";
    orderReceivedNowQuantityTextController.text = "";
  }

  bool validateForm() {
    this.isFormValid.value = true;
    itemValidation.setValid();
    poLineNumberValidation.setValid();
    orderReceivedNowQuantityValidation.setValid();

    if (selectedItem.value?.itemId == null) {
      itemValidation.setError('Required');
      this.isFormValid.value = false;
    }

    if (selectedPOLineNumber.value?.lineId == null) {
      poLineNumberValidation.setError('Required');
      this.isFormValid.value = false;
    }

    if (orderReceivedNowQuantityTextController.text == null ||
        orderReceivedNowQuantityTextController.text == '') {
      orderReceivedNowQuantityValidation.setError('Required');
      this.isFormValid.value = false;
    }

    return this.isFormValid.value;
  }
}
