class ToleranceCodeLookupRequest {
  String? toleranceCode;
  String? description;
  int? start;
  int? limit;

  ToleranceCodeLookupRequest(
      {this.toleranceCode, this.description, this.start, this.limit});

  ToleranceCodeLookupRequest.fromJson(Map<String, dynamic> json) {
    toleranceCode = json['toleranceCode'];
    description = json['description'];
    start = json['start'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toleranceCode'] = this.toleranceCode;
    data['description'] = this.description;
    data['start'] = this.start;
    data['limit'] = this.limit;
    return data;
  }
}
