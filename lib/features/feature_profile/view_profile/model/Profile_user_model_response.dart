class ProfileUserModelResponse {
  ProfileUserModelResponse({
      this.userName, 
      this.nameAlias, 
      this.bio, 
      this.rank, 
      this.score, 
      this.imageUrl, 
      this.identifierCode, 
      this.parentId, 
      this.parentName, 
      this.parentImageUrl, 
      this.dateTimeAbandon, 
      this.isHaveFlag,});

  ProfileUserModelResponse.fromJson(dynamic json) {
    userName = json['userName'];
    nameAlias = json['nameAlias'];
    bio = json['bio'];
    rank = json['rank'];
    score = json['score'];
    imageUrl = json['imageUrl'];
    identifierCode = json['identifierCode'];
    parentId = json['parentId'];
    parentName = json['parentName'];
    parentImageUrl = json['parentImageUrl'];
    dateTimeAbandon = json['dateTimeAbandon'];
    isHaveFlag = json['isHaveFlag'];
  }
  String? userName;
  String? nameAlias;
  String? bio;
  int? rank;
  int? score;
  String? imageUrl;
  int? identifierCode;
  String? parentId;
  String? parentName;
  String? parentImageUrl;
  String? dateTimeAbandon;
  bool? isHaveFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = userName;
    map['nameAlias'] = nameAlias;
    map['bio'] = bio;
    map['rank'] = rank;
    map['score'] = score;
    map['imageUrl'] = imageUrl;
    map['identifierCode'] = identifierCode;
    map['parentId'] = parentId;
    map['parentName'] = parentName;
    map['parentImageUrl'] = parentImageUrl;
    map['dateTimeAbandon'] = dateTimeAbandon;
    map['isHaveFlag'] = isHaveFlag;
    return map;
  }

}