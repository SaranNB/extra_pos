import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_constants.dart';
import 'package:extra_pos/core/utils/app_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/core/utils/validation_message.dart';
import 'package:extra_pos/core/widgets/dialogs/circular_progress_loader_dialog.dart';
import 'package:extra_pos/modules/lookup/data/po_number_lookup/po_number_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/po_receipt_header_lookup/po_receipt_header_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/tolerance_code_lookup/tolerance_code_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/vendor_branch_lookup/vendor_branch_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/vendor_lookup/vendor_lookup_response.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/po_receipt_header_lookup/po_receipt_header_lookup_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/user_info_controller.dart';
import 'package:extra_pos/modules/po_receipts/data/edit_po_receipt/edit_po_receipt_request.dart';
import 'package:extra_pos/modules/po_receipts/data/edit_po_receipt/edit_po_receipt_response.dart';
import 'package:extra_pos/modules/po_receipts/data/crud_po_receipt_line/info_for_po_line_crud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extra_pos/extensions.dart';

class EditPoReceiptController extends GetxController {
  var client = Get.find<BaseApiClient>();

  var userInfoController = Get.put(UserInfoController());
  var branchInfoController = Get.put(BranchInfoController());
  var headerLookupController = Get.put(POReceiptHeaderLookupController());

  var updatePoReceiptHeaderState = AppState<UpdatePOReceiptHeaderResponse>();

  var poReceiptInfo = POReceiptHeader.fromJson(Get.arguments).obs;

  var isMoreInfoSwitchOn = AppConstants.isMoreInfoSwitchOn.obs;

  var isAllowBackOrderSelected = RxBool(null!);
  var branchController = TextEditingController();
  var vendorInvoiceNumberController = TextEditingController();
  var vendorInvoiceAmountController = TextEditingController();
  var vendorTextController = TextEditingController();
  var vendorBranchTextController = TextEditingController();
  var poNumberTextController = TextEditingController();
  var toleranceCodeTextController = TextEditingController();
  var attentionNameTextController = TextEditingController();
  var attentionPhoneTextController = TextEditingController();

  var selectedVendor = Rx<Vendor?>(null);
  var selectedVendorBranch = Rx<VendorBranch?>(null);
  var selectedPONumber = Rx<PONumber?>(null);
  var selectedReceivedDate = Rx<DateTime?>(null);
  var selectedVendorInvoiceDate = Rx<DateTime?>(null);
  var selectedToleranceCode = Rx<ToleranceCode?>(null);

  // Validations
  var vendorInvoiceNumberValidation = ValidationMessage().obs;
  var vendorInvoiceAmountValidation = ValidationMessage().obs;
  var vendorValidation = ValidationMessage().obs;
  var vendorBranchValidation = ValidationMessage().obs;
  var poNumberValidation = ValidationMessage().obs;
  var receivedDateValidation = ValidationMessage().obs;
  var vendorInvoiceDateValidation = ValidationMessage().obs;

  setMoreInfoSwitchState(bool value) {
    this.isMoreInfoSwitchOn.value = value;
    if (value)
      this.isAllowBackOrderSelected.value != true;
    else
      this.isAllowBackOrderSelected.value != null;
  }

  @override
  void onInit() async {
    userInfoController.getUserInfoAndNotify();
    branchInfoController.getBranchInfoAndNotify();
    var currentBranch = await branchInfoController.getCurrentBranchInfo();
    branchController.text = currentBranch.data![0].branchCode!;
    var result = await headerLookupController.getPOReceiptHeaders(
        start: 1,
        limit: 1,
        headerId: poReceiptInfo.value.headerId,
        branchId: poReceiptInfo.value.branchId);
    poReceiptInfo.value = result!.data![0];
    initializeHeaderData(poReceiptInfo.value);
    super.onInit();
  }

