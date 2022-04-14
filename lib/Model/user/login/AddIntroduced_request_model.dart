class AddIntroducedRequestModel {
  AddIntroducedRequestModel({
    required this.userId,
    required this.identifierCode,
  });
  late final String userId;
  late final int identifierCode;

  AddIntroducedRequestModel.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    identifierCode = json['identifierCode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['identifierCode'] = identifierCode;
    return _data;
  }
}