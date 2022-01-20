class POReceiptHeaderLookupResponse {
  List<POReceiptHeader>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  POReceiptHeaderLookupResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  POReceiptHeaderLookupResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <POReceiptHeader>[];
      json['data'].forEach((v) {
        data!.add(new POReceiptHeader.fromJson(v));
      });
    }
    totalRecords = json['totalRecords'];
    start = json['start'];
    limit = json['limit'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalRecords'] = this.totalRecords;
    data['start'] = this.start;
    data['limit'] = this.limit;
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class POReceiptHeader {
  int? createdBy;
  String? createDate;
  int? lastUpdatedBy;
  String? lastUpdateDate;
  String? headerIdGuid;
  int? branchId;
  int? headerId;
  String? receiptNumber;
  String? receiptDate;
  String? vendorInvoiceDate;
  int? receivingBranchId;
  String? receiptStatus;
  String? allowBackorders;
  int? vendorBranchId;
  int? vendorId;
  int? vendorSiteBranchId;
  int? vendorSiteId;
  String? vendorInvoiceNo;
  double? invoiceAmount;
  String? toleranceCode;
  int? toleranceBranchId;
  int? toleranceId;
  String? reqSource;
  int? poHeaderBranchId;
  int? poHeaderId;
  String? poNumber;
  String? recordIdGuid;
  int? recordNumber;
  String? createdByUser;
  String? lastUpdateByUser;
  int? lastUpdateNo;
  String? receivingBranch;
  String? branchAddress;
  String? vendorCode;
  String? vendorName;
  String? vendorSiteCode;
  String? vendorSiteName;
  String? vendorAdress;
  String? attentionName;
  String? attentionPhone;


  POReceiptHeader(
      {this.createdBy,
        this.createDate,
        this.lastUpdatedBy,
        this.lastUpdateDate,
        this.headerIdGuid,
        this.branchId,
        this.headerId,
        this.receiptNumber,
        this.receiptDate,
        this.vendorInvoiceDate,
        this.receivingBranchId,
        this.receiptStatus,
        this.allowBackorders,
        this.vendorBranchId,
        this.vendorId,
        this.vendorSiteBranchId,
        this.vendorSiteId,
        this.vendorInvoiceNo,
        this.invoiceAmount,
        this.toleranceCode,
        this.toleranceBranchId,
        this.toleranceId,
        this.reqSource,
        this.poHeaderBranchId,
        this.poHeaderId,
        this.poNumber,
        this.recordIdGuid,
        this.recordNumber,
        this.createdByUser,
        this.lastUpdateByUser,
        this.lastUpdateNo,
        this.receivingBranch,
        this.branchAddress,
        this.vendorCode,
        this.vendorName,
        this.vendorSiteCode,
        this.vendorSiteName,
        this.vendorAdress,
        this.attentionName,
        this.attentionPhone});

  POReceiptHeader.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    createDate = json['createDate'];
    lastUpdatedBy = json['lastUpdatedBy'];
    lastUpdateDate = json['lastUpdateDate'];
    headerIdGuid = json['headerIdGuid'];
    branchId = json['branchId'];
    headerId = json['headerId'];
    receiptNumber = json['receiptNumber'];
    receiptDate = json['receiptDate'];
    vendorInvoiceDate = json['vendorInvoiceDate'];
    receivingBranchId = json['receivingBranchId'];
    receiptStatus = json['receiptStatus'];
    allowBackorders = json['allowBackorders'];
    vendorBranchId = json['vendorBranchId'];
    vendorId = json['vendorId'];
    vendorSiteBranchId = json['vendorSiteBranchId'];
    vendorSiteId = json['vendorSiteId'];
    vendorInvoiceNo = json['vendorInvoiceNo'];
    invoiceAmount = json['invoiceAmount'];
    toleranceCode = json['toleranceCode'];
    toleranceBranchId = json['toleranceBranchId'];
    toleranceId = json['toleranceId'];
    reqSource = json['reqSource'];
    poHeaderBranchId = json['poHeaderBranchId'];
    poHeaderId = json['poHeaderId'];
    poNumber = json['poNumber'];
    recordIdGuid = json['recordIdGuid'];
    recordNumber = json['recordNumber'];
    createdByUser = json['createdByUser'];
    lastUpdateByUser = json['lastUpdateByUser'];
    lastUpdateNo = json['lastUpdateNo'];
    receivingBranch = json['receivingBranch'];
    branchAddress = json['branchAddress'];
    vendorCode = json['vendorCode'];
    vendorName = json['vendorName'];
    vendorSiteCode = json['vendorSiteCode'];
    vendorSiteName = json['vendorSiteName'];
    vendorAdress = json['vendorAdress'];
    attentionName = json['attentionName'];
    attentionPhone = json['attentionPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createDate'] = this.createDate;
    data['lastUpdatedBy'] = this.lastUpdatedBy;
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['headerIdGuid'] = this.headerIdGuid;
    data['branchId'] = this.branchId;
    data['headerId'] = this.headerId;
    data['receiptNumber'] = this.receiptNumber;
    data['vendorInvoiceDate'] = this.vendorInvoiceDate;
    data['receiptDate'] = this.receiptDate;
    data['receivingBranchId'] = this.receivingBranchId;
    data['receiptStatus'] = this.receiptStatus;
    data['allowBackorders'] = this.allowBackorders;
    data['vendorBranchId'] = this.vendorBranchId;
    data['vendorId'] = this.vendorId;
    data['vendorSiteBranchId'] = this.vendorSiteBranchId;
    data['vendorSiteId'] = this.vendorSiteId;
    data['vendorInvoiceNo'] = this.vendorInvoiceNo;
    data['invoiceAmount'] = this.invoiceAmount;
    data['toleranceCode'] = this.toleranceCode;
    data['toleranceBranchId'] = this.toleranceBranchId;
    data['toleranceId'] = this.toleranceId;
    data['reqSource'] = this.reqSource;
    data['poHeaderBranchId'] = this.poHeaderBranchId;
    data['poHeaderId'] = this.poHeaderId;
    data['poNumber'] = this.poNumber;
    data['recordIdGuid'] = this.recordIdGuid;
    data['recordNumber'] = this.recordNumber;
    data['createdByUser'] = this.createdByUser;
    data['lastUpdateByUser'] = this.lastUpdateByUser;
    data['lastUpdateNo'] = this.lastUpdateNo;
    data['receivingBranch'] = this.receivingBranch;
    data['branchAddress'] = this.branchAddress;
    data['vendorCode'] = this.vendorCode;
    data['vendorName'] = this.vendorName;
    data['vendorSiteCode'] = this.vendorSiteCode;
    data['vendorSiteName'] = this.vendorSiteName;
    data['vendorAdress'] = this.vendorAdress;
    data['attentionName'] = this.attentionName;
    data['attentionPhone'] = this.attentionPhone;
    return data;
  }
}
