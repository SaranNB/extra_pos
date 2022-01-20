import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/bottom_sheet/info_bottom_sheet.dart';
import 'package:extra_pos/core/widgets/cards/app_list_item_card.dart';
import 'package:extra_pos/core/widgets/listview/app_paged_listview.dart';
import 'package:extra_pos/core/widgets/listview/list_header.dart';
import 'package:extra_pos/modules/lookup/data/item_lookup/items_response.dart';
import 'package:extra_pos/modules/lookup/presentation/item_lookup/item_lookup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BarCodeBasedItemLookupPage extends StatelessWidget {
  final String scannedBarcode;
  final Function(Item selectedItem) onItemSelected;

  var controller = Get.put(ItemLookupController());

  BarCodeBasedItemLookupPage({required this.onItemSelected, required this.scannedBarcode});

  @override
  Widget build(BuildContext context) {
    controller.resetState();
    return BaseScaffold(
        shouldIncludeScrolling: false,
        appBar: BaseAppBar(title:'Select Part'),
        body: Column(
          children: [_buildListHeader(), _buildPartsList()],
        ));
  }

  _buildListHeader() {
    return Obx(() {
      return ListHeader(
        totalRecords: controller.barcodeBasedItemsState.totalRecords.toString() ?? '',
      );
    });
  }

  _buildPartsList() {
    return Obx(() {
      return Expanded(
        child: AppPaginationView(
          pageSize: controller.defaultPagingSize.value,
          onListReady: (int start, int limit) {
            controller.getPartsBasedOnBarcode(
                start: start,
                limit: limit,
                scannedBarcode: this.scannedBarcode);
          },
          onReadyToNextPage: (int currentPage, int nextPage, int pageSize,
              int start, int limit) {
            controller.getPartsBasedOnBarcode(
                start: start,
                limit: limit,
                scannedBarcode: this.scannedBarcode);
          },
          status: controller.barcodeBasedItemsState.status.value,
          errorMessage: controller.barcodeBasedItemsState.errorMessage.value ?? '',
          listItemCount: controller.barcodeBasedItemsState.response.length ?? 0,
          currentPage: controller.barcodeBasedItemsState.currentPage.value,
          totalRecordsCount: controller.barcodeBasedItemsState.totalRecords.value,
          itemBuilder: (BuildContext context, int index) {
            return ListItemCard(
              onTap: () {
                Get.back();
                onItemSelected(controller.barcodeBasedItemsState.response[index]);
              },
              onMoreTap: () {
                _showMoreInfo(context, controller.barcodeBasedItemsState.response[index]);
              },
              title: 'Item No.',
              titleValue: controller.barcodeBasedItemsState.response[index].itemNumber,
              subTitle: 'Desc.',
              subTitleValue: controller.barcodeBasedItemsState.response[index].itemDescription,
            );
          },
        ),
      );
    });
  }

   _showMoreInfo(BuildContext context, Item item) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return InfoBottomSheet(
              title: 'Part Information',
              actionButtonTitle: 'Select',
              onActionButtonPressed: () {
                Get.back();
                Get.back();
                onItemSelected(item);
              },
              list: [
                ReadonlyTitleValue(title: 'Item No.', value: item.itemNumber),
                ReadonlyTitleValue(title: 'Desc.', value: item.itemDescription)
              ]);
        });
  }
}
