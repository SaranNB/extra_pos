class CreateRequisitionResponse {
  String? trn;
  int? branchId;
  bool? success;
  String? message;
  int? headerId;

  CreateRequisitionResponse(
      {this.trn, this.branchId, this.success, this.message, this.headerId});

  CreateRequisitionResponse.fromJson(Map<String, dynamic> json) {
    trn = json['trn'];
    branchId = json['branchId'];
    success = json['success'];
    message = json['message'];
    headerId = json['headerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trn'] = this.trn;
    data['branchId'] = this.branchId;
    data['success'] = this.success;
    data['message'] = this.message;
    data['headerId'] = this.headerId;
    return data;
  }
}