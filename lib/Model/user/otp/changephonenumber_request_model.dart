class ChangePhoneNumberRequestModel {
  ChangePhoneNumberRequestModel({
    required this.userId,
    required this.currentPhoneNumber,
    required this.newPhoneNumber,
  });
  late final String userId;
  late final String currentPhoneNumber;
  late final String newPhoneNumber;

  ChangePhoneNumberRequestModel.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    currentPhoneNumber = json['currentPhoneNumber'];
    newPhoneNumber = json['newPhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['currentPhoneNumber'] = currentPhoneNumber;
    _data['newPhoneNumber'] = newPhoneNumber;
    return _data;
  }
}