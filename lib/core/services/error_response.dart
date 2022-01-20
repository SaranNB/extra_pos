class ErrorResponse {
  bool? error;
  String? errorMesage;
  List<ErrorDetails>? errorDetails;

  ErrorResponse({this.error, this.errorMesage, this.errorDetails});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorMesage = json['errorMesage'];
    if (json['errorDetails'] != null) {
      errorDetails = <ErrorDetails>[];
      json['errorDetails'].forEach((v) {
        errorDetails!.add(new ErrorDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['errorMesage'] = this.errorMesage;
    if (this.errorDetails != null) {
      data['errorDetails'] = this.errorDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ErrorDetails {
  String? errorSubject;
  String? errorDescription;

  ErrorDetails({this.errorSubject, this.errorDescription});

  ErrorDetails.fromJson(Map<String, dynamic> json) {
    errorSubject = json['errorSubject'];
    errorDescription = json['errorDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorSubject'] = this.errorSubject;
    data['errorDescription'] = this.errorDescription;
    return data;
  }
}