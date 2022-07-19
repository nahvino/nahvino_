import 'package:Nahvino/Pages/Account/User/edit_profile_screen.dart';
import 'package:Nahvino/Services/Login/Google/notification_service.dart';
import 'package:Nahvino/Services/Users/User/service_profile.dart';
import 'package:Nahvino/Utils/OtherUtils/imagedialog.dart';
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
import '../../../Model/user/user/viewprofile_response_model.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Services/config.dart';
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
  //CheckController checkcontroller = Get.find<CheckController>();
  GetProfileUserResponseModel? resultResponse;
  late Map<String, dynamic> resultResponsee;
  // late int resultResponsee;
  var resultResponseGetUserAbandon;
  late APIService apiService;
  late ServiceProfile testtarkh;
  String? imagePath;
  late int day;
  late int month;
  late int year;
  // GetStorage box = GetStorage();
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
  List<Widget> ranksadadA = <Widget>[
    Lottie.asset('assets/anim/phonix/level1.json'),
    Lottie.asset('assets/anim/phonix/level2.json'),
    Lottie.asset('assets/anim/phonix/level3.json'),
    Lottie.asset('assets/anim/phonix/level4.json'),
    Lottie.asset('assets/anim/phonix/level5.json'),
    Lottie.asset('assets/anim/phonix/level6.json'),
    Lottie.asset('assets/anim/phonix/level7.json'),
    Lottie.asset('assets/anim/phonix/level8.json'),
    Lottie.asset('assets/anim/phonix/level8.json'),
  ];

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
    apiService = APIService(context);
    /*Future.microtask(() {
      databox.checkdata();
      APIService.getprofileuser().then((response) {
        // print("getprofileuser-------------------------- => $response");
        resultResponse = response;
        APIService.GetLastVisit().then((response) {
          resultResponsee = response;
          print(" قوقوی---------------------------- => $response");
          APIService.getuserabandon().then((response) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (prefs.getBool("switchState") == false ||
                prefs.getBool("switchState") == null) {
              APIService.notificationaApi().then((response) {
                print(
                    "Notfiiiiiiiiiiiiiiiii---------------------------- => $response");
              });
            }
            print("تاریخ ترک ------------- => $response");
            setState(() {
              isApiCallProgress = false;
              resultResponseGetUserAbandon = response;
            });
          });
        });
      }).onError((error, stackTrace) {
        print(error);
      });
    });*/
    databox.checkdata();
    Future.microtask(() {
      APIService.GetLastVisit().then((response) {
        resultResponsee = response;
        print(" -------------<GetLastVisit>-------------- => $response");
        APIService.getuserabandon().then((response) async {
          print("------<getuserabandon>------- => $response");
          setState(() {
            isApiCallProgress = false;
            resultResponseGetUserAbandon = response;
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (prefs.getBool("switchState") == false ||
              prefs.getBool("switchState") == null) {
            ServiceNotification.notificationaApi().then((response) {
              print(
                  "--------------<notificationaApi>-------------- => $response");
            });
          }
        });
      });
      ServiceProfile.getuserotherabandon().then((response) async {
        print("برگشتی تاریخ ترک ------------- => $response");
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
              child:
                  isApiCallProgress /*&& resultResponse == null &&  resultResponsee == null && resultResponseGetUserAbandon == null*/
                      ? Center(
                          child: Lottie.asset(
                              'assets/anim/loading/loading.json',
                              height: 300,
                              width: 300),
                        )
                      : body(context))),
    );
  }

  Widget body(BuildContext context) {
    String date = resultResponseGetUserAbandon['data'].split(" ")[2];
    String mont = resultResponseGetUserAbandon['data'].split(" ")[1];
    String yaer = resultResponseGetUserAbandon['data'].split(" ")[0];
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
                                child: textbold(
                                  textAlign: TextAlign.right,
                                  text: databox.username
                                      .value /*resultResponse?.userName ?? "مهمان"*/,
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
                                          textspan(
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
                                        textspan(
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
                                          textspan(
                                            textAlign: TextAlign.center,
                                            text: databox.identifierCode.value
                                                .toString()
                                            /*resultResponse!.identifierCode
                                            .toString()*/
                                            ,
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
                                          textspan(
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
                              ? Image.asset(
                                  'assets/images/home/user.png',
                                  fit: BoxFit.cover,
                                  height: 75,
                                  width: 75,
                                )
                              : InkWell(
                                  child: Card(
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: CachedNetworkImage(
                                      height: 75,
                                      width: 75,
                                      cacheManager: CacheManager(Config(
                                          'customCacheKey',
                                          stalePeriod: Duration(days: 7),
                                          maxNrOfCacheObjects: 100)),
                                      imageUrl: Configss.fileurl +
                                          databox.imageUrl
                                              .value /*resultResponse!.imageUrl!*/,
                                      imageBuilder: (context, imageProvider) =>
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
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  onTap: () {
                                    showDialog<void>(
                                        context: context,
                                        builder: (context) => ImageDialog());
                                  }),
                          Column(
                            children: [
                              databox.namealias.value == "null" ||
                                      databox.namealias.value == ""
                                  ? textspan(
                                      text: "مهمان",
                                      color: Colors.black38,
                                      textAlign: TextAlign.start,
                                    )
                                  : textbold(
                                      text: databox.namealias
                                          .value /*resultResponse!.nameAlias ?? ""*/,
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
                                      child: textspan(
                                        text: ranksadad[databox.rank
                                            .value] /*ranksadad[resultResponse!.rank ?? 0]*/,
                                        color: Colors.purpleAccent,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    textspan(
                                      text: ranks[databox.rank
                                          .value] /*ranks[resultResponse!.rank!]*/,
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
                              textspan(
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
                                                imageUrl: Configss.fileurl +
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
                                      textspan(
                                        text: databox.parentname
                                            .value /*resultResponse!.parentName!*/,
                                        color: Colors.teal,
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  )
                                  /*Card(
                              shape: CircleBorder(),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.network(
                                Configss.fileurl +
                                    resultResponse!.parentImageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception,
                                    StackTrace? stackTrace) {
                                  return const Icon(Icons.person);
                                },
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null)
                                    return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                          .expectedTotalBytes !=
                                          null
                                          ? loadingProgress
                                          .cumulativeBytesLoaded /
                                          loadingProgress
                                              .expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                                height: 30,
                                width: 30,
                              ),
                            )
                                : Image.asset(
                              'assets/images/home/user.png',
                              fit: BoxFit.cover,
                              height: 30,
                              width: 30,
                            ),*/
                                  ),
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
                            bottom: MediaQuery.of(context).size.height * 0.02,
                            top: MediaQuery.of(context).size.height * 0.01,
                          ),
                          child: /*resultResponse!.bio == null ||
                              resultResponse!.bio == ""*/
                              databox.bio.value == "null" ||
                                      databox.bio.value == ""
                                  ? textspan(
                                      text: "بیو گرافی شما",
                                      color: Colors.black38,
                                      textAlign: TextAlign.start,
                                    )
                                  : textspan(
                                      text: databox.bio
                                          .value /*esultResponse!.bio.toString()*/,
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
                        onPressed: () {
                          //Get.to(EditProfileScreen());
                          // GetPage(name: name, page: EditProfileScreen());
                          // // Get.off(EditProfileScreen());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfileScreen()));
                          //             Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          //     builder: (context) => EditProfile(
                          //           model: resultResponse!,
                          //         )));
                        },
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
                      Container(
                        alignment: Alignment.center,
                        child: ranksadadA[resultResponsee['data']],
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

                                      /*resultResponseGetUserAbandon['data']
                                      .split(" ")[0]
                                      .toString(),*/
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

                                    /*resultResponseGetUserAbandon['data']
                                        .toString()
                                        .split(" ")[1]
                                        .toString())*/
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
                                        text: day.toString()
                                        /*resultResponseGetUserAbandon['data']
                                          .toString()
                                          .split(" ")[2]
                                          .toString()*/
                                        ),
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

                          /*Body(
                      textAlign: TextAlign.center,
                      color: Colors.cyan,
                      text: resultResponseGetUserAbandon['data'].toString().split(" ")[1]  ,
                    ),
                    Body(
                      textAlign: TextAlign.center,
                      color: Colors.cyan,
                      text: resultResponseGetUserAbandon['data'].toString().split(" ")[2]  ,
                    ),*/
                        ],
                      ),

                      /* Body(
                      textAlign: TextAlign.center,
                      color: Colors.black87,
                      text: "هدف بعدی شما پر کردن سه ماه است",
                    ),*/
                      /*  Buttonfull(text: 'تستی', color: Colors.white, onPressed: () {  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewProfileUesr())); },),*/
                      /*   Buttonfull(
                      text: AppLocalizations.of(context)!
                          .translate('Date_of_departure')!,
                      onPressed: () async {
                        Jalali? picked = await showPersianDatePicker(
                          context: context,
                          initialDate: Jalali.now(),
                          firstDate: Jalali(1320, 1),
                          lastDate: Jalali(1450, 1),

                        );
                        print(picked!.formatCompactDate());
                        /*var time = await showPersianTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );*/
                        final berlinWallFell = picked.formatCompactDate();
                        //berlinWallFell.toUtc();
                        //print(berlinWallFell.toString());
                        //print(time.toString());
                        //String formattedDate = time.toString()+berlinWallFell.toString();

                        // final output = time.replaceAll(RegExp('[^0-9]'));
                        // setState(() {
                        //   time = output as TimeOfDay?;
                        // });
                        // print(output.toString());

                        // String formattedDate =intl.DateFormat.yMMMd().format(time) as TimeOfDay; +berlinWallFell;
                        //print(formattedDate);    // apiService.AddOrEditUserAbandon()
                        apiService.AddOrEditUserAbandon(berlinWallFell)
                            .then((response) async {
                          setState(() {
                            isApiCallProgress = false;
                          });
                          if (response != false) {
                            apiService.showSnackBar(
                                text: response['message']);
                            setState(() {
                              isApiCallProgress = false;
                              Get.offAll(MyTabs());
                            });
                          } else {
                            apiService.showSnackBar(
                                text: response['message']);
                          }
                        });

                      },
                      color: Colors.white,
                    ),*/
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserSecuritySttingMenus()));
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
                    await DefaultCacheManager().emptyCache();
                    databox.clerdata();
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
