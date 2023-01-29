class MembersModel {
  MembersModel({
      this.data, 
      this.statusCode, 
      this.message,});

  MembersModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    message = json['message'];
  }
  List<Data>? data;
  int? statusCode;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = statusCode;
    map['message'] = message;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.imageUrl, 
      this.userame, 
      this.isAdmin,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    userame = json['userame'];
    isAdmin = json['isAdmin'];
  }
  int? id;
  String? imageUrl;
  String? userame;
  bool? isAdmin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['imageUrl'] = imageUrl;
    map['userame'] = userame;
    map['isAdmin'] = isAdmin;
    return map;
  }

}