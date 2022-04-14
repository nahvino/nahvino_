import 'dart:convert';

AddIntroducedResponseModel addintroducedresponseJson(String str) =>
    AddIntroducedResponseModel.fromJson(json.decode(str));

class AddIntroducedResponseModel {
  AddIntroducedResponseModel({
    required this.statusCode,
    required this.message,
  });
  late final int statusCode;
  late final String message;

  AddIntroducedResponseModel.fromJson(Map<String, dynamic> json){
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['message'] = message;
    return _data;
  }
}