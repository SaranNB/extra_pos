class CreateRequisitionLineRequest {
  int? headerBranchId;
  int? headerId;
  int? itemBranchId;
  int? itemId;
  int? uomBranchId;
  int? uomId;
  double? quantity;
  String? statementType;

  CreateRequisitionLineRequest(
      {this.headerBranchId,
        this.headerId,
        this.itemBranchId,
        this.itemId,
        this.uomBranchId,
        this.uomId,
        this.quantity,
        this.statementType});

  CreateRequisitionLineRequest.fromJson(Map<String?, dynamic> json) {
    headerBranchId = json['headerBranchId'];
    headerId = json['headerId'];
    itemBranchId = json['itemBranchId'];
    itemId = json['itemId'];
    uomBranchId = json['uomBranchId'];
    uomId = json['uomId'];
    quantity = json['quantity'];
    statementType = json['statementType'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['headerBranchId'] = this.headerBranchId;
    data['headerId'] = this.headerId;
    data['itemBranchId'] = this.itemBranchId;
    data['itemId'] = this.itemId;
    data['uomBranchId'] = this.uomBranchId;
    data['uomId'] = this.uomId;
    data['quantity'] = this.quantity;
    data['statementType'] = this.statementType;
    return data;
  }
}