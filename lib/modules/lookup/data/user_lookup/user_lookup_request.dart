import 'dart:convert';

class UserLookupRequest {
  int? start;
  int? limit;
  String? activeFlag;
  String? userName;
  UserLookupRequest({
    this.start,
    this.limit,
    this.activeFlag,
    this.userName,
  });
  

  UserLookupRequest copyWith({
    int? start,
    int? limit,
    String? activeFlag,
    String? userName,
  }) {
    return UserLookupRequest(
      start: start ?? this.start,
      limit: limit ?? this.limit,
      activeFlag: activeFlag ?? this.activeFlag,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'limit': limit,
      'activeFlag': activeFlag,
      'userName': userName,
    };
  }

  factory UserLookupRequest.fromMap(Map<String, dynamic> map) {
    if (map == null);
  
    return UserLookupRequest(
      start: map['start'],
      limit: map['limit'],
      activeFlag: map['activeFlag'],
      userName: map['userName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLookupRequest.fromJson(String source) => UserLookupRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UsersRequest(start: $start, limit: $limit, activeFlag: $activeFlag, userName: $userName)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UserLookupRequest &&
      o.start == start &&
      o.limit == limit &&
      o.activeFlag == activeFlag &&
      o.userName == userName;
  }

  @override
  int get hashCode {
    return start.hashCode ^
      limit.hashCode ^
      activeFlag.hashCode ^
      userName.hashCode;
  }
}
