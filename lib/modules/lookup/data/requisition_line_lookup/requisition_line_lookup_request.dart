class RequisitionLineLookupRequest {
  int? lineId;
  int? branchId;
  int? headerId;
  int? headerBranchId;
  int? limit;
  int? start;

  RequisitionLineLookupRequest(
      {this.lineId,
        this.branchId,
        this.headerId,
        this.headerBranchId,
        this.limit,
        this.start});

  RequisitionLineLookupRequest.fromJson(Map<String, dynamic> json) {
    lineId = json['lineId'];
    branchId = json['branchId'];
    headerId = json['headerId'];
    headerBranchId = json['headerBranchId'];
    limit = json['limit'];
    start = json['start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lineId'] = this.lineId;
    data['branchId'] = this.branchId;
    data['headerId'] = this.headerId;
    data['headerBranchId'] = this.headerBranchId;
    data['limit'] = this.limit;
    data['start'] = this.start;
    return data;
  }
}