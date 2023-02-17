class IntoducdModel {
  IntoducdModel({
      this.statusCode, 
      this.message,});

  IntoducdModel.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }
  int? statusCode;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['message'] = message;
    return map;
  }

}