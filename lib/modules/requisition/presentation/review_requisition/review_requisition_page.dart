import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/widgets/action_bottom_bar/review_requisition_bottom_bar.dart';
import 'package:extra_pos/core/widgets/bottom_sheet/info_bottom_sheet.dart';
import 'package:extra_pos/core/widgets/cards/app_list_item_card.dart';
import 'package:extra_pos/core/widgets/expandable/search_exbandable_card.dart';
import 'package:extra_pos/core/widgets/inputs/app_two_action_input_field.dart';
import 'package:extra_pos/core/widgets/listview/app_paged_listview.dart';
import 'package:extra_pos/core/widgets/listview/list_header.dart';
import 'package:extra_pos/core/widgets/text/app_heading_text.dart';
import 'package:extra_pos/modules/lookup/presentation/item_lookup/item_lookup_page.dart';
import 'package:extra_pos/modules/requisition/data/crud_requisition_line/trn_line_info.dart';
import 'package:extra_pos/modules/requisition/data/requisition_line_list/requisition_line_list_response.dart';
import 'package:extra_pos/modules/requisition/presentation/review_requisition/review_requisition_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/base/base_app_bar.dart';
import '../../../../core/widgets/base/base_scaffold.dart';
import '../../../../core/widgets/text/readonly_text.dart';

class RequisitionReviewPage extends StatelessWidget {
  var controller = Get.put(RequisitionReviewController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      shouldIncludeScrolling: false,
      appBar: BaseAppBar(
        title: "Requisition Review",
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
      bottomNavigationBar: Obx(() => ReviewRequisitionBottomBar(
            isDeleteEnabled: _shouldEnableActions(),
            isAddEnabled: _shouldEnableActions(),
            isSubmitEnabled: _shouldEnableActions(),
            onCancelPressed: () => Get.back(),
            onAddPressed: () {
              var requisitionInfo = InfoForRequisitionLineCrud(
                  trnInfo: TrnInfo(
                      trn: controller.requisitionInfo.value.trn,
                      branchId: controller.requisitionInfo.value.branchId,
                      headerId: controller.requisitionInfo.value.headerId,
                      userName: controller.requisitionInfo.value.userName,
                      branchCode: controller.requisitionInfo.value.branchCode));
              gotoLineCrudPage(requisitionInfo);
            },
            onSubmitPressed: () {
              controller.submitTempRequisition();
            },
            onDeletePressed: () {
              controller.deleteTempRequisition();
            },
          )),
      body: Column(
        children: [
          _buildHeaderInfoCard(),
          AppHeadingText(
            name: "Parts",
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
                    title: "TRN",
                    content: controller.requisitionInfo.value.trn,
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.edit),
                  //   onPressed: () => {},
                  // )
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
                                      .requisitionInfo.value.branchCode,
                                )),
                            Expanded(
                                flex: 1,
                                child: ReadonlyText(
                                  isMultiline: true,
                                  title: 'User',
                                  content:
                                      controller.requisitionInfo.value.userName,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            ReadonlyText(
                              isMultiline: true,
                              title: 'Status',
                              content:
                                  controller.requisitionInfo.value.reqStatus,
                            )
                          ],
                        )
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
              title: 'Part Number',
              hint: 'Part Number / Barcode',
              value: controller.selectedItem.value.itemNumber ?? '',
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
        totalRecords: controller.state.totalRecords.toString(),
      );
    });
  }

  Widget _buildLinesList() {
    return Obx(() => Expanded(
          child: AppPaginationView(
            pageSize: controller.defaultPagingSize.value,
            onListReady: (int start, int limit) {
              controller.getItems(start: start, limit: limit);
            },
            onReadyToNextPage: (int currentPage, int nextPage, int pageSize,
                int start, int limit) {
              controller.getItems(start: start, limit: limit);
            },
            status: controller.state.status.value,
            errorMessage: controller.state.errorMessage.value ?? '',
            listItemCount: controller.state.response.length,
            currentPage: controller.state.currentPage.value,
            totalRecordsCount: controller.state.totalRecords.value,
            itemBuilder: (BuildContext context, int index) {
              return ListItemCard(
                onTap: () {
                  //   Get.toNamed(Routes.requisitionReview);
                },
                onMoreTap: () {
                  _showMoreInfo(context, controller.state.response[index]);
                },
                title: 'Item Code',
                titleValue: controller.state.response[index].itemNumber,
                subTitle: 'Qty',
                description: controller.state.response[index].itemDescription,
                subTitleValue:
                    controller.state.response[index].quantity.toString(),
              );
            },
          ),
        ));
  }

   _showMoreInfo(BuildContext context, RequisitionLine line) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Obx(() => InfoBottomSheet(
                  title: 'Line Information',
                  actionButtonTitle: 'Edit',
                  actionButtonVisibility: _shouldEnableActions(),
                  onActionButtonPressed: () {
                    Get.back();
                    var requisitionInfo = InfoForRequisitionLineCrud(
                        trnInfo: TrnInfo(
                            trn: controller.requisitionInfo.value.trn,
                            branchId: controller.requisitionInfo.value.branchId,
                            headerId: controller.requisitionInfo.value.headerId,
                            userName: controller.requisitionInfo.value.userName,
                            branchCode:
                                controller.requisitionInfo.value.branchCode),
                        lineInfo: RequisitionLineInfo.fromJson(line.toJson()));

                    // Get.offNamed(Routes.createPart, arguments: res.toJson());
                    gotoLineCrudPage(requisitionInfo);
                  },
                  list: [
                    ReadonlyTitleValue(
                        title: 'Item Code', value: line.itemNumber),
                    ReadonlyTitleValue(
                        title: 'Qty', value: line.quantity.toString()),
                    ReadonlyTitleValue(title: 'UoM', value: line.uom),
                    ReadonlyTitleValue(
                        title: 'Item Desc.', value: line.itemDescription)
                  ]));
        });
  }

  // Here we disable the submit, delete and add buttons based on the status
  bool _shouldEnableActions() {
    var status = controller.requisitionInfo.value.reqStatus!.toUpperCase();
    if (status == 'SUBMITTED' ||
        status == 'PRCREATED' ||
        status == 'CANCELLED') {
      return false;
    }
    return true;
  }

  void gotoLineCrudPage(InfoForRequisitionLineCrud requisitionInfo) async {
    await Get.toNamed(Routes.crudRequisitionItem, arguments: requisitionInfo.toJson())!
        .then((value) {
      controller.refreshData();
    });
  }
}
