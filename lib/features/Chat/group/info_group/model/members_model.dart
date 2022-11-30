class MembersModel {
  List<Data>? data;
  int? statusCode;
  String? message;

  MembersModel({this.data, this.statusCode, this.message});

  MembersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? imageUrl;
  String? userame;
  bool? isAdmin;

  Data({this.id, this.imageUrl, this.userame, this.isAdmin});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    userame = json['userame'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['userame'] = this.userame;
    data['isAdmin'] = this.isAdmin;
    return data;
  }
}