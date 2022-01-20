class PONumberFilterLookupRequest {
  String? poNumber;
  int? start;
  int? limit;

  PONumberFilterLookupRequest(
      {
        this.poNumber,
        this.start,
        this.limit});

  PONumberFilterLookupRequest.fromJson(Map<String, dynamic> json) {
    poNumber = json['poNumber'];
    start = json['start'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poNumber'] = this.poNumber;
    data['start'] = this.start;
    data['limit'] = this.limit;
    return data;
  }
}
