class UserProfileModel {
  UserProfileModel({
      this.userName, 
      this.nameAlias, 
      this.bio, 
      this.rank, 
      this.score, 
      this.imageUrl, 
      this.parentName, 
      this.parentImageUrl,});

  UserProfileModel.fromJson(dynamic json) {
    userName = json['userName'];
    nameAlias = json['nameAlias'];
    bio = json['bio'];
    rank = json['rank'];
    score = json['score'];
    imageUrl = json['imageUrl'];
    parentName = json['parentName'];
    parentImageUrl = json['parentImageUrl'];
  }
  String? userName;
  String? nameAlias;
  String? bio;
  int? rank;
  int? score;
  String? imageUrl;
  String? parentName;
  String? parentImageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = userName;
    map['nameAlias'] = nameAlias;
    map['bio'] = bio;
    map['rank'] = rank;
    map['score'] = score;
    map['imageUrl'] = imageUrl;
    map['parentName'] = parentName;
    map['parentImageUrl'] = parentImageUrl;
    return map;
  }

}