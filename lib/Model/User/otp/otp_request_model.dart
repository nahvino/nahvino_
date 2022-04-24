class OtpRequestModel {
  OtpRequestModel({
    required this.phoneNumber,
  });
  late final String phoneNumber;

  OtpRequestModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phoneNumber'] = phoneNumber;
    return _data;
  }
}
