class User {
  User({this.name, this.img, this.btn, this.mass, this.time});

  final String? name;
  final String? img;
  final String? mass;
  final String? time;
  final bool? btn;
}

final User ali = User(
    name: "ali",
    mass: "آره موافقم هستم",
    img: "assets/images/ram/gorp.png",
    btn: true,
    time: "10:03 ق.ب");
final User hamad = User(
    name: "hame",
    mass: "آره موافقم هستم",
    img: "assets/images/ram/gorp.png",
    btn: true,
    time: "10:03 ق.ب");
List<User> test = [ali, hamad];

class Group {
  Group({
    this.id,
    this.image,
    this.name,
    this.nameadmin,
    this.manber,
    this.viewer,
    this.lastmass,
    this.time,
  });
  final String? id;
  final String? image;
  final String? name;
  final String? nameadmin;
  final String? manber;
  final String? viewer;
  final String? lastmass;
  final String? time;
}

final Group etiyad = Group(
    id: "a",
    image: "assets/images/ram/gorp.png",
    name: "ترک اعتیاد",
    lastmass: "22",
    nameadmin: "هادی",
    manber: "21",
    time: "10:50 ق.ب",
    viewer: "124");
final Group sh = Group(
    id: "b",
    image: "assets/images/ram/gorp.png",
    name: "ترک شیشه",
    lastmass: "21",
    nameadmin: "سجاد",
    manber: "21",
    time: "21:10 ب.ظ",
    viewer: "299");

List<Group> fakegroup = [etiyad, sh];

class Massage {
  Massage({
    this.id,
    this.idgroup,
    this.userid,
    this.image,
    this.name,
    this.mass,
    this.time,
  });
  final String? id;
  final String? idgroup;
  final String? userid;
  final String? image;
  final String? name;
  final String? mass;
  final String? time;
}

final Massage m1 = Massage(
    id: "1",
    userid: "a",
    idgroup: "1",
    image: "assets/images/ram/gorp.png",
    mass:
        "هر دو پادشاه عاشق همسران خود بودندپادشاه هند دستور \n داد که به یادبود همسر محبوبش \n ، بنای بسیار  زیبای تاج محل را با صرف هزینه گزافی بسازند!",
    name: "علی",
    time: "10:50 ب.ظ");
final Massage m11 = Massage(
    id: "2",
    userid: "a",
    idgroup: "1",
    image: "assets/images/ram/gorp.png",
    mass: "یار زیباید!",
    name: "علی",
    time: "10:50 ب.ظ");
final Massage m2 = Massage(
    id: "3",
    userid: "b",
    idgroup: "1",
    image: "assets/images/ram/gorp.png",
    mass: "خوبی",
    name: "ممد",
    time: "10:50 ب.ظ");
List<Massage> fakeMassagegroup = [m1, m11, m2];
