class RegisterRequestModel {
  RegisterRequestModel({
    required this.userName,
    required this.password,
    required this.securityQuestion,
    required this.sqAnswer,
  });
  late final String? userName;
  late final String? password;
  late final int securityQuestion;
  late final String? sqAnswer;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    securityQuestion = json['securityQuestion'] as int;
    sqAnswer = json['sqAnswer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userName'] = userName;
    _data['password'] = password;
    _data['securityQuestion'] = securityQuestion;
    _data['sqAnswer'] = sqAnswer;
    return _data;
  }
}
