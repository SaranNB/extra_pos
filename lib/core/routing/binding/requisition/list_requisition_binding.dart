import 'package:extra_pos/modules/requisition/presentation/list_requisition/list_requisition_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class ListRequisitionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListRequisitionController>(() => ListRequisitionController());
  }
}
