class ListRequisitionRequest {
  int? start;
  int? limit;
  String? branchCode;
  String? tempRequisitionNumber;
  String? userName;
  String? requisitionStatus;
  String? branchId;

  ListRequisitionRequest(
      {this.start,
        this.limit,
        this.branchCode,
        this.tempRequisitionNumber,
        this.userName,
        this.requisitionStatus,
        this.branchId});

  ListRequisitionRequest.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    limit = json['limit'];
    branchCode = json['branchCode'];
    tempRequisitionNumber = json['tempRequisitionNumber'];
    userName = json['userName'];
    requisitionStatus = json['requisitionStatus'];
    branchId = json['branchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['limit'] = this.limit;
    data['branchCode'] = this.branchCode;
    data['tempRequisitionNumber'] = this.tempRequisitionNumber;
    data['userName'] = this.userName;
    data['requisitionStatus'] = this.requisitionStatus;
    data['branchId'] = this.branchId;
    return data;
  }
}