  void initializeHeaderData(POReceiptHeader header) {
    vendorInvoiceNumberController.text = header.vendorInvoiceNo!;
    vendorInvoiceAmountController.text = header.invoiceAmount.toString();
    vendorTextController.text = header.vendorName!;
    vendorBranchTextController.text = header.vendorSiteName!;
    poNumberTextController.text = header.poNumber!;
    toleranceCodeTextController.text = header.toleranceCode!;

    selectedVendor.value = Vendor();
    selectedVendor.value!.vendorId = header.vendorId;
    selectedVendor.value!.vendorName = header.vendorName;

    selectedVendorBranch.value = VendorBranch();
    selectedVendorBranch.value!.branchId = header.vendorSiteBranchId;
    selectedVendorBranch.value!.vendorSiteId = header.vendorSiteId;

    selectedPONumber.value = PONumber();
    selectedPONumber.value!.poHeaderBranchId = header.poHeaderBranchId;
    selectedPONumber.value!.poHeaderId = header.poHeaderId;
    selectedPONumber.value!.poNumber = header.poNumber;

    selectedToleranceCode.value = ToleranceCode();
    selectedToleranceCode.value!.branchId = header.toleranceBranchId;
    selectedToleranceCode.value!.toleranceId = header.toleranceId;
    selectedToleranceCode.value!.toleranceCode = header.toleranceCode;

    attentionNameTextController.text = header.attentionName!;
    attentionPhoneTextController.text = header.attentionPhone!;

    selectedReceivedDate.value = DateTime.parse(header.receiptDate!);
    selectedVendorInvoiceDate.value = DateTime.parse(header.vendorInvoiceDate!);
  }

  void updatePOHeaderAndContinue() async {
    if (!validateForm()) {
      return;
    }

    updatePoReceiptHeaderState.notifyLoading();
    CircularProgressLoaderDialog.showLoader(
        Get.context!, 'Updating PO Receipt, please wait...');
    try {
      var currentBranch = await branchInfoController.getCurrentBranchInfo();
      var currentBranchId = currentBranch.data![0].branchId;
      var allowBackOrders = 'Y';
      if (this.isAllowBackOrderSelected.value != null) {
        if (this.isAllowBackOrderSelected.value) {
          allowBackOrders = 'Y';
        } else {
          allowBackOrders = 'N';
        }
      } else {
        allowBackOrders = "N";
      }

      var request = UpdatePOReceiptHeaderRequest(
          poReceiptHeader: PoReceiptHeader(
              branchId: poReceiptInfo.value.branchId,
              headerId: poReceiptInfo.value.headerId,
              vendorInvoiceNo: vendorInvoiceNumberController.text,
              invoiceAmount: double.parse(vendorInvoiceAmountController.text),
              toleranceCode: selectedToleranceCode.value!.toleranceCode,
              attentionName: attentionNameTextController.text,
              attentionPhone: attentionPhoneTextController.text,
              statementType: "UPDATE",
              lastUpdateNo: poReceiptInfo.value.lastUpdateNo,
              allowBackorders: allowBackOrders,
              receiptDate: selectedReceivedDate.value!.toIso8601String(),
              vendorInvoiceDate:
                  selectedVendorInvoiceDate.value!.toIso8601String(),
              reqSource: "MOBILE"),
          poReceiptLines: []);
      var response = await client.put(URLs.createOrUpdatePOReceiptHeaderUrl,
          body: request.toJson());
      var res = UpdatePOReceiptHeaderResponse.fromJson(response);
      updatePoReceiptHeaderState.notifyCompleted(res);
      Get.back();

      var info = InfoForPOReceiptLineCrud(
          poReceiptHeaderInfo: PoReceiptHeaderInfo(
              headerId: res.headerId, branchId: res.branchId));

      Get.offNamed(Routes.crudPoReceiptLineItem, arguments: info.toJson());
    } on NetworkException catch (e) {
      Get.back();
      updatePoReceiptHeaderState.notifyError(e.getErrorMessage());
    }
  }

  bool validateForm() {
    var isFormValid = true;
    vendorInvoiceNumberValidation.setValid();
    vendorInvoiceAmountValidation.setValid();
    vendorValidation.setValid();
    vendorBranchValidation.setValid();
    poNumberValidation.setValid();
    receivedDateValidation.setValid();

    if (vendorInvoiceNumberController.value.text.isBlank!) {
      vendorInvoiceNumberValidation.setError('Required');
      isFormValid = false;
    }

    if (vendorInvoiceAmountController.value.text.isBlank!) {
      vendorInvoiceAmountValidation.setError('Required');
      isFormValid = false;
    }

    if (selectedVendor.value == null) {
      vendorValidation.setError('Required');
      isFormValid = false;
    }

    if (selectedVendorBranch.value == null) {
      vendorBranchValidation.setError('Required');
      isFormValid = false;
    }

    if (selectedPONumber.value == null) {
      poNumberValidation.setError('Required');
      isFormValid = false;
    }

    if (selectedReceivedDate.value == null) {
      receivedDateValidation.setError('Required');
      isFormValid = false;
    }

    if (selectedVendorInvoiceDate.value == null) {
      vendorInvoiceDateValidation.setError('Required');
      isFormValid = false;
    }

    return isFormValid;
  }
}
