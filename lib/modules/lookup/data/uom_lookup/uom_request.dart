import 'dart:convert';

class UomRequest {
  int? start;
  int? limit;
  
  UomRequest({
    this.start,
    this.limit,
  });

  UomRequest copyWith({
    int? start,
    int? limit,
  }) {
    return UomRequest(
      start: start ?? this.start,
      limit: limit ?? this.limit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'limit': limit,
    };
  }

  factory UomRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) ;
  
    return UomRequest(
      start: map['start'],
      limit: map['limit'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UomRequest.fromJson(String source) => UomRequest.fromMap(json.decode(source));

  @override
  String toString() => 'UomRequest(start: $start, limit: $limit)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UomRequest &&
      o.start == start &&
      o.limit == limit;
  }

  @override
  int get hashCode => start.hashCode ^ limit.hashCode;
}
