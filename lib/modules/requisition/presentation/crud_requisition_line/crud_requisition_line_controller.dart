import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_constants.dart';
import 'package:extra_pos/core/utils/debounce.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/core/utils/validation_message.dart';
import 'package:extra_pos/core/widgets/dialogs/circular_progress_loader_dialog.dart';
import 'package:extra_pos/core/widgets/dialogs/message_dialog.dart';
import 'package:extra_pos/modules/lookup/data/branch_info_response.dart';
import 'package:extra_pos/modules/lookup/data/item_lookup/items_response.dart';
import 'package:extra_pos/modules/lookup/data/requisition_header_lookup/requisition_header_response.dart';
import 'package:extra_pos/modules/lookup/data/uom_item_based_lookup/uom_item_based_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/user_info_response.dart';
import 'package:extra_pos/modules/lookup/presentation/barcode_based_item_lookup/barcode_based_item_lookup_page.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/item_based_uom_lookup/uom_item_based_lookup_page.dart';
import 'package:extra_pos/modules/lookup/presentation/item_lookup/item_lookup_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/requisition_header_lookup/requisition_header_lookup_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/requisition_line_lookup/requisition_line_lookup_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/user_info_controller.dart';
import 'package:extra_pos/modules/requisition/data/crud_requisition_line/create_requisition_line_request.dart';
import 'package:extra_pos/modules/requisition/data/crud_requisition_line/cud_requisition_line_response.dart';
import 'package:extra_pos/modules/requisition/data/crud_requisition_line/delete_requisition_line_request.dart';
import 'package:extra_pos/modules/requisition/data/crud_requisition_line/trn_line_info.dart';
import 'package:extra_pos/modules/requisition/data/crud_requisition_line/update_requisition_line_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:extra_pos/extensions.dart';

class CrudRequisitionLineController extends GetxController {
  var client = Get.find<BaseApiClient>();
  var userInfoController = Get.find<UserInfoController>();
  var branchInfoController = Get.find<BranchInfoController>();
  var itemLookupController = Get.put(ItemLookupController());
  var requisitionHeaderLookupController =
      Get.put(RequisitionHeaderLookupController());
  var requisitionLineLookupController =
      Get.put(RequisitionLineLookupController());

  var userInfo = UserInfoResponse().obs;
  var branchInfo = BranchInfo().obs;

  // Extra data from other page to create/update line
  var rqnInfo = InfoForRequisitionLineCrud();

  // To keep the user selected data
  var selectedItem = Item().obs;
  var quantityTextController = TextEditingController();
  var selectedUom = UomItemBased().obs;
  var uomTextController = TextEditingController();

  // Validations
  var itemValidation = ValidationMessage().obs;
  var quantityValidation = ValidationMessage().obs;
  var uomValidation = ValidationMessage().obs;

  bool isAddSelected = false;

  var savedLineResult = CudRequisitionLineResponse();

  var isMoreInfoSwitchOn = AppConstants.isMoreInfoSwitchOn.obs;

  // This variable is to know weather the record is saved already
  RequisitionLineInfo? createOrUpdatedLineResponse;

  var formState = AppFormState.NEW;

  setMoreInfoSwitchState(bool value) {
    this.isMoreInfoSwitchOn.value = value;
  }

  @override
  void onInit() async {

    var arguments = Get.arguments;
    var rqnInfo = InfoForRequisitionLineCrud.fromJson(arguments);
    this.rqnInfo = rqnInfo;

    // Checking for extra data given to this page
    // If the line info is null the page is opened from the create requisition page
    // and If the line info has data, the page is open from the line info page
    if (rqnInfo.lineInfo != null) {
      // Updating form state to saved because the request comes from line info page
      formState = AppFormState.SAVED;

      Debouncer(milliseconds: 10).run(() {
        selectedItem.value = Item(
          branchId: rqnInfo.lineInfo!.itemBranchId,
          itemId: rqnInfo.lineInfo!.itemId,
          itemNumber: rqnInfo.lineInfo!.itemNumber,
          itemDescription: rqnInfo.lineInfo!.itemDescription,
          stockOnHand: rqnInfo.lineInfo!.noOfWeekStock,
          noOfWeeksStock: rqnInfo.lineInfo!.noOfWeekStock,
          itemSaleUom: rqnInfo.lineInfo!.uom,
        );

        quantityTextController.text = rqnInfo.lineInfo!.quantity.toString();

        uomTextController.text = rqnInfo.lineInfo!.uom!;
        selectedUom.value = UomItemBased(
            uomBranchId: rqnInfo.lineInfo!.uomBranchId,
            uomId: rqnInfo.lineInfo!.uomId,
            uom: rqnInfo.lineInfo!.uom);

        savedLineResult = CudRequisitionLineResponse(
            branchId: rqnInfo.lineInfo!.branchId,
            headerId: rqnInfo.lineInfo!.headerId,
            headerBranchId: rqnInfo.lineInfo!.headerBranchId,
            lineId: rqnInfo.lineInfo!.lineId);
      });
    }

    if (rqnInfo.trnInfo != null) {
      userInfo.value.userName = rqnInfo.trnInfo!.userName;
      branchInfo.value.branchCode = rqnInfo.trnInfo!.branchCode;
    }
    // Get the current user and branch because if the line info is not null, user is creating a line and not updating
    else {
      userInfo.value = (await userInfoController.getUserInfo())!;
      var branchInfo = await branchInfoController.getCurrentBranchInfo();
      if(branchInfo.data!.length <= 0) return;
      this.branchInfo.value = branchInfo.data![0];
    }

    super.onInit();
  }

