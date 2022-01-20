import 'package:dio/dio.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/services/local_storage_get.dart';
import 'package:extra_pos/core/stores/app_config_store.dart';
import 'package:extra_pos/core/stores/auth_store.dart';
import 'package:extra_pos/modules/home/presentation/home_controller.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalStorage>(() => LocalStorageImpl());
    Get.put<AuthStore>(AuthStore(Get.find<LocalStorage>()), permanent: true);
    Get.put<AppConfigStore>(AppConfigStore(Get.find<LocalStorage>()), permanent: true);
    Get.put<BaseApiClient>(BaseApiClientImpl(Dio()), permanent: true);
  }
}
