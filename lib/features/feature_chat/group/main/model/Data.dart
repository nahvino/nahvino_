/*-
class Data {
  Data({
      this.id, 
      this.name, 
      this.description, 
      this.imageUrl, 
      this.lastMessage, 
      this.lastMessageDateTime, 
      this.ownerName, 
      this.numberMessageNoSeen, 
      this.count,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    lastMessage = json['lastMessage'];
    lastMessageDateTime = json['lastMessageDateTime'];
    ownerName = json['ownerName'];
    numberMessageNoSeen = json['numberMessageNoSeen'];
    count = json['count'];
  }
  int id;
  String name;
  dynamic description;
  String imageUrl;
  String lastMessage;
  String lastMessageDateTime;
  dynamic ownerName;
  dynamic numberMessageNoSeen;
  int count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['imageUrl'] = imageUrl;
    map['lastMessage'] = lastMessage;
    map['lastMessageDateTime'] = lastMessageDateTime;
    map['ownerName'] = ownerName;
    map['numberMessageNoSeen'] = numberMessageNoSeen;
    map['count'] = count;
    return map;
  }

}

*/