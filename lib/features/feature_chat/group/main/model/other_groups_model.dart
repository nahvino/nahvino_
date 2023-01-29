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
    this.count
  });
  int? id;
  String? description;
  String? name;
  String? imageUrl;
  String? lastMessage;
  String? lastMessageDateTime;
  String? ownerName;
  String? numberMessageNoSeen;
  int? count;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    id: json["id"],
    description: json["description"],
    name: json["name"],
    imageUrl: json["imageUrl"],
    lastMessage: json["lastMessage"],
    lastMessageDateTime: json["lastMessageDateTime"],
    ownerName: json["ownerName"],
    numberMessageNoSeen: json["numberMessageNoSeen"],
    count: json["count"],
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
    "count": count,
  };
}