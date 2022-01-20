import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/requisition_header_lookup/requisition_header_lookup_request.dart';
import 'package:extra_pos/modules/lookup/data/requisition_header_lookup/requisition_header_response.dart';
import 'package:get/get.dart';

class RequisitionHeaderLookupController extends GetxController {

  var client = Get.find<BaseApiClient>();
  
    Future<RequisitionHeaderResponse?> getRequisition({int? headerId, int? branchId, int? start, int? limit}) async {

      try {
        var request = RequisitionHeaderLookupRequest(
          headerId: headerId,
          branchId: branchId,
          start: start,
          limit: limit
        );
        var response = await client.get(URLs.getRequisitions, queryParameters: request.toJson());
        var res = RequisitionHeaderResponse.fromJson(response);
        return res;
      } on NetworkException catch(e) {
        Future.error(e.getErrorMessage());
      }
    }
  
}