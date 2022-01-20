class ListRequisitionResponse {
  List<Requisition>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  ListRequisitionResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  ListRequisitionResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Requisition>[];
      json['data'].forEach((v) {
        data!.add(new Requisition.fromJson(v));
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

class Requisition {
  int? branchId;
  int? headerId;
  int? branchCodeId;
  int? userId;
  String? trn;
  String? reqStatus;
  String? reqNumber;
  String? reqSource;
  int? templateBranchId;
  int? templateId;
  String? notes;
  Null? statementType;
  int? recordNumber;
  int? lastUpdateNo;
  String? branchCode;
  String? userName;
  bool? isExpanded;

  Requisition(
      {
        this.branchId,
        this.headerId,
        this.branchCodeId,
        this.userId,
        this.trn,
        this.reqStatus,
        this.reqNumber,
        this.reqSource,
        this.templateBranchId,
        this.templateId,
        this.notes,
        this.statementType,
        this.recordNumber,
        this.lastUpdateNo,
        this.branchCode,
        this.userName,
        this.isExpanded});

  Requisition.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    headerId = json['headerId'];
    branchCodeId = json['branchCodeId'];
    userId = json['userId'];
    trn = json['trn'];
    reqStatus = json['reqStatus'];
    reqNumber = json['reqNumber'];
    reqSource = json['reqSource'];
    templateBranchId = json['templateBranchId'];
    templateId = json['templateId'];
    notes = json['notes'];
    statementType = json['statementType'];
    recordNumber = json['recordNumber'];
    lastUpdateNo = json['lastUpdateNo'];
    branchCode = json['branchCode'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['headerId'] = this.headerId;
    data['branchCodeId'] = this.branchCodeId;
    data['userId'] = this.userId;
    data['trn'] = this.trn;
    data['reqStatus'] = this.reqStatus;
    data['reqNumber'] = this.reqNumber;
    data['reqSource'] = this.reqSource;
    data['templateBranchId'] = this.templateBranchId;
    data['templateId'] = this.templateId;
    data['notes'] = this.notes;
    data['statementType'] = this.statementType;
    data['recordNumber'] = this.recordNumber;
    data['lastUpdateNo'] = this.lastUpdateNo;
    data['branchCode'] = this.branchCode;
    data['userName'] = this.userName;
    return data;
  }
}