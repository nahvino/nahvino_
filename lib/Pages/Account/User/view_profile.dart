import 'package:Nahvino/Pages/Account/User/edit_profile_screen.dart';
import 'package:Nahvino/Services/Login/Google/notification_service.dart';
import 'package:Nahvino/Services/Users/User/profile_service.dart';
import 'package:Nahvino/Utils/OtherUtils/imagedialog.dart';
import 'package:Nahvino/Utils/Widget/image_view.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/controllers/getx/chat/about_group_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../App_localizations.dart';
import '../../../Data/Local/version_data.dart';
import '../../../Model/user/user/viewprofile_response_model.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/Text.dart';
import '../../../Data/Local/view_profial_data.dart';
import '../Login/registration.dart';
import 'notifications.dart';
import 'user_security_stting_menus.dart';
import 'view_profile_uesr_arshed.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key, this.tabIndex}) : super(key: key);
  final int? tabIndex;
  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  bool isApiCallProgress = true;
  AboutGroupController noti = Get.put(AboutGroupController());
  ViewProfileController databox = Get.put(ViewProfileController());
  VersionData version = Get.put(VersionData());
  GetProfileUserResponseModel? resultResponse;
  var ghoghnosResponsee;
  var resultResponseGetUserAbandon;
  var flag;
  late ServiceProfile testtarkh;
  Imageview img = Imageview();
  String? imagePath;
  late int day;
  late int month;
  late int year;
  String date = "0";
  String mont = "0";
  String yaer = "0";
    List<String> ranks = <String>[
    "مبتدی",
    "رهجو",
    "ره رو",
    "رهنورد",
    "راهنما",
    "راه بلد",
    "حامی",
    "ناجی",
    "نحوینو"
  ];
  List<String> ranksadad = <String>[
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9"
  ];
  List<Widget> ghoghnos = <Widget>[
    Lottie.asset('assets/anim/phonix/level1.json'),
    Lottie.asset('assets/anim/phonix/level2.json'),
    Lottie.asset('assets/anim/phonix/level3.json'),
    Lottie.asset('assets/anim/phonix/level4.json'),
    Lottie.asset('assets/anim/phonix/level5.json'),
    Lottie.asset('assets/anim/phonix/level6.json'),
    Lottie.asset('assets/anim/phonix/level7.json'),
  ];
  List<Widget> hart = <Widget>[
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave1.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave2.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave3.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave4.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave5.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave6.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave7.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave8.png')),
  ];
  ghgoghnos() {
    if (ghoghnosResponsee['data'] > 6) {
      Lottie.asset('assets/anim/phonix/level8.json');
    } else {
      ghoghnos[ghoghnosResponsee['data']];
    }
  }

  Day() {
    double dotabdel = day.toDouble();

    double range = 0.00;
    late double a = range;
    for (double i = 0.00; i <= dotabdel / 29.00; i += 0.037) {
      range = i;
    }
    return a;
  }

  Month() {
    double dotabdel = month.toDouble();
    double range = 0.00;
    late double a = range;
    for (double i = 0.00; i <= dotabdel / 12.00; i += 0.11) {
      range = i;
    }
    return a;
  }

  Year() {
    double dotabdel = year.toDouble();
    double range = 0.00;
    late double a = range;
    for (double i = 0.00; i <= dotabdel / 100.0; i += 2.0) {
      range = i;
    }
    return a;
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      databox.checkdata();
      ServiceProfile.GetLastVisit().then((response) {
        ghoghnosResponsee = response;
        print(" -------------<GetLastVisit>-------------- => $response");
        ServiceProfile.flag().then((response) {
          flag =response;
          print(
              "--------------<flag>-------------- => $response");

        ServiceProfile.getabandon().then((response) async {
            print("------<getuserabandon>------- => $response");
            resultResponseGetUserAbandon = response;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (prefs.getBool("switchState") == false ||
                prefs.getBool("switchState") == null) {
              ServiceNotification.notificationaApi().then((response) {
                print(
                    "--------------<notificationaApi>-------------- => $response");
                setState(() {
                  isApiCallProgress = false;
                });
              });
            }
          });
        });
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  bool lang = false; // en => true / fa => false
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: SafeArea(
              child: isApiCallProgress
                  ? Center(
                      child: Lottie.asset('assets/anim/loading/loading.json',
                          height: 300, width: 300),
                    )
                  : body(context))),
    );
  }

  Widget body(BuildContext context) {
    if (resultResponseGetUserAbandon != false) {
      date = resultResponseGetUserAbandon['data'].split(" ")[2];
      mont = resultResponseGetUserAbandon['data'].split(" ")[1];
      yaer = resultResponseGetUserAbandon['data'].split(" ")[0];
    }
    day = int.parse(date);
    month = int.parse(mont);
    year = int.parse(yaer);
    if (day < 0) {
      day = 0;
    }

    return Obx((() => SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.only(bottom: 6),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.height *
                                        0.02),
                                child: Subhead(
                                  textAlign: TextAlign.right,
                                  text: databox.username.value,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                height: 30,
                                child: PopupMenuButton<int>(
                                  icon: Icon(Icons.more_vert_rounded),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 0,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.security,
                                            color: Colors.cyan,
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Callout(
                                            textAlign: TextAlign.end,
                                            text: AppLocalizations.of(context)!
                                                .translate(
                                              'Security_settings',
                                            )!,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                    /*    PopupMenuDivider(height: 4),
                                  PopupMenuItem(
                                    value: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.notifications,
                                          color: Colors.cyan,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Callout(
                                          textAlign: TextAlign.end,
                                          color: Colors.black,
                                          text: AppLocalizations.of(context)!
                                              .translate(
                                            'Notifications',
                                          )!,
                                        ),
                                      ],
                                    ),
                                  ),*/
                                    PopupMenuDivider(height: 1),
                                    PopupMenuItem(
                                      value: 4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Caption1(
                                            textAlign: TextAlign.center,
                                            color: Colors.black,
                                            text: AppLocalizations.of(context)!
                                                .translate(
                                              'YCTIANM',
                                            )!,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.share,
                                            color: Colors.cyan,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Callout(
                                            textAlign: TextAlign.center,
                                            text: databox.identifierCode.value
                                                .toString(),
                                            color: Colors.black,
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuDivider(),
                                    PopupMenuItem(
                                      value: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              'assets/images/icon/pngwing.com.png',
                                              height: 24,
                                              width: 24,
                                              color: Colors.cyan),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Callout(
                                            textAlign: TextAlign.center,
                                            color: Colors.black,
                                            text: AppLocalizations.of(context)!
                                                .translate(
                                              'Eixt',
                                            )!,
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  onSelected: (item) =>
                                      onSelected(context, item),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (databox.imageUrl.value == "null" ||
                                  databox.imageUrl.value == "")
                              ? img.imageAssetProfile(flag: flag)
                              : InkWell(
                                  child:
                                  img.imageProfile(Img:databox.imageUrl.value, flag: flag),
                                  onTap: () {
                                    showDialog<void>(
                                        context: context,
                                        builder: (context) => ImageDialog());
                                  }),
                          Column(
                            children: [
                              databox.namealias.value == "null" ||
                                      databox.namealias.value == ""
                                  ? Callout(
                                      text: "مهمان",
                                      color: Colors.black38,
                                      textAlign: TextAlign.start,
                                    )
                                  : Subhead(
                                      text: databox.namealias.value,
                                      color: Colors.teal,
                                      textAlign: TextAlign.start,
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 80,
                                height: 30,
                                decoration: new BoxDecoration(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    border: Border.all(
                                        color: Colors.black26, width: 1)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      padding: EdgeInsets.only(
                                        right: 6,
                                        left: 1,
                                        bottom: 2,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: Colors.black26, width: 1)),
                                      child: Callout(
                                        text: ranksadad[databox.rank.value],
                                        color: Colors.purpleAccent,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Callout(
                                      text: ranks[databox.rank.value],
                                      color: Colors.black,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image(
                                height: 30,
                                image:
                                    AssetImage("assets/images/home/bbarg.png"),
                              ),
                              /*
                            InkWell(
                                child: Image(
                                  height: 30,
                                  image: AssetImage(
                                      "assets/images/home/bbarg.png"),
                                ),
                                onTap: () {
                                  showDialog<void>(
                                      context: context,
                                      builder: (context) => BargDialog(
                                            test: resultResponse!.score
                                                .toString(),
                                          ));
                                }),*/
                              SizedBox(
                                height: 4,
                              ),
                              Callout(
                                text: databox.score.value
                                    .toString() /*resultResponse!.score.toString()*/,
                                color: Colors.black,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              /*Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.1,
                              ),
                            ),*/

                              InkWell(
                                  onTap: () {
                                    /*showDialog<void>(
                                    context: context,
                                    builder: (context) => /*ArshadDialog()*/ ViewProfileUesr(userid: resultResponse!.parentId,));*/
                                    /*    showDialog<void>(
                                    context: context,
                                    builder: (context) => ViewProfileUesrArshed(
                                          userid: resultResponse!.parentId,
                                        ));*/
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewProfileUesrArshed(
                                                  userid: databox.parentId
                                                      .value /*resultResponse!.parentId*/,
                                                )));
                                  },
                                  child: Column(
                                    children: [
                                      /* (resultResponse!.parentImageUrl != null &&
                                          resultResponse!.parentImageUrl != "")*/
                                      (databox.parentimageurl.value != "null" &&
                                              databox.parentimageurl.value !=
                                                  "")
                                          ? Card(
                                              shape: CircleBorder(),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              child: CachedNetworkImage(
                                                height: 45,
                                                width: 45,
                                                cacheManager: CacheManager(
                                                    Config('customCacheKey',
                                                        stalePeriod:
                                                            Duration(days: 7),
                                                        maxNrOfCacheObjects:
                                                            100)),
                                                imageUrl: MainConfig.fileurl +
                                                    databox.parentimageurl
                                                        .value /*resultResponse!.parentImageUrl!*/,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            )
                                          : Image.asset(
                                              'assets/images/home/user.png',
                                              fit: BoxFit.cover,
                                              height: 45,
                                              width: 45,
                                            ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Callout(
                                        text: databox.parentname.value,
                                        color: Colors.teal,
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 0.5,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height * 0.03,
                            left: MediaQuery.of(context).size.height * 0.03,
                            bottom: MediaQuery.of(context).size.height * 0.02,
                            top: MediaQuery.of(context).size.height * 0.01,
                          ),
                          child: databox.bio.value == "null" ||
                                  databox.bio.value == ""
                              ? Callout(
                                  text: "بیو گرافی شما",
                                  color: Colors.black38,
                                  textAlign: TextAlign.start,
                                )
                              : Callout(
                                  text: databox.bio.value,
                                  color: Colors.black,
                                  textAlign: TextAlign.start,
                                )),
                      SizedBox(
                        height: 1,
                      ),
                      Buttonfull(
                        text: AppLocalizations.of(context)!.translate(
                          'Edit Profile',
                        )!,
                        onPressed: () => Get.to(EditProfileScreen()),
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      if (ghoghnosResponsee['data'] > 6)
                        Container(
                          alignment: Alignment.center,
                          child: Lottie.asset('assets/anim/phonix/level7.json'),
                        ),
                      Container(
                        alignment: Alignment.center,
                        child: ghoghnos[ghoghnosResponsee['data']],
                      ),
                      if (ghoghnosResponsee['data'] > 6)
                        Container(
                            width: 150,
                            child: Image.asset(
                                'assets/images/hart/hart-lave8.png')),
                      Container(
                        alignment: Alignment.center,
                        child: hart[ghoghnosResponsee['data']],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Body(
                        textAlign: TextAlign.center,
                        color: Colors.black87,
                        text: "پاکی شما تا این لحظه",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: CircularPercentIndicator(
                              radius: 35.0,
                              lineWidth: 5.0,
                              percent: Year(),
                              animation: true,
                              center: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Footnate(
                                      textAlign: TextAlign.center,
                                      color: Colors.cyan,
                                      text: yaer.toString(),
                                    ),
                                    Caption2(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text: "سال"),
                                  ],
                                ),
                              ),
                              progressColor: Colors.cyanAccent,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: CircularPercentIndicator(
                              radius: 35.0,
                              lineWidth: 5.0,
                              percent: Month(),
                              animation: true,
                              center: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Footnate(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text: month.toString()),
                                    Caption2(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text: "ماه"),
                                  ],
                                ),
                              ),
                              progressColor: Colors.cyanAccent,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            child: CircularPercentIndicator(
                              radius: 35.0,
                              lineWidth: 5.0,
                              percent: Day(),
                              animation: true,
                              center: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Footnate(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text: day.toString()),
                                    Caption2(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text: "روز"),
                                  ],
                                ),
                              ),
                              progressColor: Colors.cyanAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Get.to(UserSecuritySttingMenus());
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Notifications()));
        break;
      case 2:
        Share.share(databox.identifierCode.toString() +
            " \n این عدد کد معرف من در نحوینو می باشد. اگر هنگام ثبت نام از این کد استفاده کنید ده شاهپر به شما اهدا میکنم و راهنمای شما در این مسلک زیبا خواهم بود");

        break;
      case 4:
        Share.share(databox.identifierCode.toString() +
            " \n این عدد کد معرف من در نحوینو می باشد. اگر هنگام ثبت نام از این کد استفاده کنید ده شاهپر به شما اهدا میکنم و راهنمای شما در این مسلک زیبا خواهم بود");

        break;
      case 3:
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.translate(
                'apptitle',
              )!),
              content: Text(AppLocalizations.of(context)!.translate(
                'quExit',
              )!),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(
                      context,
                      AppLocalizations.of(context)!.translate(
                        'Cancel',
                      )!),
                  child: Text(
                    AppLocalizations.of(context)!.translate(
                      'Cancel',
                    )!,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final preferences = await SharedPreferences.getInstance();
                    await preferences.clear();
                    ServiceNotification.deletetokennotificationapi()
                        .then((response) {
                      print(
                          "deletetokenapi---------------------------- => $response");
                    });
                    await DefaultCacheManager().emptyCache();
                    databox.clerdata();
                    _deleteCacheDir();
                    _deleteAppDir();
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      // exit(0);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Registration()),
                        (route) => false,
                      );
                    });
                  },
                  child: Text(AppLocalizations.of(context)!.translate(
                    'OK',
                  )!),
                ),
              ]),
        );
        break;
    }
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationDocumentsDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }
}
