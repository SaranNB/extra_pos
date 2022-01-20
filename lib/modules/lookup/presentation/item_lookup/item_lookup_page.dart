import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/bottom_sheet/info_bottom_sheet.dart';
import 'package:extra_pos/core/widgets/cards/app_list_item_card.dart';
import 'package:extra_pos/core/widgets/expandable/search_exbandable_card.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:extra_pos/core/widgets/listview/app_paged_listview.dart';
import 'package:extra_pos/core/widgets/listview/list_header.dart';
import 'package:extra_pos/modules/lookup/data/item_lookup/items_response.dart';
import 'package:extra_pos/modules/lookup/presentation/item_lookup/item_lookup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemLookupPage extends StatelessWidget {
  final Function(Item selectedItem)? onItemSelected;

  ItemLookupPage({this.onItemSelected});

  var controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(ItemLookupController());
    controller.resetState();

    return BaseScaffold(
        shouldIncludeScrolling: false,
        appBar: BaseAppBar(title: 'Select Part'),
        body: Column(
          children: [
            _buildSearchFiltersUi(),
            _buildListHeader(),
            _buildPartsList()
          ],
        ));
  }

  _buildSearchFiltersUi() {
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
          AppTextInputField(
              title: 'Search by Item Code',
              hint: 'Search',
              controller: controller.searchByItemCodeTextController,
              suffixIcon: Icon(Icons.search),
              onTap: () {
                controller
                    .searchInputFocused(ItemSearchFieldType.SEARCH_BY_CODE);
              }),
          AppTextInputField(
              title: 'Search by Item Description',
              hint: 'Search',
              controller: controller.searchByItemDescriptionTextController,
              suffixIcon: Icon(Icons.search),
              onTap: () {
                controller.searchInputFocused(
                    ItemSearchFieldType.SEARCH_BY_DESCRIPTION);
              })
        ],
      ),
    );
  }

  _buildListHeader() {
    return Obx(() {
      return ListHeader(
        totalRecords: controller.state?.totalRecords?.toString() ?? '',
      );
    });
  }

  _buildPartsList() {
    return Obx(() {
      return Expanded(
        child: AppPaginationView(
          pageSize: controller.defaultPagingSize.value,
          onListReady: (int start, int limit) {
            controller.getItems(start: start, limit: limit);
          },
          onReadyToNextPage: (int currentPage, int nextPage, int pageSize,
              int start, int limit) {
            controller.getItems(start: start, limit: limit);
          },
          status: controller.state?.status?.value,
          errorMessage: controller.state?.errorMessage?.value ?? '',
          listItemCount: controller.state?.response?.length ?? 0,
          currentPage: controller.state?.currentPage?.value,
          totalRecordsCount: controller.state?.totalRecords?.value,
          itemBuilder: (BuildContext context, int index) {
            return
              ListItemCard(
              onTap: () {
                Get.back();
                onItemSelected!(controller.state.response[index]);
              },
              onMoreTap: () {
                _showMoreInfo(context, controller.state.response[index]);
              },
              title: 'Item No.',
              titleValue: controller.state.response[index].itemNumber,
              subTitle: 'Desc.',
              subTitleValue: controller.state.response[index].itemDescription,
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
                onItemSelected!(item);
              },
              list: [
                ReadonlyTitleValue(title: 'Item No.', value: item.itemNumber),
                ReadonlyTitleValue(title: 'Desc.', value: item.itemDescription)
              ]);
        });
  }
}
