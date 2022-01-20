import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/stores/app_config_store.dart';
import 'package:extra_pos/core/utils/validation_message.dart';
import 'package:extra_pos/modules/auth/presentation/login/login_page.dart';
import 'package:get/get.dart';
import 'package:extra_pos/extensions.dart';

class AppUrlConfigController extends GetxController {

  var appUrl = ''.obs;

  var appUrlValidation = new ValidationMessage().obs;

  @override
  void onInit() {
    super.onInit();
    this.appUrl.value = AppConfigStore.to.appUrl!;
  }

  validateAppUrl() {
    bool iValidUrl = Uri.parse(this.appUrl.value).isAbsolute;
    if(!iValidUrl) {
      appUrlValidation.setError('Invalid URL');
      return;
    }

    appUrlValidation.setValid();
  }

  isValidForm() {
    validateAppUrl();

    return appUrlValidation.valid;
  }

  saveAppUrl() async {
    if (!isValidForm())
      return;
    await AppConfigStore.to.saveAppUrl(appUrl.value);
    Get.offAllNamed(Routes.login);
  }

}