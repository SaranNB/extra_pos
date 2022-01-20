class VendorLookupRequest {
  String? vendorCode;
  String? vendorName;
  int? start;
  int? limit;
  String? activeFlag;

  VendorLookupRequest(
      {this.vendorCode,
        this.vendorName,
        this.start,
        this.limit,
        this.activeFlag});

  VendorLookupRequest.fromJson(Map<String, dynamic> json) {
    vendorCode = json['vendorCode'];
    vendorName = json['vendorName'];
    start = json['start'];
    limit = json['limit'];
    activeFlag = json['activeFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendorCode'] = this.vendorCode;
    data['vendorName'] = this.vendorName;
    data['start'] = this.start;
    data['limit'] = this.limit;
    data['activeFlag'] = this.activeFlag;
    return data;
  }
}