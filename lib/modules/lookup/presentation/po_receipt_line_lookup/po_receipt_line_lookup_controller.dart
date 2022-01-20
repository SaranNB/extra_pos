import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/base_api_client.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/modules/lookup/data/po_receipt_line_lookup/po_receipt_line_request.dart';
import 'package:extra_pos/modules/lookup/data/po_receipt_line_lookup/po_receipt_line_response.dart';
import 'package:get/get.dart';

class POReceiptLineLookupController extends GetxController {
  var client = Get.find<BaseApiClient>();

  Future<POReceiptLineListResponse?> getPOReceiptLines(
      {int? branchId,
      int? lineId,
      int? headerBranchId,
      int? headerId,
      String? itemCode,
      int? start,
      int? limit}) async {
    try {
      var request = POReceiptLineRequest(
          branchId: branchId,
          lineId: lineId,
          headerBranchId: headerBranchId,
          headerId: headerId,
          itemCode: itemCode,
          start: start,
          limit: limit);
      var response = await client.get(URLs.getPOReceiptLines,
          queryParameters: request.toJson());
      var res = POReceiptLineListResponse.fromJson(response);
      return res;
    } on NetworkException catch (e) {
      Future.error(e.getErrorMessage());
    }
  }
}
