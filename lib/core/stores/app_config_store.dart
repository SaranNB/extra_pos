import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/services/local_storage_get.dart';
import 'package:get/get.dart';

class AppConfigStore extends GetxController {
  AppConfigStore(this._storage);

  static AppConfigStore get to => Get.find();

  static const APP_URL = 'APP_URL';

  String? appUrl;

  final LocalStorage _storage;

  @override
  void onInit() {
    super.onInit();
    appUrl = _storage.read(APP_URL);
  }

  Future saveAppUrl(String? appUrl) async {
    await _storage.write(APP_URL, appUrl);
    this.appUrl = appUrl;
    update();
  }

  bool isAppUrlConfigured() {
    if(appUrl != null)
      return true;

    return false;
  }

  // void gotoConfigPage() {
  //   Get.offAllNamed(Routes.appUrlConfig);
  // }

}