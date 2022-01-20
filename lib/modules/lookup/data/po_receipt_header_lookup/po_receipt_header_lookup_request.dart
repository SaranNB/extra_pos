class POReceiptHeaderLookupRequest {
  String? receiptNumber;
  String? receivingBranch;
  String? vendorInvoiceNo;
  String? receiptDate;
  String? userName;
  String? poNumber;
  String? branchId;
  String? headerId;
  int? start;
  int? limit;

  POReceiptHeaderLookupRequest(
      {this.receiptNumber,
        this.receivingBranch,
        this.vendorInvoiceNo,
        this.receiptDate,
        this.userName,
        this.poNumber,
        this.branchId,
        this.headerId,
      this.start,
      this.limit});

  POReceiptHeaderLookupRequest.fromJson(Map<String, dynamic> json) {
    receiptNumber = json['receiptNumber'];
    receivingBranch = json['receivingBranch'];
    vendorInvoiceNo = json['vendorInvoiceNo'];
    receiptDate = json['receiptDate'];
    userName = json['userName'];
    poNumber = json['poNumber'];
    branchId = json['branchId'];
    headerId = json['headerId'];
    start = json['start'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receiptNumber'] = this.receiptNumber;
    data['receivingBranch'] = this.receivingBranch;
    data['vendorInvoiceNo'] = this.vendorInvoiceNo;
    data['receiptDate'] = this.receiptDate;
    data['userName'] = this.userName;
    data['poNumber'] = this.poNumber;
    data['branchId'] = this.branchId;
    data['headerId'] = this.headerId;
    data['start'] = this.start;
    data['limit'] = this.limit;
    return data;
  }
}
