import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/cards/app_list_item_card.dart';
import 'package:extra_pos/core/widgets/expandable/search_exbandable_card.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:extra_pos/core/widgets/listview/app_paged_listview.dart';
import 'package:extra_pos/core/widgets/listview/list_header.dart';
import 'package:extra_pos/modules/lookup/data/po_number_filter_lookup/po_number_filter_lookup_response.dart';
import 'package:extra_pos/modules/lookup/presentation/po_number_filter_lookup/po_number_filter_lookup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PONumberFilterLookupPage extends StatelessWidget {
  final Function(PONumber selectedPONumber)? onPONumberSelected;

  late PONumberFilterLookupController controller;

  PONumberFilterLookupPage({this.onPONumberSelected});

  @override
  Widget build(BuildContext context) {
    controller = Get.put(PONumberFilterLookupController());
    controller.resetState();
    return BaseScaffold(
        shouldIncludeScrolling: false,
        appBar: BaseAppBar(title:'Select PO Number'),
        body: Column(
          children: [_buildSearchFiltersUi(), _buildListHeader(), _buildList()],
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
            title: 'Search by PO Number',
            hint: 'Search',
            controller: controller.searchByPONumberTextController,
            suffixIcon: Icon(Icons.search),
          )
        ],
      ),
    );
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
            controller.getPONumbers(start: start, limit: limit);
          },
          onReadyToNextPage: (int currentPage, int nextPage, int pageSize,
              int start, int limit) {
            controller.getPONumbers(start: start, limit: limit);
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
                onPONumberSelected!(controller.state.response[index]);
              },
              isMoreButtonNeeded: false,
              title: 'PO Number',
              titleValue: controller.state.response[index].poNumber,
              subTitle: 'Ship To',
              subTitleValue: controller.state.response[index].shipToBranch,
            );
          },
        ),
      );
    });
  }
}
