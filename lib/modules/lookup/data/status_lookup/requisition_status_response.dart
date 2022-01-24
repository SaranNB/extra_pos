class RequisitionStatusListResponse {
  List<RequisitionStatus>? data;
  bool? success;
  String? message;

  RequisitionStatusListResponse({this.data, this.success, this.message});

  RequisitionStatusListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new RequisitionStatus.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class RequisitionStatus {
  String? lookUpValue;
  String? meaning;

  RequisitionStatus({this.lookUpValue, this.meaning});

  RequisitionStatus.fromJson(Map<String, dynamic> json) {
    lookUpValue = json['lookUpValue'];
    meaning = json['meaning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lookUpValue'] = this.lookUpValue;
    data['meaning'] = this.meaning;
    return data;
  }
}