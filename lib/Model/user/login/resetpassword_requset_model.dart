class ResetPasswordRequestModel {
  ResetPasswordRequestModel({
    required this.id,
    required this.securityQuestion,
    required this.newPassword,
  });
  late final String id;
  late final int securityQuestion;
  late final String newPassword;

  ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    securityQuestion = json['securityQuestion'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['securityQuestion'] = securityQuestion;
    _data['newPassword'] = newPassword;
    return _data;
  }
}
