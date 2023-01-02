class GetUserAbandonModel {
  GetUserAbandonModel({
    this.data,
    this.statusCode,
    this.message,});

  GetUserAbandonModel.fromJson(dynamic json) {
    data = json['data'];
    statusCode = json['statusCode'];
    message = json['message'];
  }
  String? data;
  int? statusCode;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['statusCode'] = statusCode;
    map['message'] = message;
    return map;
  }

}