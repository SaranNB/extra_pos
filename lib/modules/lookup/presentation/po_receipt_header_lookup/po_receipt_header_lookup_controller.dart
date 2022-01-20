import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/po_receipt_header_lookup/po_receipt_header_lookup_response.dart';
import 'package:extra_pos/modules/lookup/data/requisition_header_lookup/requisition_header_lookup_request.dart';
import 'package:get/get.dart';

class POReceiptHeaderLookupController extends GetxController {

  var client = Get.find<BaseApiClient>();

  Future<POReceiptHeaderLookupResponse?> getPOReceiptHeaders({int? headerId, int? branchId, int? start, int? limit}) async {

    try {
      var request = RequisitionHeaderLookupRequest(
          headerId: headerId,
          branchId: branchId,
          start: start,
          limit: limit
      );
      var response = await client.get(URLs.getPOReceipts, queryParameters: request.toJson());
      var res = POReceiptHeaderLookupResponse.fromJson(response);
      return res;
    } on NetworkException catch(e) {
      Future.error(e.getErrorMessage());
    }
  }

}