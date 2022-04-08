class EditProfileUserRequestModel {
  EditProfileUserRequestModel({
    required this.userId,
    required this.userName,
    required this.nameAlias,
    required this.bio,
    required this.imageFile,
  });
  late final String? userId;
  late final String? userName;
  late final String? nameAlias;
  late final String? bio;
  late final String? imageFile;

  EditProfileUserRequestModel.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    userName = json['userName'];
    nameAlias = json['nameAlias'];
    bio = json['bio'];
    imageFile = json['imageFile'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['userName'] = userName;
    _data['nameAlias'] = nameAlias;
    _data['bio'] = bio;
    _data['imageFile'] = imageFile;
    return _data;
  }
}