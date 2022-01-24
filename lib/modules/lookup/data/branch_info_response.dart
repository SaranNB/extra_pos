class BranchInfoResponse {
  List<BranchInfo>? data;
  bool? success;
  String? message;

  BranchInfoResponse({this.data, this.success, this.message});

  BranchInfoResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new BranchInfo.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class BranchInfo {
  String? branchCode;
  int? branchId;
  String? branchDescription;

  BranchInfo({this.branchCode, this.branchId, this.branchDescription});

  BranchInfo.fromJson(Map<String, dynamic> json) {
    branchCode = json['branchCode'];
    branchId = json['branchId'];
    branchDescription = json['branchDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchCode'] = this.branchCode;
    data['branchId'] = this.branchId;
    data['branchDescription'] = this.branchDescription;
    return data;
  }
}