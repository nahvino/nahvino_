class Data {
  Data({
      this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.audience,
      this.admins,
      this.link,
      this.flagearers,
      this.conquests,
      this.rules,
      this.promise,
      this.count,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    audience = json['audience'];
    if (json['admins'] != null) {
      admins = [];
      json['admins'].forEach((v) {
        admins?.add(Data.fromJson(v));
      });
    }
    link = json['link'];
    flagearers = json['flagearers'];
    conquests = json['conquests'];
    rules = json['rules'];
    promise = json['promise'];
    count = json['count'];
  }
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  int? audience;
  List<dynamic>? admins;
  String? link;
  int? flagearers;
  int? conquests;
  String? rules;
  String? promise;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['imageUrl'] = imageUrl;
    map['audience'] = audience;
    final admins = this.admins;
    if (admins != null) {
      map['admins'] = admins.map((v) => v.toJson()).toList();
    }
    map['link'] = link;
    map['flagearers'] = flagearers;
    map['conquests'] = conquests;
    map['rules'] = rules;
    map['promise'] = promise;
    map['count'] = count;
    return map;
  }

}