class PONumberLookupRequest {
  int? shipToBranchId;
  int? vendorBranchId;
  int? vendorId;
  int? vendorSiteBranchId;
  int? vendorSiteId;
  String? poNumber;
  String? allowBackOrders;
  int? start;
  int? limit;

  PONumberLookupRequest(
      {this.shipToBranchId,
        this.vendorBranchId,
        this.vendorId,
        this.vendorSiteBranchId,
        this.vendorSiteId,
        this.poNumber,
        this.allowBackOrders,
        this.start,
        this.limit});

  PONumberLookupRequest.fromJson(Map<String, dynamic> json) {
    shipToBranchId = json['shipToBranchId'];
    vendorBranchId = json['vendorBranchId'];
    vendorId = json['vendorId'];
    vendorSiteBranchId = json['vendorSiteBranchId'];
    vendorSiteId = json['vendorSiteId'];
    poNumber = json['poNumber'];
    allowBackOrders = json['allowBackOrders'];
    start = json['start'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipToBranchId'] = this.shipToBranchId;
    data['vendorBranchId'] = this.vendorBranchId;
    data['vendorId'] = this.vendorId;
    data['vendorSiteBranchId'] = this.vendorSiteBranchId;
    data['vendorSiteId'] = this.vendorSiteId;
    data['poNumber'] = this.poNumber;
    data['allowBackOrders'] = this.allowBackOrders;
    data['start'] = this.start;
    data['limit'] = this.limit;
    return data;
  }
}
