import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_constants.dart';
import 'package:extra_pos/core/utils/app_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/core/widgets/dialogs/circular_progress_loader_dialog.dart';
import 'package:extra_pos/modules/lookup/presentation/branch_info_controller.dart';
import 'package:extra_pos/modules/lookup/presentation/user_info_controller.dart';
import 'package:extra_pos/modules/requisition/data/create_requisition/create_requisition_request.dart';
import 'package:extra_pos/modules/requisition/data/create_requisition/create_requisition_response.dart';
import 'package:extra_pos/modules/requisition/data/crud_requisition_line/trn_line_info.dart';
import 'package:get/get.dart';

class CreateRequisitionController extends GetxController {
  var client = Get.find<BaseApiClient>();

  var userInfoController = Get.find<UserInfoController>();
  var branchInfoController = Get.find<BranchInfoController>();

  var createRequisitionState = AppState<CreateRequisitionResponse>();

  var isMoreInfoSwitchOn = AppConstants.isMoreInfoSwitchOn.obs;

  setMoreInfoSwitchState(bool value) {
    this.isMoreInfoSwitchOn.value = value;
  }

  @override
  void onInit() {
    userInfoController.getUserInfoAndNotify();
    branchInfoController.getBranchInfoAndNotify();
    super.onInit();
  }

  createRequisition() async {
    createRequisitionState.notifyLoading();
    CircularProgressLoaderDialog.showLoader(
        Get.context!, 'Creating requisition, please wait...');
    try {
      var request = new CreateRequisitionHeaderRequest();
      var tempRequisitionHeader = TempRequisitionHeader();
      var currentBranch = await branchInfoController.getCurrentBranchInfo();
      var currentBranchCodeId = currentBranch.data![0].branchId;
      tempRequisitionHeader.branchCodeId = currentBranchCodeId;
      tempRequisitionHeader.reqStatus = 'NEW';
      tempRequisitionHeader.reqSource = 'MOBILE';
      tempRequisitionHeader.statementType = 'INSERT';
      request.tempRequisitionHeader = tempRequisitionHeader;

      var response = await client.put(URLs.crudTempRequisitionHeaderAndLine,
          body: request.toJson());
      var res = CreateRequisitionResponse.fromJson(response);
      createRequisitionState.notifyCompleted(res);
      Get.back();
      
      var requisitionInfo = InfoForRequisitionLineCrud(
        trnInfo: TrnInfo(
            trn: res.trn,
            branchId: res.branchId,
            headerId: res.headerId
        )
      );
      
      // Get.offNamed(Routes.createPart, arguments: res.toJson());
      Get.offNamed(Routes.crudRequisitionItem, arguments: requisitionInfo.toJson());
    } on NetworkException catch (e) {
      Get.back();
      createRequisitionState.notifyError(e.getErrorMessage());
    }
  }
}