class LoginModel {
  LoginModel({
      this.data, 
      this.statusCode, 
      this.message,});

  LoginModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    message = json['message'];
  }
  Data? data;
  int? statusCode;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['statusCode'] = statusCode;
    map['message'] = message;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.userName, 
      this.userToken,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    userName = json['userName'];
    userToken = json['userToken'] != null ? UserToken.fromJson(json['userToken']) : null;
  }
  String? id;
  String? userName;
  UserToken? userToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userName'] = userName;
    if (userToken != null) {
      map['userToken'] = userToken?.toJson();
    }
    return map;
  }

}

class UserToken {
  UserToken({
      this.token,});

  UserToken.fromJson(dynamic json) {
    token = json['token'];
  }
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    return map;
  }

}