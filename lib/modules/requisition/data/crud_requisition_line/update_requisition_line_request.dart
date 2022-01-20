class UpdateRequisitionLineRequest {
  int? branchId;
  int? lineId;
  int? headerBranchId;
  int? headerId;
  int? itemBranchId;
  int? itemId;
  int? uomBranchId;
  int? uomId;
  double? quantity;
  String? itemNumber;
  String? uom;
  String? statementType;
  int? lastUpdateNo;

  UpdateRequisitionLineRequest(
      {this.branchId,
        this.lineId,
        this.headerBranchId,
        this.headerId,
        this.itemBranchId,
        this.itemId,
        this.uomBranchId,
        this.uomId,
        this.quantity,
        this.itemNumber,
        this.uom,
        this.statementType,
        this.lastUpdateNo});

  UpdateRequisitionLineRequest.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    lineId = json['lineId'];
    headerBranchId = json['headerBranchId'];
    headerId = json['headerId'];
    itemBranchId = json['itemBranchId'];
    itemId = json['itemId'];
    uomBranchId = json['uomBranchId'];
    uomId = json['uomId'];
    quantity = json['quantity'];
    itemNumber = json['itemNumber'];
    uom = json['uom'];
    statementType = json['statementType'];
    lastUpdateNo = json['lastUpdateNo'];
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
    data['itemNumber'] = this.itemNumber;
    data['uom'] = this.uom;
    data['statementType'] = this.statementType;
    data['lastUpdateNo'] = this.lastUpdateNo;
    return data;
  }
}