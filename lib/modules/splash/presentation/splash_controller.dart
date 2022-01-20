import 'dart:async';

import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/stores/app_config_store.dart';
import 'package:extra_pos/core/stores/auth_store.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  final int SPLASH_TIMEOUT = 3; // in seconds

  @override
  void onInit() {
    super.onInit();
    initSplashTimer();
  }

  void initSplashTimer() {
    Timer(Duration(seconds: 3), () {
      if(AuthStore.to.isLoggedIn()) {
        gotoHome();
        return;
      }

      if(!AppConfigStore.to.isAppUrlConfigured()) {
        gotoAppUrlConfigPage();
        return;
      }

      gotoLogin();
    });
  }

  gotoLogin() {
    Get.offAllNamed(Routes.login);
  }

  gotoHome() {
    Get.offAllNamed(Routes.home);
  }

  gotoAppUrlConfigPage() {
    Get.offAllNamed(Routes.appUrlConfig);
  }


}