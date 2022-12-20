import 'Data.dart';

class InfoModel {
  InfoModel({
      this.data, 
      this.statusCode, 
      this.message,});

  InfoModel.fromJson(dynamic json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
    statusCode = json['statusCode'];
    message = json['message'];
  }
  Data? data;
  int? statusCode;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final data = this.data;
    if (data != null) {
      map['data'] = data.toJson();
    }
    map['statusCode'] = statusCode;
    map['message'] = message;
    return map;
  }

}
