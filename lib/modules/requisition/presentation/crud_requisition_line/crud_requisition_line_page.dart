import 'package:extra_pos/core/i18n/translation_titles.dart';
import 'package:extra_pos/core/utils/app_constants.dart';
import 'package:extra_pos/core/widgets/action_bottom_bar/create_or_edit_part_bottom_bar.dart';
import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/inputs/app_selectable_input_field.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:extra_pos/core/widgets/inputs/app_two_action_input_field.dart';
import 'package:extra_pos/core/widgets/text/readonly_text.dart';
import 'package:extra_pos/modules/lookup/presentation/item_lookup/item_lookup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'crud_requisition_line_controller.dart';

class CrudRequisitionLinePage extends StatelessWidget {
  var controller = Get.find<CrudRequisitionLineController>();

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
        appBar: BaseAppBar(title: TT.appbar_title_create_part.tr, actions: [
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
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReadonlyText(
                    isMultiline: false,
                    title: TT.readonly_text_trn_title.tr,
                    content: controller.rqnInfo.trnInfo!.trn),
                _buildMoreInfoUi(),
                Obx(() {
                  return AppTwoActionInputField(
                      title: 'Part Number',
                      hint: 'Part Number / Barcode',
                      value: controller.selectedItem.value.itemNumber,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Obx(() {
                          return ReadonlyText(
                              isMultiline: true,
                              title: TT.readonly_text_barcode_title.tr,
                              content:
                                  controller.selectedItem.value.barCode ?? '');
                        })),
                    Expanded(
                      flex: 1,
                      child: Obx(() {
                        return ReadonlyText(
                            isMultiline: true,
                            title: TT.readonly_text_uom_title.tr,
                            content:
                                controller.selectedItem?.value?.itemSaleUom ??
                                    '');
                      }),
                    ),
                  ],
                ),
                Obx(() {
                  return ReadonlyText(
                      isMultiline: true,
                      title: TT.readonly_text_item_description_title.tr,
                      content:
                          controller.selectedItem?.value?.itemDescription ??
                              '');
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Obx(() {
                        return ReadonlyText(
                            isMultiline: true,
                            title: TT.readonly_text_avg_sales_per_week_title.tr,
                            content: controller
                                    .selectedItem?.value?.stockOnHand
                                    ?.toString() ??
                                '');
                      }),
                    ),
                    Expanded(
                        flex: 1,
                        child: Obx(() {
                          return ReadonlyText(
                              isMultiline: true,
                              title: TT.readonly_text_stock_in_hand_title.tr,
                              content: controller
                                      .selectedItem?.value?.stockOnHand
                                      ?.toString() ??
                                  '');
                        })),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Obx(() => AppTextInputField(
                          inputFormatters: [
                            AppConstants.quantityInputRegex,
                          ],
                          keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                          value: controller.quantityTextController.value.text,
                          controller: controller.quantityTextController,
                          errorText: controller.quantityValidation.value.message,
                          title: 'Enter Qty to Order',
                          hint: 'Enter Qty to Order',
                        )),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.only(right: 8),
                          child: Obx(() => AppSelectableInputField(
                              title: 'Req. UoM',
                              hint: 'Req. UoM',
                              controller: controller.uomTextController,
                              errorText: controller.uomValidation.value.message,
                              onTap: () {
                                controller.handleUomSelection();

                              }))),
                    ),
                  ],
                )
              ],
            ),
          ],
        ));
  }

  _buildMoreInfoUi() {
    return Container(
        child: Obx(() => controller.isMoreInfoSwitchOn.value
            ? Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ReadonlyText(
                        isMultiline: true,
                        title: 'Branch',
                        content: controller.branchInfo.value.branchCode ??
                            '',
                      )),
                  Expanded(
                      flex: 1,
                      child: ReadonlyText(
                        isMultiline: true,
                        title: 'User',
                        content: controller.userInfo.value.userName ??
                            '',
                      ))
                ],
              )
            : SizedBox()));
  }
}
