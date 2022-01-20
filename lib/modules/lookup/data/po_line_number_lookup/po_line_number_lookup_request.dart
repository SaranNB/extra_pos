class POLineNumberLookupRequest {
  String? itemCode;
  int? headerId;
  int? headerBranchId;
  int? itemId;
  int? itemBranchId;
  int? start;
  int? limit;

  POLineNumberLookupRequest(
      {this.itemCode,
        this.headerId,
        this.headerBranchId,
        this.itemId,
        this.itemBranchId,
        this.start,
        this.limit});

  POLineNumberLookupRequest.fromJson(Map<String, dynamic> json) {
    itemCode = json['itemCode'];
    headerId = json['headerId'];
    headerBranchId = json['headerBranchId'];
    itemId = json['itemId'];
    itemBranchId = json['itemBranchId'];
    start = json['start'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemCode'] = this.itemCode;
    data['headerId'] = this.headerId;
    data['headerBranchId'] = this.headerBranchId;
    data['itemId'] = this.itemId;
    data['itemBranchId'] = this.itemBranchId;
    data['start'] = this.start;
    data['limit'] = this.limit;
    return data;
  }
}