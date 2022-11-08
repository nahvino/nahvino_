import 'dart:convert';

InfoModel infoModelFromJson(String str) => InfoModel.fromJson(json.decode(str));

String infoModelToJson(InfoModel data) => json.encode(data.toJson());

class InfoModel {
  InfoModel({
    required this.data,
    required this.statusCode,
    required this.message,
  });

  Data data;
  int statusCode;
  String message;

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
    data: Data.fromJson(json["data"]),
    statusCode: json["statusCode"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "statusCode": statusCode,
    "message": message,
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.audience,
    this.admins,
    this.link,
    this.flagearers,
    this.conquests,
    this.rules,
    this.promise,
    this.count,
  });

  int? id;
  String? name;
  String? description;
  String? imageUrl;
  int? audience;
  List<dynamic>? admins;
  String? link;
  int? flagearers;
  int? conquests;
  String? rules;
  String? promise;
  int? count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    audience: json["audience"],
    admins:  List<dynamic>.from(json["admins"].map((x) => x)),
    link: json["link"],
    flagearers: json["flagearers"],
    conquests: json["conquests"],
    rules: json["rules"],
    promise: json["promise"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "imageUrl": imageUrl,
    "audience": audience,
    "admins": admins != null ? List<dynamic>.from(admins!.map((x) => x)) : [],
    "link": link,
    "flagearers": flagearers,
    "conquests": conquests,
    "rules": rules,
    "promise": promise,
    "count": count,
  };
}
