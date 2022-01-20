
import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/cards/app_list_item_card.dart';
import 'package:extra_pos/core/widgets/expandable/search_exbandable_card.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:extra_pos/core/widgets/listview/app_paged_listview.dart';
import 'package:extra_pos/core/widgets/listview/list_header.dart';
import 'package:extra_pos/modules/lookup/data/vendor_lookup/vendor_lookup_response.dart';
import 'package:extra_pos/modules/lookup/presentation/vendor_lookup/vendor_lookup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorLookupPage extends StatelessWidget {

  final Function(Vendor selectedVendor)? onVendorSelected;

  VendorLookupPage({this.onVendorSelected});

  var controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(VendorLookupController());
    controller.resetState();

    return BaseScaffold(
        shouldIncludeScrolling: false,
        appBar: BaseAppBar(title: 'Select Vendor'),
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
              title: 'Search by Vendor Code',
              hint: 'Search',
              controller: controller.searchByVendorCodeTextController,
              suffixIcon: Icon(Icons.search),
              onTap: () {
                controller
                    .searchInputFocused(VendorSearchFieldType.SEARCH_BY_CODE);
              }
          ),
          AppTextInputField(
              title: 'Search by Branch Description',
              hint: 'Search',
              controller: controller.searchByVendorNameTextController,
              suffixIcon: Icon(Icons.search),
              onTap: () {
                controller.searchInputFocused(
                    VendorSearchFieldType.SEARCH_BY_NAME);
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
            controller.getVendors(start: start, limit: limit);
          },
          onReadyToNextPage: (int currentPage, int nextPage, int pageSize,
              int start, int limit) {
            controller.getVendors(start: start, limit: limit);
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
                onVendorSelected!(controller.state.response[index]);
              },
              isMoreButtonNeeded: false,
              title: 'Vendor Code',
              titleValue: controller.state.response[index].vendorCode,
              subTitle: 'Vendor Name',
              subTitleValue: controller.state.response[index].vendorName,
            );
          },
        ),
      );
    });
  }
}
