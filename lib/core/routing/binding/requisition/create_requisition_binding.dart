import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/user_info_controller.dart';
import 'package:extra_pos/modules/requisition/presentation/create_requisition/create_requisition_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class CreateRequisitionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateRequisitionController>(() => CreateRequisitionController());
    Get.lazyPut<UserInfoController>(() => UserInfoController());
    Get.lazyPut<BranchInfoController>(() => BranchInfoController());
  }
}
