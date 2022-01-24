
import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/cards/app_list_item_card.dart';
import 'package:extra_pos/core/widgets/expandable/search_exbandable_card.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:extra_pos/core/widgets/listview/app_paged_listview.dart';
import 'package:extra_pos/core/widgets/listview/list_header.dart';
import 'package:extra_pos/modules/lookup/data/vendor_branch_lookup/vendor_branch_lookup_response.dart';
import 'package:extra_pos/modules/lookup/presentation/vendor_branch_lookup/vendor_branch_lookup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorBranchLookupPage extends StatelessWidget {
  final Function(VendorBranch selectedVendorBranch)? onVendorBranchSelected;
  final int? vendorId;
  final int? vendorBranchId;
 late  VendorBranchLookupController controller;

  VendorBranchLookupPage({this.vendorId, this.vendorBranchId, this.onVendorBranchSelected});



  @override
  Widget build(BuildContext context) {
    this.controller = Get.put(VendorBranchLookupController(this.vendorId!, this.vendorBranchId!));
    controller.resetState();

    return BaseScaffold(

        shouldIncludeScrolling: false,
        appBar: BaseAppBar(title:'Select Vendor Branch'),
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
              title: 'Search by Vendor Site Code',
              hint: 'Search',
              controller: controller.searchByVendorSiteCodeTextController,
              suffixIcon: Icon(Icons.search),
              onTap: () {
                controller
                    .searchInputFocused(VendorBranchSearchFieldType.SEARCH_BY_SITE_CODE);
              }
          ),
          AppTextInputField(
              title: 'Search by Vendor Site Name',
              hint: 'Search',
              controller: controller.searchByVendorSiteNameTextController,
              suffixIcon: Icon(Icons.search),
              onTap: () {
                controller.searchInputFocused(
                    VendorBranchSearchFieldType.SEARCH_BY_SITE_NAME);
              }
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
            controller.getVendorBranch(start: start, limit: limit);
          },
          onReadyToNextPage: (int currentPage, int nextPage, int pageSize,
              int start, int limit) {
            controller.getVendorBranch(start: start, limit: limit);
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
                onVendorBranchSelected!(controller.state.response[index]);
              },
              isMoreButtonNeeded: false,
              title: 'Site Code',
              titleValue: controller.state.response[index].vendorSiteCode,
              subTitle: 'Site Name',
              subTitleValue: controller.state.response[index].vendorSiteName,
            );
          },
        ),
      );
    });
  }
}
