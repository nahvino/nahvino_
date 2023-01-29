import 'dart:convert';

GroupModel GroupModelResponseJson(String str) =>
    GroupModel.fromJson(json.decode(str));
class GroupModel {
  GroupModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.adminId,
    required this.adminName,
    required this.adminImageurl,
    required this.supervisor1Id,
    required this.supervisor1Name,
    required this.supervisor1Imageurl,
    required this.supervisor2Id,
    required this.supervisor2Name,
    required this.supervisor2Imageurl,
    required this.messages,
    required this.userCount,
  });
  int? id;
  String? name;
  String? bio;
  String? adminId;
  String? adminName;
  String? adminImageurl;
  String? supervisor1Id;
  String? supervisor1Name;
  String? supervisor1Imageurl;
  String? supervisor2Id;
  String? supervisor2Name;
  String? supervisor2Imageurl;
  String? messages;
  int? userCount;

  GroupModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    bio = json['bio'];
    adminId = json['adminId'];
    adminName = json['adminName'];
    adminImageurl = json['adminImageurl'];
    supervisor1Id = json['supervisor1Id'];
    supervisor1Name = json['supervisor1Name'];
    supervisor1Imageurl = json['supervisor1Imageurl'];
    supervisor2Id = json['supervisor2Id'];
    supervisor2Name = json['supervisor2Name'];
    supervisor2Imageurl = json['supervisor2Imageurl'];
    messages = json['messages'];
    userCount = json['userCount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['bio'] = bio;
    _data['adminId'] = adminId;
    _data['adminName'] = adminName;
    _data['adminImageurl'] = adminImageurl;
    _data['supervisor1Id'] = supervisor1Id;
    _data['supervisor1Name'] = supervisor1Name;
    _data['supervisor1Imageurl'] = supervisor1Imageurl;
    _data['supervisor2Id'] = supervisor2Id;
    _data['supervisor2Name'] = supervisor2Name;
    _data['supervisor2Imageurl'] = supervisor2Imageurl;
    _data['messages'] = messages;
    _data['userCount'] = userCount;
    return _data;
  }
}