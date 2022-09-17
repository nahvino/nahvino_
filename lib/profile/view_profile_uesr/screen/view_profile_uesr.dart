import 'dart:async';

import 'package:Nahvino/profile/view_profile_uesr/service/visit_user_service.dart';
import 'package:Nahvino/Utils/OtherUtils/imagedialoguser.dart';
import 'package:Nahvino/Utils/Widget/image_view.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/my_tabs/main/screen/tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../Utils/Text/Text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ViewProfileUesr extends StatefulWidget {
  const ViewProfileUesr({Key? key, this.userid}) : super(key: key);
  final userid;

  @override
  State<ViewProfileUesr> createState() => _ViewProfileUesrState();
}

class _ViewProfileUesrState extends State<ViewProfileUesr> {
  bool isApiCallProgress = true;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  var resultResponseViewProfileUesr;

  //late Map<String, dynamic> resultResponseGetLastOtherVisit;
  var resultResponseGetLastOtherVisit;
  var flag;
  var resultResponseGetUserAbandon;
  String? imagePath;
  String tarikh = "تاریخ";
  Imageview img = Imageview();
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
    Lottie.asset('assets/anim/phonix/level1.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level2.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level3.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level4.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level5.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level6.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level7.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level7.json', fit: BoxFit.cover),
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
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave8.png')),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      VisetUserService.GetProfileOtherUser(widget.userid.toString())
          .then((response) {
        resultResponseViewProfileUesr = response;
        if (resultResponseViewProfileUesr == false) {
          Future.delayed(Duration(seconds: 3), () {
            Get.snackbar("خطا", "مشکل در بارگذاری پروفایل",
                snackPosition: SnackPosition.TOP);
            Navigator.pop(context);
          });
        }
        print("test-----------> $resultResponseViewProfileUesr");
       //VisetUserService.flag(widget.userid.toString()).then((value) { flag = value;
        VisetUserService.GetLastOtherVisit(widget.userid.toString())
            .then((response) {
          resultResponseGetLastOtherVisit = response;
          print(" قوقوی---------------------------- => $response");
          VisetUserService.getuserotherabandon(widget.userid.toString())
              .then((response) {
            print("تاریخ ترک ------------- => $response");
            setState(() {
              isApiCallProgress = false;

              resultResponseGetUserAbandon = response;
            });
          });
        });
      });
    //  });
    });
  }

  bool lang = false; // en => true / fa => false
  @override
  Widget build(BuildContext context) {
    if (resultResponseGetUserAbandon != false) {
      date = resultResponseGetUserAbandon['data'].split(" ")[2];
      mont = resultResponseGetUserAbandon['data'].split(" ")[1];
      yaer = resultResponseGetUserAbandon['data'].split(" ")[0];
    }
    day = int.parse(date);
    month = int.parse(mont);
    year = int.parse(yaer);
    if (year == 0 && month == 0 && day <= 21 ){
      flag = true;
    }else{
      flag = false;
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: //body(context)
            SafeArea(
                child: isApiCallProgress
                    ? Center(
                        child: Lottie.asset('assets/anim/loading/loading.json',
                            height: 300, width: 300),
                      )
                    : body(context)),
      ),
    );
  }

  Widget body(BuildContext context) => SingleChildScrollView(
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
                              Subhead(
                                textAlign: TextAlign.right,
                                text:
                                    resultResponseViewProfileUesr['userName'] ??
                                        "",
                                color: Colors.black,
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  height: 30,
                                  child: BackButton(
                                    onPressed: (() {
                                      Navigator.pop(context);

                                    }),
                                  ),
                                ),
                              ),
                            ]),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            (resultResponseViewProfileUesr['imageUrl'] !=
                                        null &&
                                    resultResponseViewProfileUesr['imageUrl'] !=
                                        "")
                                ? InkWell(
                                    child:  img.imageProfile(Img:  resultResponseViewProfileUesr['imageUrl']!, flag: flag),

                                    onTap: () {
                                      showDialog<void>(
                                          context: context,
                                          builder: (context) => ImageDialogUser(
                                              imageUrl:
                                                  resultResponseViewProfileUesr[
                                                      'imageUrl']!));
                                    })
                                : img.imageAssetProfile(flag: flag),
                          ],
                        ),
                        Column(
                          children: [
                            Subhead(
                              text:
                                  resultResponseViewProfileUesr['nameAlias'] ??
                                      "",
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
                                  borderRadius: new BorderRadius.circular(8.0),
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
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.black26, width: 1)),
                                    child: Callout(
                                      text: ranksadad[
                                          resultResponseViewProfileUesr[
                                              'rank']],
                                      color: Colors.purpleAccent,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Callout(
                                    text: ranks[
                                        resultResponseViewProfileUesr['rank']],
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
                              image: AssetImage("assets/images/home/bbarg.png"),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Callout(
                              text: resultResponseViewProfileUesr['score']
                                  .toString(),
                              color: Colors.black,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            (resultResponseViewProfileUesr['parentImageUrl'] !=
                                        null &&
                                    resultResponseViewProfileUesr[
                                            'parentImageUrl'] !=
                                        "")
                                ? Card(
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: CachedNetworkImage(
                                      height: 45,
                                      width: 45,
                                      cacheManager: CacheManager(Config(
                                          'customCacheKey',
                                          stalePeriod: Duration(days: 7),
                                          maxNrOfCacheObjects: 100)),
                                      imageUrl: MainConfig.fileurl +
                                          resultResponseViewProfileUesr[
                                              'parentImageUrl']!,
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
                              text:
                                  resultResponseViewProfileUesr['parentName'] ??
                                      "نحوینو",
                              color: Colors.teal,
                              textAlign: TextAlign.left,
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
                        left: MediaQuery.of(context).size.height * 0.03,
                        bottom: MediaQuery.of(context).size.height * 0.02,
                        top: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Callout(
                        text: resultResponseViewProfileUesr['bio'] ?? "",
                        color: Colors.black,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (resultResponseGetLastOtherVisit['data'] > 7)
                      Expanded(
                        child: Container(
                          height: 150,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: const [
                              BoxShadow(color: Colors.cyan, spreadRadius: 2),
                            ],
                          ),
                          child: Column(
                            children: [
                              Lottie.asset('assets/anim/phonix/level7.json',
                                  fit: BoxFit.cover),
                              Container(
                                  width: 100,
                                  child: Image.asset(
                                      'assets/images/hart/hart-lave8.png')),
                            ],
                          ),
                        ),
                      ),
                    if (resultResponseGetLastOtherVisit['data'] < 7)
                      Expanded(
                        child: Container(
                          height: 150,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: const [
                              BoxShadow(color: Colors.cyan, spreadRadius: 2),
                            ],
                          ),
                          child: Column(
                            children: [
                              ghoghnos[resultResponseGetLastOtherVisit['data']],
                              hart[resultResponseGetLastOtherVisit['data']]
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 9,
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: const [
                          BoxShadow(color: Colors.cyan, spreadRadius: 2),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            Footnate(
                              textAlign: TextAlign.center,
                              color: Colors.cyan,
                              text: "مدت پاکی:",
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Footnate(
                                      textAlign: TextAlign.center,
                                      color: Colors.cyan,
                                      text: resultResponseGetUserAbandon['data']
                                          .split(" ")[0]
                                          .toString(),
                                    ),
                                    Caption2(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text: "سال"),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    Footnate(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text:
                                            resultResponseGetUserAbandon['data']
                                                .toString()
                                                .split(" ")[1]
                                                .toString()),
                                    Caption2(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text: "ماه"),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    Footnate(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text:
                                            resultResponseGetUserAbandon['data']
                                                .toString()
                                                .split(" ")[2]
                                                .toString()),
                                    Caption2(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text: "روز"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
