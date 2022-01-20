class UpdatePOReceiptHeaderRequest {
  PoReceiptHeader? poReceiptHeader;
  List<PoReceiptLines>? poReceiptLines;

  UpdatePOReceiptHeaderRequest({this.poReceiptHeader, this.poReceiptLines});

  UpdatePOReceiptHeaderRequest.fromJson(Map<String, dynamic> json) {
    poReceiptHeader = json['poReceiptHeader'] != null
        ? new PoReceiptHeader.fromJson(json['poReceiptHeader'])
        : null;
    if (json['poReceiptLines'] != null) {
      poReceiptLines = <PoReceiptLines>[];
      json['poReceiptLines'].forEach((v) {
        poReceiptLines!.add(new PoReceiptLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.poReceiptHeader != null) {
      data['poReceiptHeader'] = this.poReceiptHeader!.toJson();
    }
    if (this.poReceiptLines != null) {
      data['poReceiptLines'] =
          this.poReceiptLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PoReceiptHeader {
  int? branchId;
  int? headerId;
  String? vendorInvoiceNo;
  double? invoiceAmount;
  String? toleranceCode;
  String? attentionName;
  String? attentionPhone;
  String? statementType;
  int? lastUpdateNo;
  String? allowBackorders;
  String? receiptDate;
  String? vendorInvoiceDate;
  String? reqSource;

  PoReceiptHeader(
      {this.branchId,
      this.headerId,
      this.vendorInvoiceNo,
      this.invoiceAmount,
      this.toleranceCode,
      this.attentionName,
      this.attentionPhone,
      this.statementType,
      this.lastUpdateNo,
      this.allowBackorders,
      this.receiptDate,
      this.vendorInvoiceDate,
      this.reqSource});

  PoReceiptHeader.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    headerId = json['headerId'];
    vendorInvoiceNo = json['vendorInvoiceNo'];
    invoiceAmount = json['invoiceAmount'];
    toleranceCode = json['toleranceCode'];
    attentionName = json['attentionName'];
    attentionPhone = json['attentionPhone'];
    statementType = json['statementType'];
    lastUpdateNo = json['lastUpdateNo'];
    allowBackorders = json['allowBackorders'];
    receiptDate = json['receiptDate'];
    vendorInvoiceDate = json['vendorInvoiceDate'];
    reqSource = json['reqSource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['headerId'] = this.headerId;
    data['vendorInvoiceNo'] = this.vendorInvoiceNo;
    data['invoiceAmount'] = this.invoiceAmount;
    data['toleranceCode'] = this.toleranceCode;
    data['attentionName'] = this.attentionName;
    data['attentionPhone'] = this.attentionPhone;
    data['statementType'] = this.statementType;
    data['lastUpdateNo'] = this.lastUpdateNo;
    data['allowBackorders'] = this.allowBackorders;
    data['receiptDate'] = this.receiptDate;
    data['vendorInvoiceDate'] = this.vendorInvoiceDate;
    data['reqSource'] = this.reqSource;
    return data;
  }
}

class PoReceiptLines {
  PoReceiptLines();

  PoReceiptLines.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }
}
