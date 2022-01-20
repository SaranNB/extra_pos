class VendorBranchLookupResponse {
  List<VendorBranch>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  VendorBranchLookupResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  VendorBranchLookupResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <VendorBranch>[];
      json['data'].forEach((v) {
        data!.add(new VendorBranch.fromJson(v));
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

class VendorBranch {
  int? createdBy;
  String? createDate;
  int? lastUpdatedBy;
  String? lastUpdateDate;
  String? vendorSiteIdGuid;
  int? branchId;
  int? vendorSiteId;
  int? vendorBranchId;
  int? vendorId;
  int? toleranceBranchId;
  int? toleranceCodeId;
  String? vendorSiteCode;
  String? vendorSiteName;
  String? address1;
  String? address2;
  String? address3;
  String? city;
  String? state;
  String? country;
  String? phoneNumber;
  String? emailAddress;
  String? contactName;
  int? taxBranchId;
  int? taxCodeId;
  String? taxCode;
  int? accountCodeId;
  int? accountBranchId;
  String? accountCode;
  String? primaryFlag;
  String? notes;
  String? activeFlag;
  String? branchName;
  String? bankBranch;
  String? accountNumber;
  int? invcTermId;
  int? invcTermBrId;
  int? dbtmemoTermId;
  int? dbmemoTermBrId;
  String? statementType;
  int? recordNumber;
  int? lastUpdateNo;
  String? createdByUser;
  String? lastUpdateByUser;
  String? recordIdGuid;
  String? toleranceCode;
  String? invcPymtTermCode;
  String? dbmemoPymtTermCode;

  VendorBranch(
      {this.createdBy,
        this.createDate,
        this.lastUpdatedBy,
        this.lastUpdateDate,
        this.vendorSiteIdGuid,
        this.branchId,
        this.vendorSiteId,
        this.vendorBranchId,
        this.vendorId,
        this.toleranceBranchId,
        this.toleranceCodeId,
        this.vendorSiteCode,
        this.vendorSiteName,
        this.address1,
        this.address2,
        this.address3,
        this.city,
        this.state,
        this.country,
        this.phoneNumber,
        this.emailAddress,
        this.contactName,
        this.taxBranchId,
        this.taxCodeId,
        this.taxCode,
        this.accountCodeId,
        this.accountBranchId,
        this.accountCode,
        this.primaryFlag,
        this.notes,
        this.activeFlag,
        this.branchName,
        this.bankBranch,
        this.accountNumber,
        this.invcTermId,
        this.invcTermBrId,
        this.dbtmemoTermId,
        this.dbmemoTermBrId,
        this.statementType,
        this.recordNumber,
        this.lastUpdateNo,
        this.createdByUser,
        this.lastUpdateByUser,
        this.recordIdGuid,
        this.toleranceCode,
        this.invcPymtTermCode,
        this.dbmemoPymtTermCode});

  VendorBranch.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    createDate = json['createDate'];
    lastUpdatedBy = json['lastUpdatedBy'];
    lastUpdateDate = json['lastUpdateDate'];
    vendorSiteIdGuid = json['vendorSiteIdGuid'];
    branchId = json['branchId'];
    vendorSiteId = json['vendorSiteId'];
    vendorBranchId = json['vendorBranchId'];
    vendorId = json['vendorId'];
    toleranceBranchId = json['toleranceBranchId'];
    toleranceCodeId = json['toleranceCodeId'];
    vendorSiteCode = json['vendorSiteCode'];
    vendorSiteName = json['vendorSiteName'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    phoneNumber = json['phoneNumber'];
    emailAddress = json['emailAddress'];
    contactName = json['contactName'];
    taxBranchId = json['taxBranchId'];
    taxCodeId = json['taxCodeId'];
    taxCode = json['taxCode'];
    accountCodeId = json['accountCodeId'];
    accountBranchId = json['accountBranchId'];
    accountCode = json['accountCode'];
    primaryFlag = json['primaryFlag'];
    notes = json['notes'];
    activeFlag = json['activeFlag'];
    branchName = json['branchName'];
    bankBranch = json['bankBranch'];
    accountNumber = json['accountNumber'];
    invcTermId = json['invcTermId'];
    invcTermBrId = json['invcTermBrId'];
    dbtmemoTermId = json['dbtmemoTermId'];
    dbmemoTermBrId = json['dbmemoTermBrId'];
    statementType = json['statementType'];
    recordNumber = json['recordNumber'];
    lastUpdateNo = json['lastUpdateNo'];
    createdByUser = json['createdByUser'];
    lastUpdateByUser = json['lastUpdateByUser'];
    recordIdGuid = json['recordIdGuid'];
    toleranceCode = json['toleranceCode'];
    invcPymtTermCode = json['invcPymtTermCode'];
    dbmemoPymtTermCode = json['dbmemoPymtTermCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createDate'] = this.createDate;
    data['lastUpdatedBy'] = this.lastUpdatedBy;
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['vendorSiteIdGuid'] = this.vendorSiteIdGuid;
    data['branchId'] = this.branchId;
    data['vendorSiteId'] = this.vendorSiteId;
    data['vendorBranchId'] = this.vendorBranchId;
    data['vendorId'] = this.vendorId;
    data['toleranceBranchId'] = this.toleranceBranchId;
    data['toleranceCodeId'] = this.toleranceCodeId;
    data['vendorSiteCode'] = this.vendorSiteCode;
    data['vendorSiteName'] = this.vendorSiteName;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['phoneNumber'] = this.phoneNumber;
    data['emailAddress'] = this.emailAddress;
    data['contactName'] = this.contactName;
    data['taxBranchId'] = this.taxBranchId;
    data['taxCodeId'] = this.taxCodeId;
    data['taxCode'] = this.taxCode;
    data['accountCodeId'] = this.accountCodeId;
    data['accountBranchId'] = this.accountBranchId;
    data['accountCode'] = this.accountCode;
    data['primaryFlag'] = this.primaryFlag;
    data['notes'] = this.notes;
    data['activeFlag'] = this.activeFlag;
    data['branchName'] = this.branchName;
    data['bankBranch'] = this.bankBranch;
    data['accountNumber'] = this.accountNumber;
    data['invcTermId'] = this.invcTermId;
    data['invcTermBrId'] = this.invcTermBrId;
    data['dbtmemoTermId'] = this.dbtmemoTermId;
    data['dbmemoTermBrId'] = this.dbmemoTermBrId;
    data['statementType'] = this.statementType;
    data['recordNumber'] = this.recordNumber;
    data['lastUpdateNo'] = this.lastUpdateNo;
    data['createdByUser'] = this.createdByUser;
    data['lastUpdateByUser'] = this.lastUpdateByUser;
    data['recordIdGuid'] = this.recordIdGuid;
    data['toleranceCode'] = this.toleranceCode;
    data['invcPymtTermCode'] = this.invcPymtTermCode;
    data['dbmemoPymtTermCode'] = this.dbmemoPymtTermCode;
    return data;
  }
}