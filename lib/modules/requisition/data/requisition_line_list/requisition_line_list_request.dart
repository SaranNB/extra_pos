class RequisitionLineListRequest {
  int? start;
  int? limit;
  int? headerBranchId;
  int? headerId;
  String? itemNumber;

  RequisitionLineListRequest(
      {this.start,
        this.limit,
        this.headerBranchId,
        this.headerId,
        this.itemNumber});

  RequisitionLineListRequest.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    limit = json['limit'];
    headerBranchId = json['headerBranchId'];
    headerId = json['headerId'];
    itemNumber = json['itemNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['limit'] = this.limit;
    data['headerBranchId'] = this.headerBranchId;
    data['headerId'] = this.headerId;
    data['itemNumber'] = this.itemNumber;
    return data;
  }
}