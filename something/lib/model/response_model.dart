class ResponseModel {
  dynamic data;
  int? errorCode;
  String? errorMsg;

  ResponseModel({this.data, this.errorCode, this.errorMsg});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      data: json['data'],
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'errorCode': errorCode,
      'errorMsg': errorMsg,
    };
  }
}