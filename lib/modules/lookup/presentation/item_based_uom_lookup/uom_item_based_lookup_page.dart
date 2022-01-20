import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/cards/app_list_item_card.dart';
import 'package:extra_pos/core/widgets/expandable/search_exbandable_card.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:extra_pos/core/widgets/listview/app_paged_listview.dart';
import 'package:extra_pos/core/widgets/listview/list_header.dart';
import 'package:extra_pos/modules/lookup/data/item_lookup/items_response.dart';
import 'package:extra_pos/modules/lookup/data/uom_item_based_lookup/uom_item_based_lookup_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'uom_item_based_lookup_controller.dart';

class UomItemBasedLookupPage extends StatelessWidget {
  final Item? itemInfo;
  final Function(UomItemBased selectedItem)? onUomSelected;

  UomItemBasedLookupPage({@required this.itemInfo, this.onUomSelected});

  var controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(UomItemBasedLookupController());
    controller.resetState();
    controller.itemInfo = itemInfo;

    return BaseScaffold(
        shouldIncludeScrolling: false,
        appBar: BaseAppBar(title: 'Select UOM'),
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
              title: 'Search by UOM',
              hint: 'Search',
              controller: controller.searchByUomController,
              suffixIcon: Icon(Icons.search)),
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
            controller.getUoms(start: start, limit: limit);
          },
          onReadyToNextPage: (int currentPage, int nextPage, int pageSize,
              int start, int limit) {
            controller.getUoms(start: start, limit: limit);
          },
          status: controller.state?.status?.value,
          errorMessage: controller.state?.errorMessage?.value ?? '',
          listItemCount: controller.state?.response?.length ?? 0,
          currentPage: controller.state?.currentPage?.value,
          totalRecordsCount: controller.state?.totalRecords?.value,
          itemBuilder: (BuildContext context, int index) {
            return ListItemCard(
              onTap: () {
                Get.back();
                onUomSelected!(controller.state.response[index]);
              },
              isMoreButtonNeeded: false,
              title: 'UOM',
              titleValue: controller.state.response[index].uom,
              subTitle: 'Desc.',
              subTitleValue: controller.state.response[index].uomDescription,
            );
          },
        ),
      );
    });
  }
}
