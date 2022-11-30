import 'dart:convert';
/// data : [{"id":1011,"imageUrl":"/Images/UserProfile/11d75795-3568-4d13-868e-7aaaf3c1c332_scaled_image_picker7996687129395723684.jpg","userame":"saharseifi","isAdmin":false},{"id":2003,"imageUrl":"/Images/UserProfile/6a0ea640-a666-4106-85f1-91d9b059e4ae_scaled_image_picker4800121982224913104.jpg","userame":"User1068631","isAdmin":false}]
/// statusCode : 200
/// message : ""

MemberModels memberModelsFromJson(String str) => MemberModels.fromJson(json.decode(str));
String memberModelsToJson(MemberModels data) => json.encode(data.toJson());
class MemberModels {
  MemberModels({
      List<Data>? data, 
      num? statusCode, 
      String? message,}){
    _data = data;
    _statusCode = statusCode;
    _message = message;
}

  MemberModels.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _statusCode = json['statusCode'];
    _message = json['message'];
  }
  List<Data>? _data;
  num? _statusCode;
  String? _message;
MemberModels copyWith({  List<Data>? data,
  num? statusCode,
  String? message,
}) => MemberModels(  data: data ?? _data,
  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
);
  List<Data>? get data => _data;
  num? get statusCode => _statusCode;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    return map;
  }

}

/// id : 1011
/// imageUrl : "/Images/UserProfile/11d75795-3568-4d13-868e-7aaaf3c1c332_scaled_image_picker7996687129395723684.jpg"
/// userame : "saharseifi"
/// isAdmin : false

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      String? imageUrl, 
      String? userame, 
      bool? isAdmin,}){
    _id = id;
    _imageUrl = imageUrl;
    _userame = userame;
    _isAdmin = isAdmin;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _imageUrl = json['imageUrl'];
    _userame = json['userame'];
    _isAdmin = json['isAdmin'];
  }
  num? _id;
  String? _imageUrl;
  String? _userame;
  bool? _isAdmin;
Data copyWith({  num? id,
  String? imageUrl,
  String? userame,
  bool? isAdmin,
}) => Data(  id: id ?? _id,
  imageUrl: imageUrl ?? _imageUrl,
  userame: userame ?? _userame,
  isAdmin: isAdmin ?? _isAdmin,
);
  num? get id => _id;
  String? get imageUrl => _imageUrl;
  String? get userame => _userame;
  bool? get isAdmin => _isAdmin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['imageUrl'] = _imageUrl;
    map['userame'] = _userame;
    map['isAdmin'] = _isAdmin;
    return map;
  }

}