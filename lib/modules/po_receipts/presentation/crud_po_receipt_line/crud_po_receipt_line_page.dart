import 'package:extra_pos/core/i18n/translation_titles.dart';
import 'package:extra_pos/core/utils/app_constants.dart';
import 'package:extra_pos/core/utils/date_time_utils.dart';
import 'package:extra_pos/core/widgets/action_bottom_bar/create_or_edit_part_bottom_bar.dart';
import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/inputs/app_selectable_input_field.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:extra_pos/core/widgets/inputs/app_two_action_input_field.dart';
import 'package:extra_pos/core/widgets/text/readonly_text.dart';
import 'package:extra_pos/modules/lookup/presentation/item_lookup/item_lookup_page.dart';
import 'package:extra_pos/modules/lookup/presentation/po_line_number_lookup/po_line_number_lookup_page.dart';
import 'package:extra_pos/modules/po_receipts/presentation/crud_po_receipt_line/crud_po_receipt_line_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CrudPOReceiptLinePage extends StatelessWidget {
  var controller = Get.put(CrudPOReceiptLineController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        bottomNavigationBar: CreateOrEditBottomBar(
          onCancelPressed: () {
            Get.back();
          },
          onDeletePressed: () {
            controller.handleDeleteClick();
          },
          onSavePressed: () {
            controller.handleSaveClick();
          },
          onAddPressed: () {
            controller.handleAddClick();
          },
        ),
        appBar: BaseAppBar(title: "Item", actions: [
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
          ),
        ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => ReadonlyText(
                isMultiline: false,
                title: 'Receipt No.',
                content:
                    controller.poReceiptHeader.value!.receiptNumber ?? '')),
            Obx(() => ReadonlyText(
                isMultiline: false,
                title: 'PO Number',
                content: controller.poReceiptHeader.value!.poNumber ?? '')),
            _buildMoreInfoUi(),
            Obx(() {
              return AppTwoActionInputField(
                  title: 'Item Code',
                  hint: '',
                  value: controller.selectedItem.value!.itemNumber ?? '',
                  errorText: controller.itemValidation.value.message,
                  primaryActionIcon: SvgPicture.asset(
                      'assets/images/action_icons/qr_scan.svg'),
                  secondaryActionIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  onPrimaryActionPressed: () {
                    Get.to(ItemLookupPage(onItemSelected: (selectedItem) {
                      controller.handleItemSelection(selectedItem);
                    }));
                  },
                  onSecondaryActionPressed: () async {
                    controller.openBarcodeScanner();
                  });
            }),
            Obx(() {
              var uom = controller.selectedItem.value!.itemBuyUom ?? controller.selectedItem.value!.itemSkuUom ?? '';
              return ReadonlyText(
                  isMultiline: true,
                  title: TT.readonly_text_uom_title.tr,
                  content: uom);
            }),
            Obx(() {
              return ReadonlyText(
                  isMultiline: true,
                  title: TT.readonly_text_item_description_title.tr,
                  content:
                      controller.selectedItem.value!.itemDescription ?? '');
            }),
            Obx(() => controller.selectedItem.value!.itemNumber != null
                ? AppSelectableInputField(
                    title: 'PO Line Number *',
                    hint: 'PO Line Number',
                    suffixIcon: Icon(Icons.search),
                    controller: controller.poLineNumberTextController,
                    errorText: controller.poLineNumberValidation.value.message,
                    enabled: controller.selectedItem.value!.itemNumber != null,
                    onTap: () {
                      Get.to(POLineNumberLookupPage(
                          headerId: controller.poReceiptHeader.value!.poHeaderId,
                          headerBranchId:
                              controller.poReceiptHeader.value!.poHeaderBranchId,
                          // Can be changed to itemId
                          itemCode: controller.selectedItem.value!.itemNumber,
                          itemId: controller.selectedItem.value!.itemId,
                          itemBranchId: controller.selectedItem.value!.branchId,
                          onPOLineNumberSelected: (selectedPOLineNumber) {
                            controller.poLineNumberTextController.text =
                                selectedPOLineNumber.itemNumber!;
                            controller.selectedPOLineNumber.value =
                                selectedPOLineNumber;
                          }));
                    },
                  )
                : Container()),
            Obx(() => controller.selectedPOLineNumber.value != null
                ? _buildLineInfoUi()
                : Container())
          ],
        ));
  }

  _buildMoreInfoUi() {
    return Container(
        child: Obx(() => controller.isMoreInfoSwitchOn.value
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: ReadonlyText(
                            isMultiline: true,
                            title: 'Branch',
                            content: controller
                                    .branchInfoController
                                    .branchInfoState
                                    .response
                                    .value
                                    .data
                                    ?.first
                                    .branchCode ??
                                '',
                          )),
                      Expanded(
                          flex: 1,
                          child: ReadonlyText(
                            isMultiline: true,
                            title: 'User',
                            content: controller.userInfoController.userInfoState
                                    .response.value.firstName ??
                                '',
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: ReadonlyText(
                            isMultiline: true,
                            title: 'Vendor Inv. No.',
                            content: controller
                                    .poReceiptHeader.value!.vendorInvoiceNo ??
                                '',
                          )),
                      Expanded(
                          flex: 1,
                          child: ReadonlyText(
                            isMultiline: true,
                            title: 'Recv. Date',
                            content: readableStringDateSlashddmmyyyy(controller
                                .poReceiptHeader.value!.receiptDate!),
                          ))
                    ],
                  )
                ],
              )
            : SizedBox()));
  }

  _buildLineInfoUi() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 1,
                child: ReadonlyText(
                  isMultiline: true,
                  title: 'Qty Ord.',
                  content: controller
                          .selectedPOLineNumber.value!.orderedQuantity
                          ?.toString() ??
                      '',
                )),
            Expanded(
                flex: 1,
                child: ReadonlyText(
                  isMultiline: true,
                  title: 'UoM',
                  content:
                      controller.selectedPOLineNumber.value!.uom?.toString() ??
                          'NA',
                ))
          ],
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: ReadonlyText(
                  isMultiline: true,
                  title: 'Qty. Backordered',
                  content: controller
                          .selectedPOLineNumber.value!.bkorderQuantity
                          ?.toString() ??
                      'NA',
                )),
            Expanded(
                flex: 1,
                child: ReadonlyText(
                  isMultiline: true,
                  title: 'Unit Price',
                  content: controller.selectedPOLineNumber.value!.unitCostVip
                          .toString(),
                ))
          ],
        ),
        AppTextInputField(
          inputFormatters: [
            AppConstants.quantityInputRegex,
          ],
          keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
          value: controller.orderReceivedNowQuantityTextController.value.text,
          controller: controller.orderReceivedNowQuantityTextController,
          errorText: controller.orderReceivedNowQuantityValidation.value.message,
          title: 'Ord Recv.'
        )
      ],
    );
  }
}
