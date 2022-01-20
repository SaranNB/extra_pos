class PONumberFilterLookupResponse {
  List<PONumber>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  PONumberFilterLookupResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  PONumberFilterLookupResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PONumber>[];
      json['data'].forEach((v) {
        data!.add(new PONumber.fromJson(v));
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

class PONumber {
  int? recordNumber;
  String? headerIdGuid;
  int? poHeaderBranchId;
  int? poHeaderId;
  String? poNumber;
  String? poDate;
  int? shipToBranchId;
  String? shipToBranch;
  String? isSelected;

  PONumber(
      {this.recordNumber,
        this.headerIdGuid,
        this.poHeaderBranchId,
        this.poHeaderId,
        this.poNumber,
        this.poDate,
        this.shipToBranchId,
        this.shipToBranch,
        this.isSelected});

  PONumber.fromJson(Map<String, dynamic> json) {
    recordNumber = json['recordNumber'];
    headerIdGuid = json['headerIdGuid'];
    poHeaderBranchId = json['poHeaderBranchId'];
    poHeaderId = json['poHeaderId'];
    poNumber = json['poNumber'];
    poDate = json['poDate'];
    shipToBranchId = json['shipToBranchId'];
    shipToBranch = json['shipToBranch'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordNumber'] = this.recordNumber;
    data['headerIdGuid'] = this.headerIdGuid;
    data['poHeaderBranchId'] = this.poHeaderBranchId;
    data['poHeaderId'] = this.poHeaderId;
    data['poNumber'] = this.poNumber;
    data['poDate'] = this.poDate;
    data['shipToBranchId'] = this.shipToBranchId;
    data['shipToBranch'] = this.shipToBranch;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
