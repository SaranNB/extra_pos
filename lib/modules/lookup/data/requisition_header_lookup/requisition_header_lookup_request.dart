class RequisitionHeaderLookupRequest {
  int? branchId;
  int? headerId;
  int? start;
  int? limit;

  RequisitionHeaderLookupRequest(
      {this.branchId, this.headerId, this.start, this.limit});

  RequisitionHeaderLookupRequest.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    headerId = json['headerId'];
    start = json['start'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['headerId'] = this.headerId;
    data['start'] = this.start;
    data['limit'] = this.limit;
    return data;
  }
}

