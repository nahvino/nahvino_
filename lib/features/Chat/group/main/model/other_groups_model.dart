
import 'dart:convert';


List<List<Group>> otherGroupsModelFromJson(String str) => List<List<Group>>.from(json.decode(str).map((x) => List<Group>.from(x.map((x) => Group.fromJson(x)))));

String otherGroupsModelToJson(List<List<Group>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class Group {
  Group({
    this.id,
    this.description,
    this.name,
    this.imageUrl,
    this.lastMessage,
    this.lastMessageDateTime,
    this.ownerName,
    this.numberMessageNoSeen,
  });
  int? id;
  String? description;
  String? name;
  String? imageUrl;
  String? lastMessage;
  String? lastMessageDateTime;
  String? ownerName;
  String? numberMessageNoSeen;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    id: json["id"],
    description: json["description"],
    name: json["name"],
    imageUrl: json["imageUrl"],
    lastMessage: json["lastMessage"],
    lastMessageDateTime: json["lastMessageDateTime"],
    ownerName: json["ownerName"],
    numberMessageNoSeen: json["numberMessageNoSeen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "name": name,
    "imageUrl": imageUrl,
    "lastMessage": lastMessage,
    "lastMessageDateTime": lastMessageDateTime,
    "ownerName": ownerName,
    "numberMessageNoSeen": numberMessageNoSeen,
  };
}