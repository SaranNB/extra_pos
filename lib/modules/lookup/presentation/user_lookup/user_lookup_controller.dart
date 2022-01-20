import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/user_lookup/user_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/user_lookup/users_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserLookupController extends GetxController {
  var client = Get.find<BaseApiClient>();

  var defaultPagingSize = 25.obs;

  var searchByUsernameTextController = TextEditingController();

  var userNameFilter = '';

  var state = AppPagingState<User>();

  void resetState() {
    state = AppPagingState<User>();
  }

  resetSearchFilter() {
    searchByUsernameTextController.text = '';
  }

  onSearchTap({int? start, int? limit}) {
    userNameFilter = searchByUsernameTextController.text;
    getUsers(start: start!, limit: limit!, reset: true);
  }

  getUsers({int? start, int? limit, bool reset: false}) async {
    if (reset) {
      state.notifyReset();
    }
    state.notifyLoading();

    try {
      var request = UserLookupRequest(
          start: start,
          limit: limit,
          activeFlag: 'Y',
          userName: userNameFilter);
      var response = await client.get('${URLs.usersLookup}',
          queryParameters: request.toMap());
      var res = UsersResponse.fromJson(response);
      state.addItems(res.data!, res.start!, res.limit!, defaultPagingSize.value,
          res.totalRecords!);
    } on NetworkException catch (e) {
      state.notifyError(e.getErrorMessage());
    }
  }
}
