import 'dart:convert';

GetProfileUserResponseModel getprofileuserresponseJson(String str) =>
    GetProfileUserResponseModel.fromJson(json.decode(str));
class GetProfileUserResponseModel {
  GetProfileUserResponseModel({
    required this.userName,
    required this.nameAlias,
    required this.bio,
    required this.rank,
    required this.score,
    this.imageUrl,
    required this.identifierCode,
    this.parentName,
    this.parentImageUrl,
  });
  late final String userName;
  late final String nameAlias;
  late final String bio;
  late final int rank;
  late final int score;
  late final Null imageUrl;
  late final int identifierCode;
  late final Null parentName;
  late final Null parentImageUrl;

  GetProfileUserResponseModel.fromJson(Map<String, dynamic> json){
    userName = json['userName'];
    nameAlias = json['nameAlias'];
    bio = json['bio'];
    rank = json['rank'];
    score = json['score'];
    imageUrl = null;
    identifierCode = json['identifierCode'];
    parentName = null;
    parentImageUrl = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userName'] = userName;
    _data['nameAlias'] = nameAlias;
    _data['bio'] = bio;
    _data['rank'] = rank;
    _data['score'] = score;
    _data['imageUrl'] = imageUrl;
    _data['identifierCode'] = identifierCode;
    _data['parentName'] = parentName;
    _data['parentImageUrl'] = parentImageUrl;
    return _data;
  }
}