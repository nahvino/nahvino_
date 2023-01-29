class RequestMembresModelGroup {
  RequestMembresModelGroup({
    this.data,
    this.statusCode,
    this.message,});

  RequestMembresModelGroup.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RequestData.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    message = json['message'];
  }
  List<RequestData>? data;
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

class RequestData {
  RequestData({
    this.id,
    this.userName,
    this.dateTime,
    this.requesteDateTime,
    this.isAccsept,});

  RequestData.fromJson(dynamic json) {
    id = json['id'];
    userName = json['userName'];
    dateTime = json['dateTime'];
    requesteDateTime = json['requestDateTime'];
    isAccsept = json['isAccsept'];
  }
  int? id;
  String? userName;
  String? dateTime;
  String? requesteDateTime;
  int? isAccsept;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userName'] = userName;
    map['dateTime'] = dateTime;
    map['requestDateTime'] = requesteDateTime;
    map['isAccsept'] = isAccsept;
    return map;
  }

}