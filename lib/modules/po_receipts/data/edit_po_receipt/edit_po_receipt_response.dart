class UpdatePOReceiptHeaderResponse {
  int? branchId;
  bool? success;
  String? message;
  int? headerId;

  UpdatePOReceiptHeaderResponse(
      {this.branchId, this.success, this.message, this.headerId});

  UpdatePOReceiptHeaderResponse.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    success = json['success'];
    message = json['message'];
    headerId = json['headerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['success'] = this.success;
    data['message'] = this.message;
    data['headerId'] = this.headerId;
    return data;
  }
}
