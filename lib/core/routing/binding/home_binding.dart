import 'package:extra_pos/modules/home/presentation/home_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/user_info_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<UserInfoController>(() => UserInfoController());
  }
}
