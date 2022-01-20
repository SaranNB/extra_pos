class VendorBranchLookupRequest {
  int? vendorBranchId;
  int? vendorId;
  String? vendorSiteCode;
  String? vendorSiteName;
  String? activeFlag;
  int? start;
  int? limit;

  VendorBranchLookupRequest(
      {this.vendorBranchId,
        this.vendorId,
        this.vendorSiteCode,
        this.vendorSiteName,
        this.activeFlag,
        this.start,
        this.limit});

  VendorBranchLookupRequest.fromJson(Map<String, dynamic> json) {
    vendorBranchId = json['vendorBranchId'];
    vendorId = json['vendorId'];
    vendorSiteCode = json['vendorSiteCode'];
    vendorSiteName = json['vendorSiteName'];
    activeFlag = json['activeFlag'];
    start = json['start'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendorBranchId'] = this.vendorBranchId;
    data['vendorId'] = this.vendorId;
    data['vendorSiteCode'] = this.vendorSiteCode;
    data['vendorSiteName'] = this.vendorSiteName;
    data['activeFlag'] = this.activeFlag;
    data['start'] = this.start;
    data['limit'] = this.limit;
    return data;
  }
}