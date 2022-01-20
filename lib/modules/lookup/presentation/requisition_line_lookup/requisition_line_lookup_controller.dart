import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/requisition_header_lookup/requisition_header_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/requisition_header_lookup/requisition_header_response.dart';
import 'package:extra_pos/modules/lookup/data/requisition_line_lookup/requisition_line_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/requisition_line_lookup/requisition_line_lookup_response.dart';
import 'package:get/get.dart';

class RequisitionLineLookupController extends GetxController {
  var client = Get.find<BaseApiClient>();

  Future<RequisitionLineLookupResponse?> getRequisitionLine(
      {int? lineId,
      int? branchId,
      int? headerId,
      int? headerBranchId,
      int? start,
      int? limit}) async {
    try {
      var request = RequisitionLineLookupRequest(
          lineId: lineId,
          branchId: branchId,
          headerId: headerId,
          headerBranchId: headerBranchId,
          start: start,
          limit: limit);
      var response = await client.get(URLs.getRequisitionLines,
          queryParameters: request.toJson());
      var res = RequisitionLineLookupResponse.fromJson(response);
      return res;
    } on NetworkException catch (e) {
      Future.error(e.getErrorMessage());
    }
  }
}
