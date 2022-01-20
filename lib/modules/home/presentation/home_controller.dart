import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/stores/auth_store.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var client = Get.find<BaseApiClient>();

  var username = ''.obs;

  logout() {
    AuthStore.to.logout();
  }


}
