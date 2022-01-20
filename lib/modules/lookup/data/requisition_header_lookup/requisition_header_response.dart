class RequisitionHeaderResponse {
  List<RequisitionHeader>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  RequisitionHeaderResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  RequisitionHeaderResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RequisitionHeader>[];
      json['data'].forEach((v) {
        data!.add(new RequisitionHeader.fromJson(v));
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

class RequisitionHeader {
  int? branchId;
  int? headerId;
  int? branchCodeId;
  int? userId;
  String? trn;
  String? reqStatus;
  int? lastUpdateNo;
  String? branchCode;
  String? userName;

  RequisitionHeader(
      {this.branchId,
        this.headerId,
        this.branchCodeId,
        this.userId,
        this.trn,
        this.reqStatus,
        this.lastUpdateNo,
        this.branchCode,
      this.userName});

  RequisitionHeader.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    headerId = json['headerId'];
    branchCodeId = json['branchCodeId'];
    userId = json['userId'];
    trn = json['trn'];
    reqStatus = json['reqStatus'];
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
    data['lastUpdateNo'] = this.lastUpdateNo;
    data['branchCode'] = this.branchCode;
    data['userName'] = this.userName;
    return data;
  }
}