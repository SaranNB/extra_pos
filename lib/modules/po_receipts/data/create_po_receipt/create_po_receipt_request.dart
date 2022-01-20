class CreatePOReceiptRequest {
  PoReceiptHeader? poReceiptHeader;
  List<PoReceiptLines>? poReceiptLines;

  CreatePOReceiptRequest({this.poReceiptHeader, this.poReceiptLines});

  CreatePOReceiptRequest.fromJson(Map<String, dynamic> json) {
    poReceiptHeader = json['poReceiptHeader'] != null ? new PoReceiptHeader.fromJson(json['poReceiptHeader']) : null;
    if (json['poReceiptLines'] != null) {
      poReceiptLines = <PoReceiptLines>[];
      json['poReceiptLines'].forEach((v) { poReceiptLines!.add(new PoReceiptLines.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.poReceiptHeader != null) {
      data['poReceiptHeader'] = this.poReceiptHeader!.toJson();
    }
    if (this.poReceiptLines != null) {
      data['poReceiptLines'] = this.poReceiptLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PoReceiptHeader {
  int? receivingBranchId;
  String? receiptStatus;
  String? allowBackorders;
  int? vendorBranchId;
  int? vendorId;
  int? vendorSiteBranchId;
  int? vendorSiteId;
  String? vendorInvoiceNo;
  int? invoiceAmount;
  String? vendorInvoiceDate;
  String? receiptDate;
  int? poHeaderBranchId;
  int? poHeaderId;
  String? poNumber;
  int? toleranceBranchId;
  String? toleranceCode;
  int? toleranceId;
  String? statementType;
  String? reqSource;

  PoReceiptHeader({this.receivingBranchId, this.receiptStatus, this.allowBackorders, this.vendorBranchId, this.vendorId, this.vendorSiteBranchId, this.vendorSiteId, this.vendorInvoiceNo, this.invoiceAmount, this.vendorInvoiceDate, this.receiptDate, this.poHeaderBranchId, this.poHeaderId, this.poNumber, this.toleranceBranchId, this.toleranceCode, this.toleranceId, this.statementType, this.reqSource});
  PoReceiptHeader.fromJson(Map<String, dynamic> json) {
    receivingBranchId = json['receivingBranchId'];
    receiptStatus = json['receiptStatus'];
    allowBackorders = json['allowBackorders'];
    vendorBranchId = json['vendorBranchId'];
    vendorId = json['vendorId'];
    vendorSiteBranchId = json['vendorSiteBranchId'];
    vendorSiteId = json['vendorSiteId'];
    vendorInvoiceNo = json['vendorInvoiceNo'];
    invoiceAmount = json['invoiceAmount'];
    vendorInvoiceDate = json['vendorInvoiceDate'];
    receiptDate = json['receiptDate'];
    poHeaderBranchId = json['poHeaderBranchId'];
    poHeaderId = json['poHeaderId'];
    poNumber = json['poNumber'];
    toleranceBranchId = json['toleranceBranchId'];
    toleranceCode = json['toleranceCode'];
    toleranceId = json['toleranceId'];
    statementType = json['statementType'];
    reqSource = json['reqSource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receivingBranchId'] = this.receivingBranchId;
    data['receiptStatus'] = this.receiptStatus;
    data['allowBackorders'] = this.allowBackorders;
    data['vendorBranchId'] = this.vendorBranchId;
    data['vendorId'] = this.vendorId;
    data['vendorSiteBranchId'] = this.vendorSiteBranchId;
    data['vendorSiteId'] = this.vendorSiteId;
    data['vendorInvoiceNo'] = this.vendorInvoiceNo;
    data['invoiceAmount'] = this.invoiceAmount;
    data['vendorInvoiceDate'] = this.vendorInvoiceDate;
    data['receiptDate'] = this.receiptDate;
    data['poHeaderBranchId'] = this.poHeaderBranchId;
    data['poHeaderId'] = this.poHeaderId;
    data['poNumber'] = this.poNumber;
    data['toleranceBranchId'] = this.toleranceBranchId;
    data['toleranceCode'] = this.toleranceCode;
    data['toleranceId'] = this.toleranceId;
    data['statementType'] = this.statementType;
    data['reqSource'] = this.reqSource;
    return data;
  }
}

class PoReceiptLines {


  PoReceiptLines();

PoReceiptLines.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}
