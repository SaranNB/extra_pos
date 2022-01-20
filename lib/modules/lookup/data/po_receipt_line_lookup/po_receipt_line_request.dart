class POReceiptLineRequest {
  int? branchId;
  int? headerBranchId;
  int? headerId;
  String? itemCode;
  int? lineId;
  int? start;
  int? limit;

  POReceiptLineRequest(
      {this.branchId,
        this.headerBranchId,
        this.headerId,
        this.itemCode,
        this.lineId,
        this.start,
        this.limit});

  POReceiptLineRequest.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    headerBranchId = json['headerBranchId'];
    headerId = json['headerId'];
    itemCode = json['itemCode'];
    lineId = json['lineId'];
    start = json['start'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['headerBranchId'] = this.headerBranchId;
    data['headerId'] = this.headerId;
    data['itemCode'] = this.itemCode;
    data['lineId'] = this.lineId;
    data['start'] = this.start;
    data['limit'] = this.limit;
    return data;
  }
}