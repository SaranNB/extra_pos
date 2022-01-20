class BranchesResponse {
  List<Branch>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  BranchesResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  BranchesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Branch>[];
      json['data'].forEach((v) {
        data!.add(new Branch.fromJson(v));
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

class Branch {
  int? branchId;
  String? branchCode;
  String? branchDescription;
  int? recordNumber;
  String? recordIdGuid;
  int? recordId;

  Branch(
      {this.branchId,
        this.branchCode,
        this.branchDescription,
        this.recordNumber,
        this.recordIdGuid,
        this.recordId});

  Branch.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    branchCode = json['branchCode'];
    branchDescription = json['branchDescription'];
    recordNumber = json['recordNumber'];
    recordIdGuid = json['recordIdGuid'];
    recordId = json['recordId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['branchCode'] = this.branchCode;
    data['branchDescription'] = this.branchDescription;
    data['recordNumber'] = this.recordNumber;
    data['recordIdGuid'] = this.recordIdGuid;
    data['recordId'] = this.recordId;
    return data;
  }
}