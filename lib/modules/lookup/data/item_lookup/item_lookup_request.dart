class ItemLookupRequest {
  int? start;
  int? limit;
  String? itemNumber;
  String? itemDescription;
  int? branchCodeId;

  ItemLookupRequest(
      {this.start,
        this.limit,
        this.itemNumber,
        this.itemDescription,
        this.branchCodeId});

  ItemLookupRequest.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    limit = json['limit'];
    itemNumber = json['itemNumber'];
    itemDescription = json['itemDescription'];
    branchCodeId = json['branchCodeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['limit'] = this.limit;
    data['itemNumber'] = this.itemNumber;
    data['itemDescription'] = this.itemDescription;
    data['branchCodeId'] = this.branchCodeId;
    return data;
  }
}