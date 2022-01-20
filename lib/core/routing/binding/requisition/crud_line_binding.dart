import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/user_info_controller.dart';
import 'package:extra_pos/modules/requisition/presentation/crud_requisition_line/crud_requisition_line_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class CreatePartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrudRequisitionLineController>(() => CrudRequisitionLineController());
    Get.lazyPut<UserInfoController>(() => UserInfoController());
    Get.lazyPut<BranchInfoController>(() => BranchInfoController());
  }
}
