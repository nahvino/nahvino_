import 'dart:convert';

EditProfileUserResponseModel editprofileuserresponseJson(String str) =>
    EditProfileUserResponseModel.fromJson(json.decode(str));

class EditProfileUserResponseModel {
  EditProfileUserResponseModel({
    required this.statusCode,
    required this.message,
  });
  late final int statusCode;
  late final String message;

  EditProfileUserResponseModel.fromJson(Map<String, dynamic> json){
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