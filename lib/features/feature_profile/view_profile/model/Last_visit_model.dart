class LastVisitModel {
  LastVisitModel({
      this.data, 
      this.statusCode, 
      this.message,});

  LastVisitModel.fromJson(dynamic json) {
    data = json['data'];
    statusCode = json['statusCode'];
    message = json['message'];
  }
  int? data;
  int? statusCode;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['statusCode'] = statusCode;
    map['message'] = message;
    return map;
  }

}