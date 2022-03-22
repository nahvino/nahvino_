import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.data,
    required this.statusCode,
    required this.message,
  });
  late final Data data;
  late final int statusCode;
  late final String message;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
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

  get token => null;

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
