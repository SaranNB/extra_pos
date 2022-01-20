class UserInfoResponse {
  String? firstName;
  String? lastName;
  DateTime? lastLogin;
  String? userName;

  UserInfoResponse(
      {this.firstName, this.lastName, this.lastLogin, this.userName});

  UserInfoResponse.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    lastLogin = DateTime.parse(json['lastLogin']);
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['lastLogin'] = this.lastLogin;
    data['userName'] = this.userName;
    return data;
  }
}