  void handleSaveClick() async {
    if (!validateForm()) {
      return;
    }

    var headersResponse =
        await requisitionHeaderLookupController.getRequisition(
            headerId: rqnInfo.trnInfo!.headerId,
            branchId: rqnInfo.trnInfo!.branchId,
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
        await requisitionHeaderLookupController.getRequisition(
            headerId: rqnInfo.trnInfo!.headerId,
            branchId: rqnInfo.trnInfo!.branchId,
            start: 1,
            limit: 1);
    if (headersResponse!.data!.length <= 0) {
      return;
    }

    var lines = await requisitionLineLookupController.getRequisitionLine(
        lineId: savedLineResult.lineId,
        branchId: savedLineResult.branchId,
        headerId: savedLineResult.headerId,
        headerBranchId: savedLineResult.headerBranchId,
        start: 1,
        limit: 1);

    if (lines!.data!.length <= 0) {
      return;
    }

    var request = DeleteRequisitionLineRequest(
        branchId: savedLineResult.branchId,
        lineId: savedLineResult.lineId,
        headerBranchId: savedLineResult.headerBranchId,
        headerId: savedLineResult.headerId,
        statementType: "Delete",
        lastUpdateNo: lines.data![0].lastUpdateNo);

    try {

      CircularProgressLoaderDialog.showLoader(
          Get.context!, 'Deleting line, please wait...');
      var response = await client.put(URLs.crudRequisitionLine, body: request.toJson());
      var deleteResult = CudRequisitionLineResponse.fromJson(response);
      Get.back();
      clearAllSelection();
      formState = AppFormState.NEW;
      showMessageDialog(mainMessage: deleteResult.message);
    } on NetworkException catch(e) {
      Get.back();
    }

  }

  void saveOrUpdate(RequisitionHeader headerInfo) {
    if (formState == AppFormState.NEW) {
      insertLine(headerInfo: headerInfo);
    } else if (formState == AppFormState.SAVED) {
      updateLine(headerInfo: headerInfo);
    }
  }

  void insertLine({headerInfo: RequisitionHeader}) async {
    var request = CreateRequisitionLineRequest(
        headerBranchId: headerInfo.branchId,
        headerId: headerInfo.headerId,
        itemBranchId: selectedItem.value.branchId,
        itemId: selectedItem.value.itemId,
        uomBranchId: selectedUom.value.uomBranchId,
        uomId: selectedUom.value.uomId,
        quantity: double.parse(quantityTextController.text),
        statementType: 'Insert');

    try {
      CircularProgressLoaderDialog.showLoader(
          Get.context!, 'Creating line, please wait...');
      var response =
          await client.put(URLs.crudRequisitionLine, body: request.toJson());
      savedLineResult = CudRequisitionLineResponse.fromJson(response);
      createOrUpdatedLineResponse = RequisitionLineInfo.fromJson(response);
      Get.back();
      showMessageDialog(mainMessage: savedLineResult.message);
      handleFormAfterSave();
    } on NetworkException catch (e) {
      Get.back();
    }
  }

  void updateLine({headerInfo: RequisitionHeader}) async {
    var lines = await requisitionLineLookupController.getRequisitionLine(
        lineId: savedLineResult.lineId,
        branchId: savedLineResult.branchId,
        headerId: savedLineResult.headerId,
        headerBranchId: savedLineResult.headerBranchId,
        start: 1,
        limit: 1);

    if (lines!.data!.length <= 0) return;

    var line = lines.data![0];

    var request = UpdateRequisitionLineRequest(
        lineId: savedLineResult.lineId,
        branchId: savedLineResult.branchId,
        headerId: savedLineResult.headerId,
        headerBranchId: savedLineResult.headerBranchId,
        itemId: selectedItem.value.itemId,
        itemBranchId: selectedItem.value.branchId,
        itemNumber: selectedItem.value.itemNumber,
        quantity: double.parse(quantityTextController.text),
        uomId: selectedUom.value.uomId,
        uomBranchId: selectedUom.value.uomBranchId,
        uom: selectedUom.value.uom,
        statementType: 'Update',
        lastUpdateNo: line.lastUpdateNo);

    CircularProgressLoaderDialog.showLoader(
        Get.context!, 'Updating line, please wait...');

    try {
      var response =
          await client.put(URLs.crudRequisitionLine, body: request.toJson());
      Get.back();
      savedLineResult = CudRequisitionLineResponse.fromJson(response);
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
        clearAllSelection();
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
    if (selectedItem.itemId == this.selectedItem.value.itemId) return;

    this.selectedItem.value = selectedItem;
    this.selectedUom.value = UomItemBased();
    uomTextController.text = '';
    this.quantityTextController.text = '';
  }

  void handleUomSelection() async {
    if (selectedItem.value.itemId == null) {
      await showMessageDialog(
          type: MessageDialogType.WARNING,
          mainMessage: 'Please select an Item to choose UoM',
          closeAfterDelay: false);
      return;
    }
    Get.to(UomItemBasedLookupPage(
        itemInfo: selectedItem.value,
        onUomSelected: (selectedUom) {
          uomTextController.text = selectedUom.uom!;
          this.selectedUom.value = selectedUom;
        }));
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
    selectedItem.value = Item();
    quantityTextController.text = '';
    uomTextController.text = '';
    selectedUom.value = UomItemBased();
  }

  bool validateForm() {
    var isFormValid = true;
    itemValidation.setValid();
    quantityValidation.setValid();
    uomValidation.setValid();

    if (selectedItem.value.itemId == null) {
      itemValidation.setError('Required');
      isFormValid = false;
    }

    if (quantityTextController.text == null ||
        quantityTextController.text == '') {
      quantityValidation.setError('Required');
      isFormValid = false;
    }

    if (selectedUom.value.uomId == null) {
      uomValidation.setError('Required');
      isFormValid = false;
    }

    return isFormValid;
  }
}

enum AppFormState { NEW, SAVED }
