import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/i18n/translation_titles.dart';
import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/stores/auth_store.dart';
import 'package:extra_pos/core/utils/app_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/core/utils/validation_message.dart';
import 'package:extra_pos/core/widgets/dialogs/circular_progress_loader_dialog.dart';
import 'package:extra_pos/modules/auth/data/login/login_request.dart';
import 'package:extra_pos/modules/auth/data/login/login_response.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var client = Get.find<BaseApiClient>();

  var username = ''.obs;
  var password = ''.obs;

  var isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void reset() {
    username.value = '';
    password.value = '';
    isPasswordVisible.value = false;
  }

  changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  var usernameValidation = new ValidationMessage().obs;
  var passwordValidation = new ValidationMessage().obs;

  var loginState = AppState<LoginResponse>();

  login() async {
    CircularProgressLoaderDialog.showLoader(
        Get.context!, TT.loading_message_login.tr);
    var request =
        LoginRequest(username: username.value, password: password.value);
    loginState.notifyLoading();
    try {
      var response = await client.post(URLs.login, body: request.toJson());
      var loginResponse = LoginResponse.fromJson(response);
      AuthStore.to.saveTokens(loginResponse.token, loginResponse.refreshToken);
      loginState.notifyCompleted(loginResponse);
      // Get.back();
      Get.offAllNamed(Routes.home);
    } on NetworkException catch (e) {
      Get.back();
      loginState.notifyError(e.getErrorMessage());
    }
  }
}
