class UomItemBasedLookupRequest {
  int? start;
  int? limit;
  String? activeFlag;
  String? endDate;
  int? itemBranchId;
  int? itemId;
  String? uom;

  UomItemBasedLookupRequest(
      {this.start,
        this.limit,
        this.activeFlag,
        this.endDate,
        this.itemBranchId,
        this.itemId,
        this.uom});

  UomItemBasedLookupRequest.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    limit = json['limit'];
    activeFlag = json['activeFlag'];
    endDate = json['endDate'];
    itemBranchId = json['itemBranchId'];
    itemId = json['itemId'];
    uom = json['uom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['limit'] = this.limit;
    data['activeFlag'] = this.activeFlag;
    data['endDate'] = this.endDate;
    data['itemBranchId'] = this.itemBranchId;
    data['itemId'] = this.itemId;
    data['uom'] = this.uom;
    return data;
  }
}