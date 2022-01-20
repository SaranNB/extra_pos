class BranchLookupRequest {
  int? start;
  int? limit;
  String? activeFlag;
  String? branchCode;
  String? branchDescription;

  BranchLookupRequest(
      {this.start,
        this.limit,
        this.activeFlag,
        this.branchCode,
        this.branchDescription});

  BranchLookupRequest.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    limit = json['limit'];
    activeFlag = json['activeFlag'];
    branchCode = json['branchCode'];
    branchDescription = json['branchDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['limit'] = this.limit;
    data['activeFlag'] = this.activeFlag;
    data['branchCode'] = this.branchCode;
    data['branchDescription'] = this.branchDescription;
    return data;
  }
}