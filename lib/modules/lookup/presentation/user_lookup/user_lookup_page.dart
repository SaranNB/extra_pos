import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/cards/app_list_item_card.dart';
import 'package:extra_pos/core/widgets/expandable/search_exbandable_card.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:extra_pos/core/widgets/listview/app_paged_listview.dart';
import 'package:extra_pos/core/widgets/listview/list_header.dart';
import 'package:extra_pos/modules/lookup/data/user_lookup/users_response.dart';
import 'package:extra_pos/modules/lookup/presentation/user_lookup/user_lookup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLookupPage extends StatelessWidget {

  final Function(User selectedUser)? onUserSelected;

  UserLookupPage({this.onUserSelected});

  var controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(UserLookupController());
    controller.resetState();

    return BaseScaffold(
      shouldIncludeScrolling: false,
      appBar: BaseAppBar(title: 'Select User'),
      body: Column(
          children: [
            _buildSearchFiltersUi(),
            _buildListHeader(),
            _buildUsersList()
          ]
      ),
    );
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
              title: 'Search by Username',
              hint: 'Search',
              controller: controller.searchByUsernameTextController,
              suffixIcon: Icon(Icons.search))
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

  _buildUsersList() {
    return Obx(() {
      return Expanded(
        child: AppPaginationView(
          pageSize: controller.defaultPagingSize.value,
          onListReady: (int start, int limit) {
            controller.getUsers(start: start, limit: limit);
          },
          onReadyToNextPage: (int currentPage, int nextPage, int pageSize,
              int start, int limit) {
            controller.getUsers(start: start, limit: limit);
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
                  onUserSelected!(controller.state.response[index]);
                },
                isMoreButtonNeeded: false,
                title: 'Name',
                titleValue: '${controller.state.response[index].firstName} ${controller.state.response[index].lastName}',
                subTitle: 'Email',
                subTitleValue: controller.state.response[index].email,
              );
          },
        ),
      );
    });
  }

}
