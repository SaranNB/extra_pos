class CudPOReceiptLineResponse {
  int? headerBranchId;
  int? headerId;
  int? branchId;
  int? lineId;
  bool? success;
  String? message;

  CudPOReceiptLineResponse(
      {this.headerBranchId,
        this.headerId,
        this.branchId,
        this.lineId,
        this.success,
        this.message});

  CudPOReceiptLineResponse.fromJson(Map<String, dynamic> json) {
    headerBranchId = json['headerBranchId'];
    headerId = json['headerId'];
    branchId = json['branchId'];
    lineId = json['lineId'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headerBranchId'] = this.headerBranchId;
    data['headerId'] = this.headerId;
    data['branchId'] = this.branchId;
    data['lineId'] = this.lineId;
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
