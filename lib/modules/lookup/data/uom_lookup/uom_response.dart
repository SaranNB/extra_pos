class UomResponse{
  List<Uom>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  UomResponse(
      {this.data,
      this.totalRecords,
      this.start,
      this.limit,
      this.message,
      this.success});

  UomResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new Uom.fromJson(v));
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

class Uom {
 
  int? branchId;
  int? uomId;
  String? uom;
  String? uomDescription;


  Uom(
      {
      this.branchId,
      this.uomId,
      this.uom,
      this.uomDescription,
      });

  Uom.fromJson(Map<String, dynamic> json) {
    
    branchId = json['branchId'];
    uomId = json['uomId'];
    uom = json['uom'];
    uomDescription = json['uomDescription'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   
    data['branchId'] = this.branchId;
    data['uomId'] = this.uomId;
    data['uom'] = this.uom;
    data['uomDescription'] = this.uomDescription;
    
    return data;
  }
}