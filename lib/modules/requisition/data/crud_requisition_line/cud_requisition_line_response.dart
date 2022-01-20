class CudRequisitionLineResponse {
  int? headerBranchId;
  int? branchId;
  bool? success;
  int? lineId;
  String? message;
  int? headerId;

  CudRequisitionLineResponse(
      {this.headerBranchId,
        this.branchId,
        this.success,
        this.lineId,
        this.message,
        this.headerId});

  CudRequisitionLineResponse.fromJson(Map<String, dynamic> json) {
    headerBranchId = json['headerBranchId'];
    branchId = json['branchId'];
    success = json['success'];
    lineId = json['lineId'];
    message = json['message'];
    headerId = json['headerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headerBranchId'] = this.headerBranchId;
    data['branchId'] = this.branchId;
    data['success'] = this.success;
    data['lineId'] = this.lineId;
    data['message'] = this.message;
    data['headerId'] = this.headerId;
    return data;
  }
}