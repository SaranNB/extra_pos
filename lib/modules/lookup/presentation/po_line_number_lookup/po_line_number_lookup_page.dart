import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/cards/app_list_item_card.dart';
import 'package:extra_pos/core/widgets/listview/app_paged_listview.dart';
import 'package:extra_pos/core/widgets/listview/list_header.dart';
import 'package:extra_pos/modules/lookup/data/po_line_number_lookup/po_line_number_lookup_response.dart';
import 'package:extra_pos/modules/lookup/presentation/po_line_number_lookup/po_line_number_lookup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class POLineNumberLookupPage extends StatelessWidget {
  final Function(POLineNumber selectedPOLineNumber)? onPOLineNumberSelected;
  final String? itemCode;
  final int? headerId;
  final int? headerBranchId;
  final int? itemId;
  final int? itemBranchId;

  late POLineNumberLookupController controller;


  POLineNumberLookupPage(
      {this.itemCode,
      this.headerId,
      this.headerBranchId,
      this.itemId,
      this.itemBranchId,
      this.onPOLineNumberSelected}) {
    this.controller = Get.put(POLineNumberLookupController(this.itemCode!,
        this.headerId!, this.headerBranchId!, this.itemId!, this.itemBranchId!));
  }

  @override
  Widget build(BuildContext context) {
    controller.resetState();
    return BaseScaffold(
        shouldIncludeScrolling: false,
        appBar: BaseAppBar(title: 'PO Line Number'),
        body: Column(
          children: [_buildListHeader(), _buildList()],
        ));
  }

  _buildListHeader() {
    return Obx(() {
      return ListHeader(
        totalRecords: controller.state.totalRecords.toString(),
      );
    });
  }

  _buildList() {
    return Obx(() {
      return Expanded(
        child: AppPaginationView(
          pageSize: controller.defaultPagingSize.value,
          onListReady: (int start, int limit) {
            controller.getPOLineNumbers(start: start, limit: limit);
          },
          onReadyToNextPage: (int currentPage, int nextPage, int pageSize,
              int start, int limit) {
            controller.getPOLineNumbers(start: start, limit: limit);
          },
          status: controller.state.status.value,
          errorMessage: controller.state.errorMessage.value ?? '',
          listItemCount: controller.state.response.length,
          currentPage: controller.state.currentPage.value,
          totalRecordsCount: controller.state.totalRecords.value,
          itemBuilder: (BuildContext context, int index) {
            return ListItemCard(
              onTap: () {
                Get.back();
                onPOLineNumberSelected!(controller.state.response[index]);
              },
              isMoreButtonNeeded: false,
              title: 'Item Number',
              titleValue: controller.state.response[index].itemNumber,
              subTitle: 'Desc.',
              subTitleValue: controller.state.response[index].itemDescription,
            );
          },
        ),
      );
    });
  }
}
