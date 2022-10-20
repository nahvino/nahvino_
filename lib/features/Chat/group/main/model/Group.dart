import 'Data.dart';

class Group {
  Group({
       this.data,});

  Group.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
    this.name,
    this.imageUrl,
    this.lastMessage,
    this.lastMessageDateTime,
    this.ownerName,
    this.numberMessageNoSeen,});

  Data.fromJson(dynamic json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    lastMessage = json['lastMessage'];
    lastMessageDateTime = json['lastMessageDateTime'];
    ownerName = json['ownerName'];
    numberMessageNoSeen = json['numberMessageNoSeen'];
  }
  String? name;
  String? imageUrl;
  String? lastMessage;
  String? lastMessageDateTime;
  String? ownerName;
  String? numberMessageNoSeen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['imageUrl'] = imageUrl;
    map['lastMessage'] = lastMessage;
    map['lastMessageDateTime'] = lastMessageDateTime;
    map['ownerName'] = ownerName;
    map['numberMessageNoSeen'] = numberMessageNoSeen;
    return map;
  }

}