import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/app_state.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/branch_info_response.dart';
import 'package:extra_pos/modules/lookup/data/branch_lookup/branches_response.dart';
import 'package:get/get.dart';

class BranchInfoController extends GetxController {
  var client = Get.find<BaseApiClient>();

  var branchInfoState = AppState<BranchInfoResponse>();

  getBranchInfoAndNotify() async {
    branchInfoState.notifyLoading();
    try {
      var response = await client.get(URLs.getBranchInfo);
      var res = BranchInfoResponse.fromJson(response);
      branchInfoState.notifyCompleted(res);
    } on NetworkException catch (e) {
      branchInfoState.notifyError(e.getErrorMessage());
    }
  }

  Future<BranchInfoResponse> getCurrentBranchInfo() async {
    try {
      var response = await client.get(URLs.getBranchInfo);
      return BranchInfoResponse.fromJson(response);
    } on NetworkException catch (e) {
      return Future.error(e.getErrorMessage());
    }
  }
}
