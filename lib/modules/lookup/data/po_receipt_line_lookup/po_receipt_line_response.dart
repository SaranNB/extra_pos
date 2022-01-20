class POReceiptLineListResponse {
  List<POReceiptLine>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  POReceiptLineListResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  POReceiptLineListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <POReceiptLine>[];
      json['data'].forEach((v) {
        data!.add(new POReceiptLine.fromJson(v));
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

class POReceiptLine {
  int? createdBy;
  String? createDate;
  int? lastUpdatedBy;
  String? lastUpdateDate;
  String? lineIdGuid;
  int? branchId;
  int? lineId;
  int? headerBranchId;
  int? headerId;
  int? poLineBranchId;
  int? poLineId;
  int? itemBranchId;
  int? itemId;
  int? uomBranchId;
  int? uomId;
  double? orderedQuantity;
  double? recdNowQuantity;
  int? recdNowUomBranchId;
  int? recdNowUomId;
  double? extCostVep;
  double? extCostVip;
  double? unitCostVep;
  double? unitCostVip;
  double? tax;
  double? extTax;
  String? recordIdGuid;
  int? recordNumber;
  String? createdByUser;
  String? lastUpdateByUser;
  int? lastUpdateNo;
  String? itemNumber;
  String? itemDescription;
  String? uom;
  String? recdNowUom;
  String? poNumber;
  int? poLineNumber;

  POReceiptLine(
      {this.createdBy,
        this.createDate,
        this.lastUpdatedBy,
        this.lastUpdateDate,
        this.lineIdGuid,
        this.branchId,
        this.lineId,
        this.headerBranchId,
        this.headerId,
        this.poLineBranchId,
        this.poLineId,
        this.itemBranchId,
        this.itemId,
        this.uomBranchId,
        this.uomId,
        this.orderedQuantity,
        this.recdNowQuantity,
        this.recdNowUomBranchId,
        this.recdNowUomId,
        this.extCostVep,
        this.extCostVip,
        this.unitCostVep,
        this.unitCostVip,
        this.tax,
        this.extTax,
        this.recordIdGuid,
        this.recordNumber,
        this.createdByUser,
        this.lastUpdateByUser,
        this.lastUpdateNo,
        this.itemNumber,
        this.itemDescription,
        this.uom,
        this.recdNowUom,
        this.poNumber,
        this.poLineNumber});

  POReceiptLine.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    createDate = json['createDate'];
    lastUpdatedBy = json['lastUpdatedBy'];
    lastUpdateDate = json['lastUpdateDate'];
    lineIdGuid = json['lineIdGuid'];
    branchId = json['branchId'];
    lineId = json['lineId'];
    headerBranchId = json['headerBranchId'];
    headerId = json['headerId'];
    poLineBranchId = json['poLineBranchId'];
    poLineId = json['poLineId'];
    itemBranchId = json['itemBranchId'];
    itemId = json['itemId'];
    uomBranchId = json['uomBranchId'];
    uomId = json['uomId'];
    orderedQuantity = json['orderedQuantity'];
    recdNowQuantity = json['recdNowQuantity'];
    recdNowUomBranchId = json['recdNowUomBranchId'];
    recdNowUomId = json['recdNowUomId'];
    extCostVep = json['extCostVep'];
    extCostVip = json['extCostVip'];
    unitCostVep = json['unitCostVep'];
    unitCostVip = json['unitCostVip'];
    tax = json['tax'];
    extTax = json['extTax'];
    recordIdGuid = json['recordIdGuid'];
    recordNumber = json['recordNumber'];
    createdByUser = json['createdByUser'];
    lastUpdateByUser = json['lastUpdateByUser'];
    lastUpdateNo = json['lastUpdateNo'];
    itemNumber = json['itemNumber'];
    itemDescription = json['itemDescription'];
    uom = json['uom'];
    recdNowUom = json['recdNowUom'];
    poNumber = json['poNumber'];
    poLineNumber = json['poLineNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createDate'] = this.createDate;
    data['lastUpdatedBy'] = this.lastUpdatedBy;
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['lineIdGuid'] = this.lineIdGuid;
    data['branchId'] = this.branchId;
    data['lineId'] = this.lineId;
    data['headerBranchId'] = this.headerBranchId;
    data['headerId'] = this.headerId;
    data['poLineBranchId'] = this.poLineBranchId;
    data['poLineId'] = this.poLineId;
    data['itemBranchId'] = this.itemBranchId;
    data['itemId'] = this.itemId;
    data['uomBranchId'] = this.uomBranchId;
    data['uomId'] = this.uomId;
    data['orderedQuantity'] = this.orderedQuantity;
    data['recdNowQuantity'] = this.recdNowQuantity;
    data['recdNowUomBranchId'] = this.recdNowUomBranchId;
    data['recdNowUomId'] = this.recdNowUomId;
    data['extCostVep'] = this.extCostVep;
    data['extCostVip'] = this.extCostVip;
    data['unitCostVep'] = this.unitCostVep;
    data['unitCostVip'] = this.unitCostVip;
    data['tax'] = this.tax;
    data['extTax'] = this.extTax;
    data['recordIdGuid'] = this.recordIdGuid;
    data['recordNumber'] = this.recordNumber;
    data['createdByUser'] = this.createdByUser;
    data['lastUpdateByUser'] = this.lastUpdateByUser;
    data['lastUpdateNo'] = this.lastUpdateNo;
    data['itemNumber'] = this.itemNumber;
    data['itemDescription'] = this.itemDescription;
    data['uom'] = this.uom;
    data['recdNowUom'] = this.recdNowUom;
    data['poNumber'] = this.poNumber;
    data['poLineNumber'] = this.poLineNumber;
    return data;
  }
}
