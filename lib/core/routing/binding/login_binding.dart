import 'package:extra_pos/modules/auth/presentation/login/login_controller.dart';
import 'package:extra_pos/modules/home/presentation/home_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
