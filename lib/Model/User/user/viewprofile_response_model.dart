import 'dart:convert';

GetProfileUserResponseModel getprofileuserresponseJson(String str) =>
    GetProfileUserResponseModel.fromJson(json.decode(str));

class GetProfileUserResponseModel {
  GetProfileUserResponseModel({
    this.userName,
    this.nameAlias,
    this.bio,
    this.rank,
    this.score,
    this.imageUrl,
    this.identifierCode,
    this.parentId,
    this.parentName,
    this.parentImageUrl,
    this.dateTimeAbandon,
  });
  String? userName;
  String? nameAlias;
  String? bio;
  int? rank;
  int? score;
  String? imageUrl;
  int? identifierCode;
  String? parentId;
  String? parentName;
  String? parentImageUrl;
  String? dateTimeAbandon;

  GetProfileUserResponseModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    nameAlias = json['nameAlias'];
    bio = json['bio'];
    rank = json['rank'];
    score = json['score'];
    imageUrl = json['imageUrl'];
    identifierCode = json['identifierCode'];
    parentId = json['parentId'];
    parentName = json['parentName'];
    parentImageUrl = json['parentImageUrl'];
    dateTimeAbandon = json['dateTimeAbandon'];
  }

  get value => null;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userName'] = userName;
    _data['nameAlias'] = nameAlias;
    _data['bio'] = bio;
    _data['rank'] = rank;
    _data['score'] = score;
    _data['imageUrl'] = imageUrl;
    _data['identifierCode'] = identifierCode;
    _data['parentId'] = parentId;
    _data['parentName'] = parentName;
    _data['parentImageUrl'] = parentImageUrl;
    _data['dateTimeAbandon'] = dateTimeAbandon;
    return _data;
  }
}
