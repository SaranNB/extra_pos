class SubmitTempRequisitionRequest {
  int? branchId;
  int? headerId;
  String? statementType;

  SubmitTempRequisitionRequest({this.branchId, this.headerId, this.statementType});

  SubmitTempRequisitionRequest.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    headerId = json['headerId'];
    statementType = json['statementType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['headerId'] = this.headerId;
    data['statementType'] = this.statementType;
    return data;
  }
}