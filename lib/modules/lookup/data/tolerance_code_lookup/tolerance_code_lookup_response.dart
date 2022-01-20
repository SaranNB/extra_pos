class ToleranceCodeLookupResponse {
  List<ToleranceCode>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  ToleranceCodeLookupResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  ToleranceCodeLookupResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ToleranceCode>[];
      json['data'].forEach((v) {
        data!.add(new ToleranceCode.fromJson(v));
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

class ToleranceCode {
  int? createdBy;
  String? createDate;
  int? lastUpdatedBy;
  String? lastUpdateDate;
  String? toleranceIdGuid;
  int? branchId;
  int? toleranceId;
  String? toleranceCode;
  String? description;
  String? toleranceAction;
  String? activeFlag;
  double? purQtyPctLow;
  double? purQtyPctUp;
  int? recordNumber;
  String? recordIdGuid;
  int? lastUpdateNo;
  String? createdByUser;
  String? lastUpdateByUser;

  ToleranceCode(
      {this.createdBy,
        this.createDate,
        this.lastUpdatedBy,
        this.lastUpdateDate,
        this.toleranceIdGuid,
        this.branchId,
        this.toleranceId,
        this.toleranceCode,
        this.description,
        this.toleranceAction,
        this.activeFlag,
        this.purQtyPctLow,
        this.purQtyPctUp,
        this.recordNumber,
        this.recordIdGuid,
        this.lastUpdateNo,
        this.createdByUser,
        this.lastUpdateByUser});

  ToleranceCode.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    createDate = json['createDate'];
    lastUpdatedBy = json['lastUpdatedBy'];
    lastUpdateDate = json['lastUpdateDate'];
    toleranceIdGuid = json['toleranceIdGuid'];
    branchId = json['branchId'];
    toleranceId = json['toleranceId'];
    toleranceCode = json['toleranceCode'];
    description = json['description'];
    toleranceAction = json['toleranceAction'];
    activeFlag = json['activeFlag'];
    purQtyPctLow = json['purQtyPctLow'];
    purQtyPctUp = json['purQtyPctUp'];
    recordNumber = json['recordNumber'];
    recordIdGuid = json['recordIdGuid'];
    lastUpdateNo = json['lastUpdateNo'];
    createdByUser = json['createdByUser'];
    lastUpdateByUser = json['lastUpdateByUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createDate'] = this.createDate;
    data['lastUpdatedBy'] = this.lastUpdatedBy;
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['toleranceIdGuid'] = this.toleranceIdGuid;
    data['branchId'] = this.branchId;
    data['toleranceId'] = this.toleranceId;
    data['toleranceCode'] = this.toleranceCode;
    data['description'] = this.description;
    data['toleranceAction'] = this.toleranceAction;
    data['activeFlag'] = this.activeFlag;
    data['purQtyPctLow'] = this.purQtyPctLow;
    data['purQtyPctUp'] = this.purQtyPctUp;
    data['recordNumber'] = this.recordNumber;
    data['recordIdGuid'] = this.recordIdGuid;
    data['lastUpdateNo'] = this.lastUpdateNo;
    data['createdByUser'] = this.createdByUser;
    data['lastUpdateByUser'] = this.lastUpdateByUser;
    return data;
  }
}
