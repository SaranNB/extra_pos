import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/bottom_sheet/info_bottom_sheet.dart';
import 'package:extra_pos/core/widgets/cards/app_list_item_card.dart';
import 'package:extra_pos/core/widgets/expandable/search_exbandable_card.dart';
import 'package:extra_pos/core/widgets/inputs/app_dropdown_input_field.dart';
import 'package:extra_pos/core/widgets/inputs/app_selectable_input_field.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:extra_pos/core/widgets/listview/app_paged_listview.dart';
import 'package:extra_pos/core/widgets/listview/list_header.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_lookup/branch_lookup_page.dart';
import 'package:extra_pos/modules/lookup/presentation/user_lookup/user_lookup_page.dart';
import 'package:extra_pos/modules/requisition/data/list_requisition/list_requisition_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_requisition_controller.dart';

class ListRequisitionPage extends StatefulWidget {
  @override
  _ListRequisitionPageState createState() => _ListRequisitionPageState();
}

class _ListRequisitionPageState extends State<ListRequisitionPage> {
  var controller = Get.find<ListRequisitionController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    controller.getRequisitionStatusList();

    return BaseScaffold(
      shouldIncludeScrolling: false,
      appBar: BaseAppBar(title: "List of Requisition"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchFilerUi(),
          _buildListHeader(),
          _buildRequisitionsList()
        ],
      ),
    );
  }

  _buildSearchFilerUi() {
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
            title: 'TRN',
            hint: 'Search',
            controller: controller.trnTextController,
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
                  controller.selectedBranch = selectedBranch;
                }));
              }),
          AppSelectableInputField(
              title: 'User',
              hint: 'Search',
              suffixIcon: Icon(Icons.search),
              controller: controller.userTextController,
              onTap: () {
                Get.to(UserLookupPage(onUserSelected: (selectedUser) {
                  controller.userTextController.text = selectedUser.firstName!;
                  controller.selectedUser = selectedUser;
                }));
              }),
          Obx(() {
            var statusList =
                controller.requisitionStatusListState.response.value.data;
            return AppDropdownInputField(
                onChanged: (value) {
                  controller.selectedRequisitionStatus.value = value;
                },
                title: 'Status',
                value: controller.selectedRequisitionStatus.value,
                list: statusList != null
                    ? statusList
                        .map((e) =>
                            DropdownModel(id: e.lookUpValue, value: e.meaning))
                        .toList()
                    : []);
          })
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

  _buildRequisitionsList() {
    return Obx(() {
      return Expanded(
        child: AppPaginationView(
          pageSize: controller.defaultPagingSize.value,
          onListReady: (int start, int limit) {
            controller.getRequisitions(start: start, limit: limit);
          },
          onReadyToNextPage: (int currentPage, int nextPage, int pageSize,
              int start, int limit) {
            controller.getRequisitions(start: start, limit: limit);
          },
          status: controller.state.status.value,
          errorMessage: controller.state.errorMessage.value ?? '',
          listItemCount: controller.state.response.length,
          currentPage: controller.state.currentPage.value,
          totalRecordsCount: controller.state.totalRecords.value,
          itemBuilder: (BuildContext context, int index) {
            return ListItemCard(
              onTap: () {
                Requisition requisition = controller.state.response[index];
                gotoReviewPage(requisition);
              },
              onMoreTap: () {
                _showMoreInfo(context, controller.state.response[index]);
              },
              title: 'TRN',
              titleValue: controller.state.response[index].trn,
              subTitle: 'Branch',
              subTitleValue: controller.state.response[index].branchCode,
            );
          },
        ),
      );
    });
  }

   _showMoreInfo(BuildContext context, Requisition requisition) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return InfoBottomSheet(
              title: 'Requisition Information',
              actionButtonTitle: 'Edit',
              onActionButtonPressed: () {
                Get.back();
                gotoReviewPage(requisition);
              },
              list: [
                ReadonlyTitleValue(title: 'TRN', value: requisition.trn),
                ReadonlyTitleValue(
                    title: 'Branch', value: requisition.branchCode),
                ReadonlyTitleValue(title: 'User', value: requisition.userName),
                ReadonlyTitleValue(
                    title: 'Status', value: requisition.reqStatus),
              ]);
        });
  }

  void gotoReviewPage(Requisition requisition) async {
    var result =
        await Get.toNamed(Routes.requisitionReview, arguments: requisition.toJson());
    // if(result == true) {
    //   controller.getRequisitions(start: 1, limit: controller.defaultPagingSize.value, reset: true);
    // }
    controller.getRequisitions(start: 1, limit: controller.defaultPagingSize.value, reset: true);
  }
}
