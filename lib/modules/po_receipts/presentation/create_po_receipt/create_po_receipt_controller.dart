import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_constants.dart';
import 'package:extra_pos/core/utils/app_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/core/utils/validation_message.dart';
import 'package:extra_pos/core/widgets/dialogs/circular_progress_loader_dialog.dart';
import 'package:extra_pos/modules/lookup/data/po_number_lookup/po_number_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/tolerance_code_lookup/tolerance_code_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/vendor_branch_lookup/vendor_branch_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/vendor_lookup/vendor_lookup_response.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/user_info_controller.dart';
import 'package:extra_pos/modules/po_receipts/data/create_po_receipt/create_po_receipt_request.dart';
import 'package:extra_pos/modules/po_receipts/data/create_po_receipt/create_po_receipt_response.dart';
import 'package:extra_pos/modules/po_receipts/data/crud_po_receipt_line/info_for_po_line_crud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extra_pos/extensions.dart';

class CreatePoReceiptController extends GetxController {
  var client = Get.find<BaseApiClient>();

  var userInfoController = Get.put(UserInfoController());
  var branchInfoController = Get.put(BranchInfoController());

  var createPoReceiptHeaderState = AppState<CreatePOReceiptHeaderResponse>();

  var isMoreInfoSwitchOn = AppConstants.isMoreInfoSwitchOn.obs;

  var isAllowBackOrderSelected = RxBool(null!);
  var branchController = TextEditingController();
  var vendorInvoiceNumberController = TextEditingController();
  var vendorInvoiceAmountController = TextEditingController();
  var vendorTextController = TextEditingController();
  var vendorBranchTextController = TextEditingController();
  var poNumberTextController = TextEditingController();
  var toleranceCodeTextController = TextEditingController();

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
      this.isAllowBackOrderSelected.value = true;
    else
      this.isAllowBackOrderSelected.value != null;
  }

  @override
  void onInit() async {
    userInfoController.getUserInfoAndNotify();
    branchInfoController.getBranchInfoAndNotify();
    var currentBranch = await branchInfoController.getCurrentBranchInfo();
    branchController.text = currentBranch.data![0].branchCode!;
    super.onInit();
  }

  void savePOHeaderAndContinue() async {
    if (!validateForm()) {
      return;
    }

    createPoReceiptHeaderState.notifyLoading();
    CircularProgressLoaderDialog.showLoader(
        Get.context!, 'Creating PO Receipt, please wait...');
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

      var request = CreatePOReceiptRequest(
          poReceiptHeader: PoReceiptHeader(
              receivingBranchId: currentBranchId,
              receiptStatus: "OPEN",
              allowBackorders: allowBackOrders,
              // To be changed
              vendorBranchId: selectedVendor.value!.branchId,
              vendorId: selectedVendor.value!.vendorId,
              vendorSiteBranchId: selectedVendorBranch.value!.branchId,
              vendorSiteId: selectedVendorBranch.value!.vendorSiteId,
              vendorInvoiceNo: vendorInvoiceNumberController.text,
              invoiceAmount: int.parse(vendorInvoiceAmountController.text),
              receiptDate: selectedReceivedDate.value!.toIso8601String(),
              vendorInvoiceDate:
                  selectedVendorInvoiceDate.value!.toIso8601String(),
              poHeaderBranchId: selectedPONumber.value!.poHeaderBranchId,
              poHeaderId: selectedPONumber.value!.poHeaderId,
              poNumber: selectedPONumber.value!.poNumber,
              toleranceBranchId: selectedToleranceCode.value!.branchId,
              toleranceId: selectedToleranceCode.value!.toleranceId,
              toleranceCode: selectedToleranceCode.value!.toleranceCode,
              statementType: "INSERT",
              reqSource: "MOBILE"),
          poReceiptLines: []);
      var response = await client.put(URLs.createOrUpdatePOReceiptHeaderUrl,
          body: request.toJson());
      var res = CreatePOReceiptHeaderResponse.fromJson(response);
      createPoReceiptHeaderState.notifyCompleted(res);
      Get.back();

      var poReceiptInfo = InfoForPOReceiptLineCrud(
          poReceiptHeaderInfo: PoReceiptHeaderInfo(
              headerId: res.headerId, branchId: res.branchId));

      Get.offNamed(Routes.crudPoReceiptLineItem,
          arguments: poReceiptInfo.toJson());
    } on NetworkException catch (e) {
      Get.back();
      createPoReceiptHeaderState.notifyError(e.getErrorMessage());
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

  String getAllowBackOrders() {
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

    return allowBackOrders;
  }
}
