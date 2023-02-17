class UserSecurtiyMenuModel {
  UserSecurtiyMenuModel({
      this.phoneNumber, 
      this.password,});

  UserSecurtiyMenuModel.fromJson(dynamic json) {
    phoneNumber = json['phoneNumber'];
    password = json['password'];
  }
  bool? phoneNumber;
  bool? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = phoneNumber;
    map['password'] = password;
    return map;
  }

}