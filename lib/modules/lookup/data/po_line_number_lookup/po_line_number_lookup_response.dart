class POLineNumberLookupResponse {
  List<POLineNumber>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  POLineNumberLookupResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  POLineNumberLookupResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <POLineNumber>[];
      json['data'].forEach((v) {
        data!.add(new POLineNumber.fromJson(v));
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

class POLineNumber {
  String? lineIdGuid;
  int? branchId;
  int? lineId;
  int? headerBranchId;
  int? headerId;
  int? itemBranchId;
  int? itemId;
  String? itemDescription;
  int? lineNumber;
  String? lineType;
  int? uomBranchId;
  int? uomId;
  double? orderedQuantity;
  double? recdQuantity;
  double? taxAmount;
  double? unitCostVip;
  double? unitCostVep;
  int? taxCodeBranchId;
  int? taxCodeId;
  double? extendedCostVep;
  double? extendedCostVip;
  int? glAccountBranchId;
  int? glAccountCodeId;
  String? costType;
  double? listCost;
  double? discountAmount;
  double? actualMarkup;
  String? lineStatus;
  int? accountBranchId;
  int? accountCodeId;
  double? currentPrice;
  double? dealCost;
  int? orCodeBranchId;
  int? orCodeId;
  String? isFocEnabled;
  String? minMarkupType;
  int? recordNumber;
  int? lastUpdateNo;
  String? createdByUser;
  String? lastUpdateByUser;
  String? itemNumber;
  String? uom;
  String? taxCode;
  String? accountCode;
  double? extendedTaxAmount;
  String? recordIdGuid;
  double? bkorderQuantity;

  POLineNumber(
      {
        this.lineIdGuid,
        this.branchId,
        this.lineId,
        this.headerBranchId,
        this.headerId,
        this.itemBranchId,
        this.itemId,
        this.itemDescription,
        this.lineNumber,
        this.lineType,
        this.uomBranchId,
        this.uomId,
        this.orderedQuantity,
        this.recdQuantity,
        this.taxAmount,
        this.unitCostVip,
        this.unitCostVep,
        this.taxCodeBranchId,
        this.taxCodeId,
        this.extendedCostVep,
        this.extendedCostVip,
        this.glAccountBranchId,
        this.glAccountCodeId,
        this.costType,
        this.listCost,
        this.discountAmount,
        this.actualMarkup,
        this.lineStatus,
        this.accountBranchId,
        this.accountCodeId,
        this.currentPrice,
        this.dealCost,
        this.orCodeBranchId,
        this.orCodeId,
        this.isFocEnabled,
        this.minMarkupType,
        this.recordNumber,
        this.lastUpdateNo,
        this.createdByUser,
        this.lastUpdateByUser,
        this.itemNumber,
        this.uom,
        this.taxCode,
        this.accountCode,
        this.extendedTaxAmount,
        this.recordIdGuid});

  POLineNumber.fromJson(Map<String, dynamic> json) {
    lineIdGuid = json['lineIdGuid'];
    branchId = json['branchId'];
    lineId = json['lineId'];
    headerBranchId = json['headerBranchId'];
    headerId = json['headerId'];
    itemBranchId = json['itemBranchId'];
    itemId = json['itemId'];
    itemDescription = json['itemDescription'];
    lineNumber = json['lineNumber'];
    lineType = json['lineType'];
    uomBranchId = json['uomBranchId'];
    uomId = json['uomId'];
    orderedQuantity = json['orderedQuantity'].toDouble();
    recdQuantity = json['recdQuantity'];
    taxAmount = json['taxAmount'];
    unitCostVip = json['unitCostVip'];
    unitCostVep = json['unitCostVep'];
    taxCodeBranchId = json['taxCodeBranchId'];
    taxCodeId = json['taxCodeId'];
    extendedCostVep = json['extendedCostVep'];
    extendedCostVip = json['extendedCostVip'];
    glAccountBranchId = json['glAccountBranchId'];
    glAccountCodeId = json['glAccountCodeId'];
    costType = json['costType'];
    listCost = json['listCost'];
    discountAmount = json['discountAmount'];
    actualMarkup = json['actualMarkup'];
    lineStatus = json['lineStatus'];
    accountBranchId = json['accountBranchId'];
    accountCodeId = json['accountCodeId'];
    currentPrice = json['currentPrice'];
    dealCost = json['dealCost'];
    orCodeBranchId = json['orCodeBranchId'];
    orCodeId = json['orCodeId'];
    isFocEnabled = json['isFocEnabled'];
    minMarkupType = json['minMarkupType'];
    recordNumber = json['recordNumber'];
    lastUpdateNo = json['lastUpdateNo'];
    createdByUser = json['createdByUser'];
    lastUpdateByUser = json['lastUpdateByUser'];
    itemNumber = json['itemNumber'];
    uom = json['uom'];
    taxCode = json['taxCode'];
    accountCode = json['accountCode'];
    extendedTaxAmount = json['extendedTaxAmount'];
    recordIdGuid = json['recordIdGuid'];
    bkorderQuantity = json['bkorderQuantity'];
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
    data['itemDescription'] = this.itemDescription;
    data['lineNumber'] = this.lineNumber;
    data['lineType'] = this.lineType;
    data['uomBranchId'] = this.uomBranchId;
    data['uomId'] = this.uomId;
    data['orderedQuantity'] = this.orderedQuantity;
    data['recdQuantity'] = this.recdQuantity;
    data['taxAmount'] = this.taxAmount;
    data['unitCostVip'] = this.unitCostVip;
    data['unitCostVep'] = this.unitCostVep;
    data['taxCodeBranchId'] = this.taxCodeBranchId;
    data['taxCodeId'] = this.taxCodeId;
    data['extendedCostVep'] = this.extendedCostVep;
    data['extendedCostVip'] = this.extendedCostVip;
    data['glAccountBranchId'] = this.glAccountBranchId;
    data['glAccountCodeId'] = this.glAccountCodeId;
    data['costType'] = this.costType;
    data['listCost'] = this.listCost;
    data['discountAmount'] = this.discountAmount;
    data['actualMarkup'] = this.actualMarkup;
    data['lineStatus'] = this.lineStatus;
    data['accountBranchId'] = this.accountBranchId;
    data['accountCodeId'] = this.accountCodeId;
    data['currentPrice'] = this.currentPrice;
    data['dealCost'] = this.dealCost;
    data['orCodeBranchId'] = this.orCodeBranchId;
    data['orCodeId'] = this.orCodeId;
    data['isFocEnabled'] = this.isFocEnabled;
    data['minMarkupType'] = this.minMarkupType;
    data['recordNumber'] = this.recordNumber;
    data['lastUpdateNo'] = this.lastUpdateNo;
    data['createdByUser'] = this.createdByUser;
    data['lastUpdateByUser'] = this.lastUpdateByUser;
    data['itemNumber'] = this.itemNumber;
    data['uom'] = this.uom;
    data['taxCode'] = this.taxCode;
    data['accountCode'] = this.accountCode;
    data['extendedTaxAmount'] = this.extendedTaxAmount;
    data['recordIdGuid'] = this.recordIdGuid;
    data['bkorderQuantity'] = this.bkorderQuantity;
    return data;
  }
}
