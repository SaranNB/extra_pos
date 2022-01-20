import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/user_info_response.dart';
import 'package:get/get.dart';

class UserInfoController extends GetxController {

  var client = Get.find<BaseApiClient>();

  var userInfoState = AppState<UserInfoResponse>();

  getUserInfoAndNotify() async {
    userInfoState.notifyLoading();
    try {
      var serverResponse = await client.get(URLs.getUserInfo);
      var response = UserInfoResponse.fromJson(serverResponse);
      userInfoState.notifyCompleted(response);
    } on NetworkException catch (e) {
      userInfoState.notifyError(e.getErrorMessage());
    }
  }

  Future<UserInfoResponse?> getUserInfo() async {
    try {
      var serverResponse = await client.get(URLs.getUserInfo);
      var response = UserInfoResponse.fromJson(serverResponse);
      return response;
    } on NetworkException catch (e) {
      Future.error(e.getErrorMessage());
    }
  }
  
}