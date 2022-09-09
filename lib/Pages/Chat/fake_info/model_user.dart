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
    img: "assets/images/home/user.png",
    btn: true,
    time: "10:03 ق.ب");
final User hamad = User(
    name: "hame",
    mass: "آره موافقم هستم",
    img: "assets/images/home/user.png",
    btn: true,
    time: "10:03 ق.ب");
List<User> user = [ali, hamad];

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
    required this.meber,
  });
  final String? id;
  final bool meber;
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
    meber: true,
    lastmass: "22",
    nameadmin: "هادی",
    manber: "21",
    time: "10:50 ق.ب",
    viewer: "124");
final Group sh = Group(
    id: "b",
    image: "assets/images/ram/gorp.png",
    meber: true,
    name: "ترک شیشه",
    lastmass: "141",
    nameadmin: "سجاد",
    manber: "78",
    time: "21:10 ب.ظ",
    viewer: "500");

final Group sss = Group(
    id: "bs",
    image: "assets/images/ram/gorp.png",
    meber: true,
    name: "شیشه",
    lastmass: "21",
    nameadmin: "سجاد",
    manber: "21",
    time: "21:10 ب.ظ",
    viewer: "45");

final Group mo = Group(
    id: "mo",
    image: "assets/images/ram/gorp.png",
    meber: true,
    name: "مخدر",
    lastmass: "1",
    nameadmin: "سجاد",
    manber: "20",
    time: "21:10 ب.ظ",
    viewer: "12");

List<Group> fakegroup = [sh,sss,mo,etiyad];

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
    userid: "b",
    idgroup: "b",
    image: "assets/images/ram/gorp.png",
    mass:
        "هر دو پادشاه عاشق همسران خود بودندپادشاه هند دستور \n داد که به یادبود همسر محبوبش \n ، بنای بسیار  زیبای تاج محل را با صرف هزینه گزافی بسازند!",
    name: "علی",
    time: "10:50 ب.ظ");
final Massage m11 = Massage(
    id: "2",
    userid: "a",
    idgroup: "a",
    image: "assets/images/home/user.png",
    mass: "یار زیباید!",
    name: "علی",
    time: "10:50 ب.ظ");
final Massage m2 = Massage(
    id: "3",
    userid: "b",
    idgroup: "1",
    image: "assets/images/home/user.png",
    mass: "خوبی",
    name: "ممد",
    time: "10:50 ب.ظ");
List<Massage> fakeMassagegroup = [m1, m11, m2];
