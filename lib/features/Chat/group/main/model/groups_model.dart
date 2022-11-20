import 'dart:convert';

GroupsModel groupsModelFromJson(String str) => GroupsModel.fromJson(json.decode(str));

String groupsModelToJson(GroupsModel data) => json.encode(data.toJson());

class GroupsModel {
  GroupsModel({
    required this.data,
  });

  Data data;

  factory GroupsModel.fromJson(Map<String, dynamic> json) => GroupsModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.imageUrl,
    this.lastMessage,
    this.lastMessageDateTime,
    this.ownerName,
    this.numberMessageNoSeen,
  });
  int? id;
  String? name;
  String? imageUrl;
  String? lastMessage;
  String? lastMessageDateTime;
  String? ownerName;
  String? numberMessageNoSeen;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    imageUrl: json["imageUrl"],
    lastMessage: json["lastMessage"],
    lastMessageDateTime: json["lastMessageDateTime"],
    ownerName: json["ownerName"],
    numberMessageNoSeen: json["numberMessageNoSeen"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "name": name,
    "imageUrl": imageUrl,
    "lastMessage": lastMessage,
    "lastMessageDateTime": lastMessageDateTime,
    "ownerName": ownerName,
    "numberMessageNoSeen": numberMessageNoSeen,
  };
}
