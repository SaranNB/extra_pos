class CreateRequisitionHeaderRequest {
  TempRequisitionHeader? tempRequisitionHeader;

  CreateRequisitionHeaderRequest({this.tempRequisitionHeader});

  CreateRequisitionHeaderRequest.fromJson(Map<String, dynamic> json) {
    tempRequisitionHeader = json['tempRequisitionHeader'] != null
        ? new TempRequisitionHeader.fromJson(json['tempRequisitionHeader'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tempRequisitionHeader != null) {
      data['tempRequisitionHeader'] = this.tempRequisitionHeader!.toJson();
    }
    return data;
  }
}

class TempRequisitionHeader {
  int? branchCodeId;
  String? reqStatus;
  String? reqSource;
  String? statementType;

  TempRequisitionHeader(
      {this.branchCodeId, this.reqStatus, this.reqSource, this.statementType});

  TempRequisitionHeader.fromJson(Map<String, dynamic> json) {
    branchCodeId = json['branchCodeId'];
    reqStatus = json['reqStatus'];
    reqSource = json['reqSource'];
    statementType = json['statementType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchCodeId'] = this.branchCodeId;
    data['reqStatus'] = this.reqStatus;
    data['reqSource'] = this.reqSource;
    data['statementType'] = this.statementType;
    return data;
  }
}