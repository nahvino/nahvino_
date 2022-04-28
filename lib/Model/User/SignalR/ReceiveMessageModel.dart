import 'dart:convert';

ReceiveMessageModel GroupModelResponseJson(String str) =>
    ReceiveMessageModel.fromJson(json.decode(str));
class ReceiveMessageModel {
  ReceiveMessageModel({
    required this.id,
    required this.userNameAlias,
    required this.parentMessageUserNameAlias,
    required this.parentMessageText,
    required this.userId,
    required this.text,

  });
  int? id;
  String? userNameAlias;
  String? parentMessageUserNameAlias;
  String? parentMessageText;
  String? userId;
  String? text;
  String? insertTime;


  ReceiveMessageModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userNameAlias = json['userNameAlias'];
    parentMessageUserNameAlias = json['parentMessageUserNameAlias'];
    parentMessageText = json['parentMessageText'];
    userId = json['userId'];
    text = json['text'];
    insertTime = json['insertTime'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userNameAlias'] = userNameAlias;
    _data['text'] = text;
    _data['insertTime'] = insertTime;

    return _data;
  }
}