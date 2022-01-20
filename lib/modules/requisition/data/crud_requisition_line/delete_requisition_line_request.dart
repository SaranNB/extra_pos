class DeleteRequisitionLineRequest {
  int? branchId;
  int? lineId;
  int? headerBranchId;
  int? headerId;
  String? statementType;
  int? lastUpdateNo;

  DeleteRequisitionLineRequest(
      {this.branchId,
        this.lineId,
        this.headerBranchId,
        this.headerId,
        this.statementType,
        this.lastUpdateNo});

  DeleteRequisitionLineRequest.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    lineId = json['lineId'];
    headerBranchId = json['headerBranchId'];
    headerId = json['headerId'];
    statementType = json['statementType'];
    lastUpdateNo = json['lastUpdateNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['lineId'] = this.lineId;
    data['headerBranchId'] = this.headerBranchId;
    data['headerId'] = this.headerId;
    data['statementType'] = this.statementType;
    data['lastUpdateNo'] = this.lastUpdateNo;
    return data;
  }
}