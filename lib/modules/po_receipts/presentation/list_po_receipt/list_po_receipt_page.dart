import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/utils/date_time_utils.dart';
import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/bottom_sheet/info_bottom_sheet.dart';
import 'package:extra_pos/core/widgets/cards/app_list_item_card.dart';
import 'package:extra_pos/core/widgets/expandable/search_exbandable_card.dart';
import 'package:extra_pos/core/widgets/inputs/app_date_picker.dart';
import 'package:extra_pos/core/widgets/inputs/app_selectable_input_field.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:extra_pos/core/widgets/listview/app_paged_listview.dart';
import 'package:extra_pos/core/widgets/listview/list_header.dart';
import 'package:extra_pos/modules/lookup/data/po_receipt_header_lookup/po_receipt_header_lookup_response.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_lookup/branch_lookup_page.dart';
import 'package:extra_pos/modules/lookup/presentation/po_number_filter_lookup/po_number_filter_lookup_page.dart';
import 'package:extra_pos/modules/lookup/presentation/user_lookup/user_lookup_page.dart';
import 'package:extra_pos/modules/po_receipts/presentation/list_po_receipt/list_po_receipt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPOReceiptPage extends StatelessWidget {

  var controller = Get.put(ListPOReceiptController());

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      shouldIncludeScrolling: false,
      appBar: BaseAppBar(title: "List of PO Receipts"),
      body: _buildScrollableContents()
    );
  }

  _test() {
    // return NestedScrollView(headerSliverBuilder: , body: body)
  }

  _buildScrollableContents() {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  _buildContent() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: controller.scrollController,
            child: Container(
              height: Get.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSearchFilerUi(),
                  _buildListHeader(),
                  _buildPOReceiptList()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildSearchFilerUi() {
    return SingleChildScrollView(
      child: SearchExpandableCard(
        onResetPressed: () {
          controller.resetSearchFilter();
        },
        onSearchPressed: () {
          controller.onSearchTap(
              start: 1, limit: controller.defaultPagingSize.value);
        },
        body: Column(
          children: [
            AppTextInputField(
              title: 'Receipt Number',
              hint: 'Receipt Number',
              controller: controller.receiptNumberTextController,
            ),
            AppSelectableInputField(
                title: 'Branch',
                hint: 'Search',
                suffixIcon: Icon(Icons.search),
                controller: controller.branchTextController,
                onTap: () {
                  Get.to(BranchLookupPage(onBranchSelected: (selectedBranch) {
                    controller.branchTextController.text =
                        selectedBranch.branchCode!;
                    controller.selectedBranch.value = selectedBranch;
                  }));
                }),
            AppSelectableInputField(
                title: 'User',
                hint: 'Search',
                suffixIcon: Icon(Icons.search),
                controller: controller.userNameTextController,
                onTap: () {
                  Get.to(UserLookupPage(onUserSelected: (selectedUser) {
                    controller.userNameTextController.text = selectedUser.firstName!;
                    controller.selectedUser.value = selectedUser;
                  }));
                }),
            AppTextInputField(
              title: 'Vendor Invoice No.',
              hint: 'Vendor Invoice No.',
              controller: controller.vendorInvoiceNumberTextController,
            ),
            AppSelectableInputField(
              title: 'PO Number *',
              hint: 'PO Number',
              suffixIcon: Icon(Icons.search),
              controller: controller.poNumberTextController,
              onTap: () {
                Get.to(PONumberFilterLookupPage(
                    onPONumberSelected: (selectedPONumber) {
                      controller.poNumberTextController.text =
                          selectedPONumber.poNumber!;
                      controller.selectedPONumber.value = selectedPONumber;
                    }));
              },
            ),
            Obx(() => AppDatePickerField(
              title: 'Recv Date *',
              hint: 'Recv Date',
              date: controller.selectedDate.value,
              onChanged: (DateTime selectedDate) {
                controller.selectedDate.value = selectedDate;
              },
            ))
          ],
        ),
      ),
    );
  }

  _buildListHeader() {
    return Obx(() {
      return ListHeader(
        totalRecords: controller.state.totalRecords.toString() ?? '',
      );
    });
  }

  _buildPOReceiptList() {
    return Obx(() {
      return Expanded(
        child: AppPaginationView(
          pageSize: controller.defaultPagingSize.value,
          onListReady: (int start, int limit) {
            controller.getPoReceipts(start: start, limit: limit);
          },
          onReadyToNextPage: (int currentPage, int nextPage, int pageSize,
              int start, int limit) {
            controller.getPoReceipts(start: start, limit: limit);
          },
          status: controller.state.status.value,
          errorMessage: controller.state.errorMessage.value ?? '',
          listItemCount: controller.state.response.length ?? 0,
          currentPage: controller.state.currentPage.value,
          totalRecordsCount: controller.state.totalRecords.value,
          itemBuilder: (BuildContext context, int index) {
            return ListItemCard(
              titleWidth: 100.0,
              onTap: () {
                // Requisition requisition = controller.state.response[index];
                // gotoReviewPage(requisition);
              },
              onMoreTap: () {
                _showMoreInfo(context, controller.state.response[index]);
              },
              title: 'Receipt No.',
              titleValue: controller.state.response[index].receiptNumber,
              subTitle: 'PO No.',
              subTitleValue: controller.state.response[index].poNumber,
              thirdTitle: 'Vendor Inv No.',
              thirdValue: controller.state.response[index].vendorInvoiceNo,
            );
          },
        ),
      );
    });
  }

   _showMoreInfo(BuildContext context, POReceiptHeader receipt) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return InfoBottomSheet(
              title: 'PO Receipt',
              actionButtonTitle: 'Edit',
              onActionButtonPressed: () {
                Get.back();
                gotoReviewPage(receipt);
              },
              list: [
                ReadonlyTitleValue(title: 'Receipt No.', value: receipt.receiptNumber),
                ReadonlyTitleValue(title: 'PO Number', value: receipt.poNumber),
                ReadonlyTitleValue(title: 'Vendor Inv No.', value: receipt.vendorInvoiceNo),
                ReadonlyTitleValue(title: 'Branch', value: receipt.receivingBranch),
                ReadonlyTitleValue(title: 'User', value: receipt.createdByUser),
                ReadonlyTitleValue(title: 'Recv. Date', value: readableDateSlashddmmyyyy(DateTime.parse(receipt.receiptDate!))),
              ]);
        });
  }

  void gotoReviewPage(POReceiptHeader receipt) async {
    var result =
    await Get.toNamed(Routes.requisitionPOReceipt, arguments: receipt.toJson());
    // if(result == true) {
    //   controller.getRequisitions(start: 1, limit: controller.defaultPagingSize.value, reset: true);
    // }
    controller.getPoReceipts(start: 1, limit: controller.defaultPagingSize.value, reset: true);
  }
}
