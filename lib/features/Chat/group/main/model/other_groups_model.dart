import 'dart:convert';

OtherGroupsModel otherGroupsModelFromJson(String str) => OtherGroupsModel.fromJson(json.decode(str));

String otherGroupsModelToJson(OtherGroupsModel data) => json.encode(data.toJson());

class OtherGroupsModel {
  OtherGroupsModel({
    required this.data,
  });

  List<Datum> data;

  factory OtherGroupsModel.fromJson(Map<String, dynamic> json) => OtherGroupsModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))).toList(),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.name,
    this.imageUrl,
    this.lastMessage,
    this.lastMessageDateTime,
    this.ownerName,
    this.numberMessageNoSeen,
  });

  String? name;
  String? imageUrl;
  String? lastMessage;
  String? lastMessageDateTime;
  String? ownerName;
  String? numberMessageNoSeen;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    imageUrl: json["imageUrl"],
    lastMessage: json["lastMessage"],
    lastMessageDateTime: json["lastMessageDateTime"],
    ownerName: json["ownerName"],
    numberMessageNoSeen: json["numberMessageNoSeen"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "imageUrl": imageUrl,
    "lastMessage": lastMessage,
    "lastMessageDateTime": lastMessageDateTime,
    "ownerName": ownerName,
    "numberMessageNoSeen": numberMessageNoSeen,
  };
}
