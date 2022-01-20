class InfoForRequisitionLineCrud {
  TrnInfo? trnInfo;
  RequisitionLineInfo? lineInfo;

  InfoForRequisitionLineCrud({this.trnInfo, this.lineInfo});

  InfoForRequisitionLineCrud.fromJson(Map<String, dynamic> json) {
    trnInfo =
    json['trnInfo'] != null ? new TrnInfo.fromJson(json['trnInfo']) : null;
    lineInfo = json['lineInfo'] != null
        ? new RequisitionLineInfo.fromJson(json['lineInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trnInfo != null) {
      data['trnInfo'] = this.trnInfo!.toJson();
    }
    if (this.lineInfo != null) {
      data['lineInfo'] = this.lineInfo!.toJson();
    }
    return data;
  }
}

class TrnInfo {
  String? trn;
  int? branchId;
  int? headerId;
  String? userName;
  String? branchCode;

  TrnInfo({this.trn, this.branchId, this.headerId, this.userName, this.branchCode});

  TrnInfo.fromJson(Map<String, dynamic> json) {
    trn = json['trn'];
    branchId = json['branchId'];
    headerId = json['headerId'];
    userName = json['userName'];
    branchCode = json['branchCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trn'] = this.trn;
    data['branchId'] = this.branchId;
    data['headerId'] = this.headerId;
    data['userName'] = this.userName;
    data['branchCode'] = this.branchCode;
    return data;
  }
}

class RequisitionLineInfo {
  int? branchId;
  int? headerBranchId;
  int? headerId;
  int? lineId;
  int? itemBranchId;
  int? itemId;
  String? itemNumber;
  String? itemDescription;
  int? uomBranchId;
  int? uomId;
  String? uom;
  double? quantity;
  double? noOfWeekStock;
  int? lastUpdateNo;

  RequisitionLineInfo(
      {this.branchId,
        this.headerBranchId,
        this.headerId,
        this.lineId,
        this.itemBranchId,
        this.itemId,
        this.itemNumber,
        this.itemDescription,
        this.uomBranchId,
        this.uomId,
        this.uom,
        this.quantity,
        this.noOfWeekStock,
        this.lastUpdateNo});

  RequisitionLineInfo.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    headerBranchId = json['headerBranchId'];
    headerId = json['headerId'];
    lineId = json['lineId'];
    itemBranchId = json['itemBranchId'];
    itemId = json['itemId'];
    itemNumber = json['itemNumber'];
    itemDescription = json['itemDescription'];
    uomBranchId = json['uomBranchId'];
    uomId = json['uomId'];
    uom = json['uom'];
    quantity = json['quantity'];
    noOfWeekStock = json['noOfWeekStock'];
    lastUpdateNo = json['lastUpdateNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['headerBranchId'] = this.headerBranchId;
    data['headerId'] = this.headerId;
    data['lineId'] = this.lineId;
    data['itemBranchId'] = this.itemBranchId;
    data['itemId'] = this.itemId;
    data['itemNumber'] = this.itemNumber;
    data['itemDescription'] = this.itemDescription;
    data['uomBranchId'] = this.uomBranchId;
    data['uomId'] = this.uomId;
    data['uom'] = this.uom;
    data['quantity'] = this.quantity;
    data['noOfWeekStock'] = this.noOfWeekStock;
    data['lastUpdateNo'] = this.lastUpdateNo;
    return data;
  }
}