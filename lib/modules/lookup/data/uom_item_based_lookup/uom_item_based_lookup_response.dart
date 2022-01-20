class UomItemBasedResponse {
  List<UomItemBased>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  UomItemBasedResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  UomItemBasedResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<UomItemBased>();
      json['data'].forEach((v) {
        data!.add(new UomItemBased.fromJson(v));
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

class UomItemBased {
  int? branchId;
  int? itemUomId;
  int? itemBranchId;
  int? itemId;
  String? itemNumber;
  String? uom;
  double? uomConversion;
  int? uomBranchId;
  int? uomId;
  String? activeFlag;
  String? uomDescription;
  int? lastUpdateNo;

  UomItemBased(
      {this.branchId,
        this.itemUomId,
        this.itemBranchId,
        this.itemId,
        this.itemNumber,
        this.uom,
        this.uomConversion,
        this.uomBranchId,
        this.uomId,
        this.activeFlag,
        this.uomDescription,
        this.lastUpdateNo});

  UomItemBased.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    itemUomId = json['itemUomId'];
    itemBranchId = json['itemBranchId'];
    itemId = json['itemId'];
    itemNumber = json['itemNumber'];
    uom = json['uom'];
    uomConversion = json['uomConversion'];
    uomBranchId = json['uomBranchId'];
    uomId = json['uomId'];
    activeFlag = json['activeFlag'];
    uomDescription = json['uomDescription'];
    lastUpdateNo = json['lastUpdateNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['itemUomId'] = this.itemUomId;
    data['itemBranchId'] = this.itemBranchId;
    data['itemId'] = this.itemId;
    data['itemNumber'] = this.itemNumber;
    data['uom'] = this.uom;
    data['uomConversion'] = this.uomConversion;
    data['uomBranchId'] = this.uomBranchId;
    data['uomId'] = this.uomId;
    data['activeFlag'] = this.activeFlag;
    data['uomDescription'] = this.uomDescription;
    data['lastUpdateNo'] = this.lastUpdateNo;
    return data;
  }
}