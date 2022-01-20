class VendorLookupResponse {
  List<Vendor>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  VendorLookupResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  VendorLookupResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Vendor>[];
      json['data'].forEach((v) {
        data!.add(new Vendor.fromJson(v));
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

class Vendor {
  int? createdBy;
  String? createDate;
  int? lastUpdatedBy;
  String? lastUpdateDate;
  String? vendorIdGuid;
  int? branchId;
  int? vendorId;
  String? vendorCode;
  String? vendorName;
  int? groupBranchId;
  int? groupId;
  String? activeFlag;
  String? statementType;
  int? recordNumber;
  int? lastUpdateNo;
  String? createdByUser;
  String? lastUpdateByUser;
  String? vendorGroup;
  String? recordIdGuid;

  Vendor(
      {this.createdBy,
        this.createDate,
        this.lastUpdatedBy,
        this.lastUpdateDate,
        this.vendorIdGuid,
        this.branchId,
        this.vendorId,
        this.vendorCode,
        this.vendorName,
        this.groupBranchId,
        this.groupId,
        this.activeFlag,
        this.statementType,
        this.recordNumber,
        this.lastUpdateNo,
        this.createdByUser,
        this.lastUpdateByUser,
        this.vendorGroup,
        this.recordIdGuid});

  Vendor.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    createDate = json['createDate'];
    lastUpdatedBy = json['lastUpdatedBy'];
    lastUpdateDate = json['lastUpdateDate'];
    vendorIdGuid = json['vendorIdGuid'];
    branchId = json['branchId'];
    vendorId = json['vendorId'];
    vendorCode = json['vendorCode'];
    vendorName = json['vendorName'];
    groupBranchId = json['groupBranchId'];
    groupId = json['groupId'];
    activeFlag = json['activeFlag'];
    statementType = json['statementType'];
    recordNumber = json['recordNumber'];
    lastUpdateNo = json['lastUpdateNo'];
    createdByUser = json['createdByUser'];
    lastUpdateByUser = json['lastUpdateByUser'];
    vendorGroup = json['vendorGroup'];
    recordIdGuid = json['recordIdGuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createDate'] = this.createDate;
    data['lastUpdatedBy'] = this.lastUpdatedBy;
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['vendorIdGuid'] = this.vendorIdGuid;
    data['branchId'] = this.branchId;
    data['vendorId'] = this.vendorId;
    data['vendorCode'] = this.vendorCode;
    data['vendorName'] = this.vendorName;
    data['groupBranchId'] = this.groupBranchId;
    data['groupId'] = this.groupId;
    data['activeFlag'] = this.activeFlag;
    data['statementType'] = this.statementType;
    data['recordNumber'] = this.recordNumber;
    data['lastUpdateNo'] = this.lastUpdateNo;
    data['createdByUser'] = this.createdByUser;
    data['lastUpdateByUser'] = this.lastUpdateByUser;
    data['vendorGroup'] = this.vendorGroup;
    data['recordIdGuid'] = this.recordIdGuid;
    return data;
  }
}