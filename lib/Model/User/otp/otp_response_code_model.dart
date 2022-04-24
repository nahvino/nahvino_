import 'dart:convert';

OtpResponseModel otpResponseJson(String str) =>
    OtpResponseModel.fromJson(json.decode(str));

class OtpResponseModel {
  OtpResponseModel({
    required this.data,
    required this.statusCode,
    required this.message,
  });
  late final Data? data;
  late final int? statusCode;
  late final String? message;

  OtpResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data!.toJson();
    _data['statusCode'] = statusCode;
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.userName,
    this.nameAlias,
    required this.userToken,
  });
  late final String id;
  late final String userName;
  late final Null nameAlias;
  late final UserToken userToken;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    nameAlias = null;
    userToken = UserToken.fromJson(json['userToken']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userName'] = userName;
    _data['nameAlias'] = nameAlias;
    _data['userToken'] = userToken.toJson();
    return _data;
  }
}

class UserToken {
  UserToken({
    required this.token,
  });
  late final String token;

  UserToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    return _data;
  }
}
