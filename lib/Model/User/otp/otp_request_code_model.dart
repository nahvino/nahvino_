class OtpRequestCodeModel {
  OtpRequestCodeModel({
    required this.phoneNumber,
    required this.code,
  });
  late final String? phoneNumber;
  late final int? code;

  OtpRequestCodeModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phoneNumber'] = phoneNumber;
    _data['code'] = code;
    return _data;
  }
}
