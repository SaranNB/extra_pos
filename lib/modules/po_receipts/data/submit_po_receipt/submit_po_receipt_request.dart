class SubmitPOReceiptRequest {
  int? branchId;
  int? headerId;
  String? receiptNumber;
  String? isWarningAccepted;

  SubmitPOReceiptRequest(
      {this.branchId,
      this.headerId,
      this.receiptNumber,
      this.isWarningAccepted});

  SubmitPOReceiptRequest.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    headerId = json['headerId'];
    receiptNumber = json['receiptNumber'];
    isWarningAccepted = json['isWarningAccepted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['headerId'] = this.headerId;
    data['receiptNumber'] = this.receiptNumber;
    data['isWarningAccepted'] = this.isWarningAccepted;
    return data;
  }
}
