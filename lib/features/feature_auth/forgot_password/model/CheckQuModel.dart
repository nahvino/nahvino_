class CheckQuModel {
  CheckQuModel({
      this.data, 
      this.statusCode, 
      this.message,});

  CheckQuModel.fromJson(dynamic json) {
    data = json['data'];
    statusCode = json['statusCode'];
    message = json['message'];
  }
  String? data;
  int? statusCode;
  dynamic? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['statusCode'] = statusCode;
    map['message'] = message;
    return map;
  }

}