import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/cards/app_list_item_card.dart';
import 'package:extra_pos/core/widgets/expandable/search_exbandable_card.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:extra_pos/core/widgets/listview/app_paged_listview.dart';
import 'package:extra_pos/core/widgets/listview/list_header.dart';
import 'package:extra_pos/modules/lookup/data/branch_lookup/branches_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'branch_lookup_controller.dart';

class BranchLookupPage extends StatelessWidget {
  final Function(Branch selectedBranch)? onBranchSelected;

  BranchLookupPage({this.onBranchSelected});

  var controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(BranchLookupController());
    controller.resetState();

    return BaseScaffold(

        shouldIncludeScrolling: false,
        appBar: BaseAppBar(title: 'Select Branch'),
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
              title: 'Search by Branch Code',
              hint: 'Search',
              controller: controller.searchByBranchCodeTextController,
              suffixIcon: Icon(Icons.search),
              onTap: () {
                controller
                    .searchInputFocused(BranchSearchFieldType.SEARCH_BY_CODE);
              }
          ),
          AppTextInputField(
              title: 'Search by Branch Description',
              hint: 'Search',
              controller: controller.searchByBranchDescriptionTextController,
              suffixIcon: Icon(Icons.search),
              onTap: () {
                controller.searchInputFocused(
                    BranchSearchFieldType.SEARCH_BY_DESCRIPTION);
              }
          )
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

  _buildList() {
    return Obx(() {
      return Expanded(
        child: AppPaginationView(
          pageSize: controller.defaultPagingSize.value,
          onListReady: (int start, int limit) {
            controller.getBranches(start: start, limit: limit);
          },
          onReadyToNextPage: (int currentPage, int nextPage, int pageSize,
              int start, int limit) {
            controller.getBranches(start: start, limit: limit);
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
                onBranchSelected!(controller.state.response[index]);
              },
              isMoreButtonNeeded: false,
              title: 'Branch',
              titleValue: controller.state.response[index].branchCode,
              subTitle: 'Desc.',
              subTitleValue: controller.state.response[index].branchDescription,
            );
          },
        ),
      );
    });
  }
}
