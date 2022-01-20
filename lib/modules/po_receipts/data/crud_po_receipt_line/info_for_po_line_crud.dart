class InfoForPOReceiptLineCrud {
  PoReceiptHeaderInfo? poReceiptHeaderInfo;
  PoReceiptLineInfo? poReceiptLineInfo;

  InfoForPOReceiptLineCrud({this.poReceiptHeaderInfo, this.poReceiptLineInfo});

  InfoForPOReceiptLineCrud.fromJson(Map<String, dynamic> json) {
    poReceiptHeaderInfo = json['poReceiptHeaderInfo'] != null
        ? new PoReceiptHeaderInfo.fromJson(json['poReceiptHeaderInfo'])
        : null;
    poReceiptLineInfo = json['poReceiptLineInfo'] != null
        ? new PoReceiptLineInfo.fromJson(json['poReceiptLineInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.poReceiptHeaderInfo != null) {
      data['poReceiptHeaderInfo'] = this.poReceiptHeaderInfo!.toJson();
    }
    if (this.poReceiptLineInfo != null) {
      data['poReceiptLineInfo'] = this.poReceiptLineInfo!.toJson();
    }
    return data;
  }
}

class PoReceiptHeaderInfo {
  int? headerId;
  String? receiptNumber;
  String? poNumber;
  int? branchId;
  String? branchName;
  String? userName;
  String? vendorInvoiceNumber;
  String? receiptDate;

  PoReceiptHeaderInfo(
      {this.headerId,
      this.receiptNumber,
      this.poNumber,
      this.branchId,
      this.branchName,
      this.userName,
      this.vendorInvoiceNumber,
      this.receiptDate});

  PoReceiptHeaderInfo.fromJson(Map<String, dynamic> json) {
    headerId = json['headerId'];
    receiptNumber = json['receiptNumber'];
    poNumber = json['poNumber'];
    branchId = json['branchId'];
    branchName = json['branchName'];
    userName = json['userName'];
    vendorInvoiceNumber = json['vendorInvoiceNumber'];
    receiptDate = json['receiptDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headerId'] = this.headerId;
    data['receiptNumber'] = this.receiptNumber;
    data['poNumber'] = this.poNumber;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    data['userName'] = this.userName;
    data['vendorInvoiceNumber'] = this.vendorInvoiceNumber;
    data['receiptDate'] = this.receiptDate;
    return data;
  }
}

class PoReceiptLineInfo {
  int? branchId;
  int? headerBranchId;
  int? headerId;
  String? itemNumber;
  int? lineId;
  int? limit;
  int? start;

  PoReceiptLineInfo({this.branchId,
    this.headerBranchId,
    this.headerId,
    this.itemNumber,
    this.lineId,
    this.limit,
    this.start});

  PoReceiptLineInfo.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    headerBranchId = json['headerBranchId'];
    headerId = json['headerId'];
    itemNumber = json['itemNumber'];
    lineId = json['lineId'];
    limit = json['limit'];
    start = json['start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['headerBranchId'] = this.headerBranchId;
    data['headerId'] = this.headerId;
    data['itemNumber'] = this.itemNumber;
    data['lineId'] = this.lineId;
    data['limit'] = this.limit;
    data['start'] = this.start;
    return data;
  }
}
