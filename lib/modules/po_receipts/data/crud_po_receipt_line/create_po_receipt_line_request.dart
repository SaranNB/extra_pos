class CreatePOReceiptLineRequest {
  int? headerBranchId;
  int? headerId;
  int? poLineBranchId;
  int? poLineId;
  int? itemBranchId;
  int? itemId;
  String? itemNumber;
  int? uomBranchId;
  int? uomId;
  String? uom;
  double? orderedQuantity;
  double? recdNowQuantity;
  int? recdNowUomBranchId;
  int? recdNowUomId;
  double? unitCostVip;
  double? unitCostVep;
  double? tax;
  double? extCostVip;
  double? extCostVep;
  double? extTax;
  String? statementType;

  CreatePOReceiptLineRequest(
      {this.headerBranchId,
      this.headerId,
      this.poLineBranchId,
      this.poLineId,
      this.itemBranchId,
      this.itemId,
      this.itemNumber,
      this.uomBranchId,
      this.uomId,
      this.uom,
      this.orderedQuantity,
      this.recdNowQuantity,
      this.recdNowUomBranchId,
      this.recdNowUomId,
      this.unitCostVip,
      this.unitCostVep,
      this.tax,
      this.extCostVip,
      this.extCostVep,
      this.extTax,
      this.statementType});

  CreatePOReceiptLineRequest.fromJson(Map<String, dynamic> json) {
    headerBranchId = json['headerBranchId'];
    headerId = json['headerId'];
    poLineBranchId = json['poLineBranchId'];
    poLineId = json['poLineId'];
    itemBranchId = json['itemBranchId'];
    itemId = json['itemId'];
    itemNumber = json['itemNumber'];
    uomBranchId = json['uomBranchId'];
    uomId = json['uomId'];
    uom = json['uom'];
    orderedQuantity = json['orderedQuantity'];
    recdNowQuantity = json['recdNowQuantity'];
    recdNowUomBranchId = json['recdNowUomBranchId'];
    recdNowUomId = json['recdNowUomId'];
    unitCostVip = json['unitCostVip'];
    unitCostVep = json['unitCostVep'];
    tax = json['tax'];
    extCostVip = json['extCostVip'];
    extCostVep = json['extCostVep'];
    extTax = json['extTax'];
    statementType = json['statementType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headerBranchId'] = this.headerBranchId;
    data['headerId'] = this.headerId;
    data['poLineBranchId'] = this.poLineBranchId;
    data['poLineId'] = this.poLineId;
    data['itemBranchId'] = this.itemBranchId;
    data['itemId'] = this.itemId;
    data['itemNumber'] = this.itemNumber;
    data['uomBranchId'] = this.uomBranchId;
    data['uomId'] = this.uomId;
    data['uom'] = this.uom;
    data['orderedQuantity'] = this.orderedQuantity;
    data['recdNowQuantity'] = this.recdNowQuantity;
    data['recdNowUomBranchId'] = this.recdNowUomBranchId;
    data['recdNowUomId'] = this.recdNowUomId;
    data['unitCostVip'] = this.unitCostVip;
    data['unitCostVep'] = this.unitCostVep;
    data['tax'] = this.tax;
    data['extCostVip'] = this.extCostVip;
    data['extCostVep'] = this.extCostVep;
    data['extTax'] = this.extTax;
    data['statementType'] = this.statementType;
    return data;
  }
}
