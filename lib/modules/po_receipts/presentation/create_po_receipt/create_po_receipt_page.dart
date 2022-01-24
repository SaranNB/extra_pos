import 'package:extra_pos/core/i18n/translation_titles.dart';
import 'package:extra_pos/core/widgets/action_bottom_bar/create_header_bottom_bar.dart';
import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/inputs/app_date_picker.dart';
import 'package:extra_pos/core/widgets/inputs/app_selectable_input_field.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:extra_pos/core/widgets/text/readonly_text.dart';
import 'package:extra_pos/modules/lookup/presentation/po_number_lookup/po_number_lookup_page.dart';
import 'package:extra_pos/modules/lookup/presentation/tolerance_code_lookup/tolerance_code_lookup_page.dart';
import 'package:extra_pos/modules/lookup/presentation/vendor_branch_lookup/vendor_branch_lookup_page.dart';
import 'package:extra_pos/modules/lookup/presentation/vendor_lookup/vendor_lookup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_po_receipt_controller.dart';

class CreatePOReceiptPage extends StatelessWidget {
  late CreatePoReceiptController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(CreatePoReceiptController());

    return BaseScaffold(
      bottomNavigationBar: CreateHeaderBottomBar(
        onCancelPressed: () {
          Get.back();
        },
        onSaveAndContinuePressed: () {
          controller.savePOHeaderAndContinue();
        },
      ),
      appBar: BaseAppBar(title: TT.appbar_title_po_receipt.tr, actions: [
        Row(
          children: [
            Text('More info'),
            Obx(() {
              return Switch(
                  value: controller.isMoreInfoSwitchOn.value,
                  onChanged: (value) {
                    controller.setMoreInfoSwitchState(value);
                  });
            })
          ],
        )
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReadonlyText(
              isMultiline: false,
              title: TT.readonly_text_receipt_no.tr,
              content: 'N/A'),
          _buildGeneralInfoUi(),
          _buildMoreInfoUi(),
          _buildInputUi()
        ],
      ),
    );
  }

  _buildGeneralInfoUi() {
    return Obx(() => Row(
          children: [
            Expanded(
                flex: 1,
                child: ReadonlyText(
                  isMultiline: true,
                  title: 'Branch',
                  content: controller.branchInfoController.branchInfoState
                          .response.value.data?.first.branchCode ??
                      '',
                )),
            Expanded(
                flex: 1,
                child: ReadonlyText(
                  isMultiline: true,
                  title: 'User',
                  content: controller.userInfoController.userInfoState.response
                          .value.firstName ??
                      '',
                ))
          ],
        ));
  }

  _buildMoreInfoUi() {
    return Container(
        child: Obx(() => controller.isMoreInfoSwitchOn.value
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: controller.isAllowBackOrderSelected.value,
                    onChanged: (bool? value) {
                      controller.isAllowBackOrderSelected.value = value!;
                    },
                  ),
                  Text('Allow Back Orders',
                      style: TextStyle(color: Color(0xff3D404E), fontSize: 16))
                ],
              )
            : SizedBox()));
  }

  _buildInputUi() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextInputField(
            title: 'Branch',
            enabled: false,
            controller: controller.branchController),
        Obx(() => AppTextInputField(
            title: 'Vendor Invoice No. *',
            hint: 'Vendor Invoice No.',
            controller: controller.vendorInvoiceNumberController,
            errorText: controller.vendorInvoiceNumberValidation.value.message)),
        Obx(() => AppTextInputField(
            title: 'Vendor Invoice Amount. *',
            hint: 'Vendor Invoice Amount.',
            keyboardType: TextInputType.numberWithOptions(signed: false),
            controller: controller.vendorInvoiceAmountController,
            errorText: controller.vendorInvoiceAmountValidation.value.message)),
        Obx(() => AppSelectableInputField(
              title: 'Vendor *',
              hint: 'Vendor',
              suffixIcon: Icon(Icons.search),
              controller: controller.vendorTextController,
              errorText: controller.vendorValidation.value.message,
              onTap: () {
                controller.selectedVendorBranch.value != null;
                controller.vendorBranchTextController.text = '';
                controller.selectedPONumber.value != null;
                controller.poNumberTextController.text = "";
                Get.to(VendorLookupPage(onVendorSelected: (selectedVendor) {
                  controller.vendorTextController.text =
                      selectedVendor.vendorName!;
                  controller.selectedVendor.value = selectedVendor;
                }));
              },
            )),
        Obx(() => AppSelectableInputField(
              title: 'Vendor Branch *',
              hint: 'Vendor Branch',
              suffixIcon: Icon(Icons.search),
              controller: controller.vendorBranchTextController,
              errorText: controller.vendorBranchValidation.value.message,
              enabled: controller.selectedVendor.value != null,
              onTap: () {
                var vendor = controller.selectedVendor.value;
                controller.selectedPONumber.value != null;
                controller.poNumberTextController.text = "";
                Get.to(VendorBranchLookupPage(
                    vendorId: vendor!.vendorId,
                    vendorBranchId: vendor.branchId,
                    onVendorBranchSelected: (selectedVendorBranch) {
                      controller.vendorBranchTextController.text =
                          selectedVendorBranch.vendorSiteName!;
                      controller.selectedVendorBranch.value =
                          selectedVendorBranch;
                    }));
              },
            )),
        Obx(() => AppSelectableInputField(
              title: 'PO Number *',
              hint: 'PO Number',
              suffixIcon: Icon(Icons.search),
              controller: controller.poNumberTextController,
              errorText: controller.poNumberValidation.value.message,
              enabled: controller.selectedVendorBranch.value != null,
              onTap: () {
                var vendor = controller.selectedVendor.value;
                var vendorBranch = controller.selectedVendorBranch.value;
                Get.to(PONumberLookupPage(
                    vendorBranchId: vendor!.branchId,
                    vendorId: vendor.vendorId,
                    vendorSiteBranchId: vendorBranch!.branchId,
                    vendorSiteId: vendorBranch.vendorSiteId,
                    allowBackOrders: controller.getAllowBackOrders(),
                    onPONumberSelected: (selectedPONumber) {
                      controller.poNumberTextController.text =
                          selectedPONumber.poNumber!;
                      controller.selectedPONumber.value = selectedPONumber;
                    }));
              },
            )),
        Obx(() => AppDatePickerField(
              title: 'Recv Date *',
              hint: 'Recv Date',
              errorText: controller.receivedDateValidation.value.message,
              date: controller.selectedReceivedDate.value,
              onChanged: (DateTime selectedDate) {
                controller.selectedReceivedDate.value = selectedDate;
              },
            )),
        Obx(() => AppDatePickerField(
              title: 'Vendor Invoice Date *',
              hint: 'Vendor Invoice Date',
              errorText: controller.vendorInvoiceDateValidation.value.message,
              date: controller.selectedVendorInvoiceDate.value,
              onChanged: (DateTime selectedDate) {
                controller.selectedVendorInvoiceDate.value = selectedDate;
              },
            )),
        AppSelectableInputField(
          title: 'Tolerance Code',
          hint: 'Tolerance Code',
          suffixIcon: Icon(Icons.search),
          controller: controller.toleranceCodeTextController,
          onTap: () {
            Get.to(ToleranceCodeLookupPage(
                onToleranceCodeSelected: (selectedToleranceCode) {
              controller.toleranceCodeTextController.text =
                  selectedToleranceCode.toleranceCode!;
              controller.selectedToleranceCode.value = selectedToleranceCode;
            }));
          },
        )
      ],
    );
  }
}
