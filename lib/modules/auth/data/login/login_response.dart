class LoginResponse {
  int? userIdInt;
  String? token;
  String? refreshToken;

  LoginResponse({this.userIdInt, this.token, this.refreshToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    userIdInt = json['userIdInt'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userIdInt'] = this.userIdInt;
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}