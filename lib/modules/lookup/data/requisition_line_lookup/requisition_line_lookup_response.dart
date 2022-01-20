class RequisitionLineLookupResponse {
  List<LineResponse>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  RequisitionLineLookupResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  RequisitionLineLookupResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LineResponse>[];
      json['data'].forEach((v) {
        data!.add(new LineResponse.fromJson(v));
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

class LineResponse {
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
  int? lastUpdateNo;
  String? itemNumber;
  String? itemDescription;
  String? uom;

  LineResponse(
      {this.branchId,
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
        this.lastUpdateNo,
        this.itemNumber,
        this.itemDescription,
        this.uom});

  LineResponse.fromJson(Map<String, dynamic> json) {
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
    lastUpdateNo = json['lastUpdateNo'];
    itemNumber = json['itemNumber'];
    itemDescription = json['itemDescription'];
    uom = json['uom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['lastUpdateNo'] = this.lastUpdateNo;
    data['itemNumber'] = this.itemNumber;
    data['itemDescription'] = this.itemDescription;
    data['uom'] = this.uom;
    return data;
  }
}