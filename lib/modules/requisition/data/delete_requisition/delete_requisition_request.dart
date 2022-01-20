class DeleteRequisitionRequest {
  int? branchId;
  int? headerId;
  String? trn;

  DeleteRequisitionRequest({this.branchId, this.headerId, this.trn});

  DeleteRequisitionRequest.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    headerId = json['headerId'];
    trn = json['trn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['headerId'] = this.headerId;
    data['trn'] = this.trn;
    return data;
  }
}