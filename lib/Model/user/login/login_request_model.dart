class LoginRequestModel {
  LoginRequestModel({
    this.userName,
    this.password,
  });
  late final String? userName;
  late final String? password;

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userName'] = userName;
    _data['password'] = password;
    return _data;
  }
}
