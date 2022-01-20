import 'package:extra_pos/modules/requisition/presentation/index/requisition_home_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class RequisitionHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequisitionHomeController>(() => RequisitionHomeController());
  }
}
