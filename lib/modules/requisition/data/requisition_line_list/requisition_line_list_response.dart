class RequisitionLineListResponse {
  List<RequisitionLine>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  RequisitionLineListResponse(
      {this.data,
      this.totalRecords,
      this.start,
      this.limit,
      this.message,
      this.success});

  RequisitionLineListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new RequisitionLine.fromJson(v));
      });
    }
    totalRecords = json['totalRecords'];
    start = json['start'];
    limit = json['limit'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalRecords'] = this.totalRecords;
    data['start'] = this.start;
    data['limit'] = this.limit;
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class RequisitionLine {
 
  String? lineIdGuid;
  int? branchId;
  int? lineId;
  int? headerBranchId;
  int? headerId;
  int? itemBranchId;
  int? itemId;
  int? uomBranchId;
  int? uomId;
  double? quantity;
  double? noOfWeekStock;
  double? onOrderQuantity;
  int? recordNumber;
  int? lastUpdateNo;
  String? createdByUser;
  String? lastUpdateByUser;
  String? itemNumber;
  String? itemDescription;
  String? uom;
  String? recordIdGuid;

  RequisitionLine(
      {
      this.lineIdGuid,
      this.branchId,
      this.lineId,
      this.headerBranchId,
      this.headerId,
      this.itemBranchId,
      this.itemId,
      this.uomBranchId,
      this.uomId,
      this.quantity,
      this.noOfWeekStock,
      this.onOrderQuantity,
      this.recordNumber,
      this.lastUpdateNo,
      this.createdByUser,
      this.lastUpdateByUser,
      this.itemNumber,
      this.itemDescription,
      this.uom,
      this.recordIdGuid});

  RequisitionLine.fromJson(Map<String, dynamic> json) {
  
    lineIdGuid = json['lineIdGuid'];
    branchId = json['branchId'];
    lineId = json['lineId'];
    headerBranchId = json['headerBranchId'];
    headerId = json['headerId'];
    itemBranchId = json['itemBranchId'];
    itemId = json['itemId'];
    uomBranchId = json['uomBranchId'];
    uomId = json['uomId'];
    quantity = json['quantity'] == null ? 0.0 : json['quantity'].toDouble();
    noOfWeekStock = json['noOfWeekStock'] == null ? 0.0 : json['noOfWeekStock'].toDouble();
    onOrderQuantity = json['onOrderQuantity'] == null ? 0.0 : json['onOrderQuantity'].toDouble();
    recordNumber = json['recordNumber'];
    lastUpdateNo = json['lastUpdateNo'];
    createdByUser = json['createdByUser'];
    lastUpdateByUser = json['lastUpdateByUser'];
    itemNumber = json['itemNumber'];
    itemDescription = json['itemDescription'];
    uom = json['uom'];
    recordIdGuid = json['recordIdGuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lineIdGuid'] = this.lineIdGuid;
    data['branchId'] = this.branchId;
    data['lineId'] = this.lineId;
    data['headerBranchId'] = this.headerBranchId;
    data['headerId'] = this.headerId;
    data['itemBranchId'] = this.itemBranchId;
    data['itemId'] = this.itemId;
    data['uomBranchId'] = this.uomBranchId;
    data['uomId'] = this.uomId;
    data['quantity'] = this.quantity;
    data['noOfWeekStock'] = this.noOfWeekStock;
    data['onOrderQuantity'] = this.onOrderQuantity;
    data['recordNumber'] = this.recordNumber;
    data['lastUpdateNo'] = this.lastUpdateNo;
    data['createdByUser'] = this.createdByUser;
    data['lastUpdateByUser'] = this.lastUpdateByUser;
    data['itemNumber'] = this.itemNumber;
    data['itemDescription'] = this.itemDescription;
    data['uom'] = this.uom;
    data['recordIdGuid'] = this.recordIdGuid;
    return data;
  }
}