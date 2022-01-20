import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/utils/date_time_utils.dart';
import 'package:extra_pos/core/widgets/action_bottom_bar/review_po_receipt_bottom_bar.dart';
import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/bottom_sheet/info_bottom_sheet.dart';
import 'package:extra_pos/core/widgets/cards/app_list_item_card.dart';
import 'package:extra_pos/core/widgets/expandable/search_exbandable_card.dart';
import 'package:extra_pos/core/widgets/inputs/app_two_action_input_field.dart';
import 'package:extra_pos/core/widgets/listview/app_paged_listview.dart';
import 'package:extra_pos/core/widgets/listview/list_header.dart';
import 'package:extra_pos/core/widgets/text/app_heading_text.dart';
import 'package:extra_pos/core/widgets/text/readonly_text.dart';
import 'package:extra_pos/modules/lookup/data/po_receipt_line_lookup/po_receipt_line_response.dart';
import 'package:extra_pos/modules/lookup/presentation/item_lookup/item_lookup_page.dart';
import 'package:extra_pos/modules/po_receipts/data/crud_po_receipt_line/info_for_po_line_crud.dart';
import 'package:extra_pos/modules/po_receipts/presentation/review_po_receipt/review_po_receipt_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class POReceiptReviewPage extends StatelessWidget {
  var controller = Get.put(POReceiptReviewController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      shouldIncludeScrolling: false,
      appBar: BaseAppBar(
        title: "PO Receipt",
        actions: [
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
        ],
      ),
      bottomNavigationBar: Obx(() => ReviewPOReceiptBottomBar(
          isAddEnabled: !controller.isPOReceiptSubmitted.value,
          isSubmitEnabled: !controller.isPOReceiptSubmitted.value,
          onCancelPressed: () => Get.back(),
          onAddPressed: () {
            var poReceiptInfo = InfoForPOReceiptLineCrud(
              poReceiptHeaderInfo: PoReceiptHeaderInfo.fromJson(
                  controller.poReceiptInfo.value.toJson()),
            );
            gotoLineCrudPage(poReceiptInfo);
          },
          onSubmitPressed: () {
            controller.submitPOReceipt();
          })),
      body: Column(
        children: [
          _buildHeaderInfoCard(),
          AppHeadingText(
            name: "Items",
          ),
          _buildSearchFilterUi(),
          _buildListHeader(),
          _buildLinesList()
        ],
      ),
    );
  }

  Widget _buildHeaderInfoCard() {
    return Obx(() {
      return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReadonlyText(
                    isMultiline: false,
                    title: "Receipt No.",
                    content: controller.poReceiptInfo.value.receiptNumber,
                  ),
                  !controller.isPOReceiptSubmitted.value
                      ? IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => {
                            Get.toNamed(Routes.editPOReceipt,
                                arguments: controller.poReceiptInfo.toJson())
                          },
                        )
                      : Container()
                ],
              ),
              controller.isMoreInfoSwitchOn.value
                  ? Column(
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
                                    content: controller
                                            .userInfoController
                                            .userInfoState
                                            .response
                                            .value
                                            .firstName ??
                                        ''))
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
                                      .poReceiptInfo.value.vendorInvoiceNo,
                                )),
                            Expanded(
                                flex: 1,
                                child: ReadonlyText(
                                    isMultiline: true,
                                    title: 'Recv. Date',
                                    content: readableDateSlashddmmyyyy(
                                        DateTime.parse(controller.poReceiptInfo
                                            .value.receiptDate!))))
                          ],
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSearchFilterUi() {
    return SearchExpandableCard(
      onResetPressed: () {
        controller.resetSearchFilter();
      },
      onSearchPressed: () {
        controller.onSearchTap(
            start: 1, limit: controller.defaultPagingSize.value);
      },
      body: Column(
        children: [
          Obx(() => AppTwoActionInputField(
              title: 'Item Code',
              hint: 'Item Code / Barcode',
              value: controller.selectedItem.value!.itemNumber ?? '',
              primaryActionIcon:
                  SvgPicture.asset('assets/images/action_icons/qr_scan.svg'),
              secondaryActionIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              onPrimaryActionPressed: () {
                Get.to(ItemLookupPage(onItemSelected: (selectedItem) {
                  controller.selectedItem.value = selectedItem;
                }));
              },
              onSecondaryActionPressed: () async {
                controller.openBarcodeScanner();
              }))
        ],
      ),
    );
  }

  Widget _buildListHeader() {
    return Obx(() {
      return ListHeader(
        totalRecords: controller.state.totalRecords.toString() ?? '',
      );
    });
  }

  Widget _buildLinesList() {
    return Obx(() => Expanded(
          child: AppPaginationView(
            pageSize: controller.defaultPagingSize.value,
            onListReady: (int start, int limit) {
              controller.getItems(start: start, limit: limit, reset: true);
            },
            onReadyToNextPage: (int currentPage, int nextPage, int pageSize,
                int start, int limit) {
              controller.getItems(start: start, limit: limit);
            },
            status: controller.state.status.value,
            errorMessage: controller.state.errorMessage.value ?? '',
            listItemCount: controller.state.response.length ?? 0,
            currentPage: controller.state.currentPage.value,
            totalRecordsCount: controller.state.totalRecords.value,
            itemBuilder: (BuildContext context, int index) {
              return ListItemCard(
                titleWidth: 100,
                onTap: () {
                  //   Get.toNamed(Routes.requisitionReview);
                },
                onMoreTap: () {
                  _showMoreInfo(context, controller.state.response[index]);
                },
                title: 'Item Code',
                titleValue: controller.state.response[index].itemNumber,
                subTitle: 'Qty',
                subTitleValue:
                    controller.state.response[index].recdNowQuantity.toString(),
                thirdTitle: 'Item desc.',
                thirdValue: controller.state.response[index].itemDescription,
              );
            },
          ),
        ));
  }

   _showMoreInfo(BuildContext context, POReceiptLine line) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return InfoBottomSheet(
              title: 'Item',
              actionButtonTitle: 'Edit',
              actionButtonVisibility: true,
              onActionButtonPressed: () {
                Get.back();
                var poReceiptInfo = InfoForPOReceiptLineCrud(
                    poReceiptHeaderInfo: PoReceiptHeaderInfo.fromJson(
                        controller.poReceiptInfo.value.toJson()),
                    poReceiptLineInfo:
                        PoReceiptLineInfo.fromJson(line.toJson()));
                poReceiptInfo.poReceiptLineInfo!.itemNumber = line.itemNumber;
                gotoLineCrudPage(poReceiptInfo);
              },
              list: [
                ReadonlyTitleValue(title: 'Item Code', value: line.itemNumber),
                ReadonlyTitleValue(
                    title: 'Line No.', value: line.poLineNumber?.toString()),
                ReadonlyTitleValue(
                    title: 'Qty. Recv',
                    value: line.recdNowQuantity == null
                        ? "0"
                        : line.recdNowQuantity.toString()),
                ReadonlyTitleValue(title: 'UoM', value: line.uom),
                ReadonlyTitleValue(
                    title: 'Item Desc.', value: line.itemDescription)
              ]);
        });
  }

  void gotoLineCrudPage(InfoForPOReceiptLineCrud poReceiptInfo) async {
    await Get.toNamed(Routes.crudPoReceiptLineItem,
            arguments: poReceiptInfo.toJson())!
        .then((value) {
      controller.refreshData();
    });
  }
}
