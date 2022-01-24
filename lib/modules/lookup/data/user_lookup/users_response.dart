class UsersResponse {
  List<User>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  UsersResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  UsersResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new User.fromJson(v));
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

class User {
  int? userId;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  int? lastUpdateNo;
  int? recordId;

  User(
      {this.userId,
        this.userName,
        this.firstName,
        this.lastName,
        this.email,
        this.lastUpdateNo,
        this.recordId});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    lastUpdateNo = json['lastUpdateNo'];
    recordId = json['recordId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['lastUpdateNo'] = this.lastUpdateNo;
    data['recordId'] = this.recordId;
    return data;
  }
}