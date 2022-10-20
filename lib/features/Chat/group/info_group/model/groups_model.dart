import 'dart:convert';

InfoGroupsModel GroupsModelResponseJson(String str) =>
    InfoGroupsModel.fromJson(json.decode(str));
class InfoGroupsModel {
  InfoGroupsModel({
    required this.id,

  });
  int? id;


  InfoGroupsModel.fromJson(Map<String, dynamic> json){
    id = json['id'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;

    return _data;
  }
}