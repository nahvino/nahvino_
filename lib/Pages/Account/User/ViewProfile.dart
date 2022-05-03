import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lottie/lottie.dart';
import 'package:nahvino/Pages/Account/User/EditProfile.dart';
import 'package:nahvino/Services/login/user/Config.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/user/user/viewprofile_response_model.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Other/ArshadDialog.dart';
import '../../../Utils/Other/BargDialog.dart';
import '../../../Utils/Widget/Text.dart';
import '../../../App_localizations.dart';
import '../../../tabs.dart';
import 'Notifications.dart';
import 'UserSecuritySttingMenus.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  bool isApiCallProgress = true;


  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  GetProfileUserResponseModel? resultResponse;
  var resultResponsee;
  var resultResponseGetUserAbandon;
  late APIService apiService;
  String? imagePath;
  String tarikh = "تاریخ";
  String date = "1408/10/12 20:12:00";

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
    Lottie.asset('assets/anim/phonix.json'),
    Lottie.asset('assets/anim/phonix-die.json'),
  ];

  @override
  void initState() {
    super.initState();
    apiService = APIService(context);
    Future.microtask(() {
      APIService.getprofileuser().then((response) {
        print("APIService.getprofileuser => $response");
        resultResponse = response;
        APIService.GetLastVisit().then((response) {
          print("APIService.GetLastVisit => $response");
          setState(() {
            isApiCallProgress = false;
            resultResponsee = response;
          });
        });
      }).onError((error, stackTrace) {
        print(error);
      });
    });

    APIService.getuserabandon().then((response) {
      print("APIService.getuserabandon => $response");
      if (response != null) {
        resultResponseGetUserAbandon = response ?? tarikh;
      } else {
        setState(() {
          isApiCallProgress = false;
          resultResponseGetUserAbandon = response;
        });
      }
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
              child: Lottie.asset('assets/anim/phonix_storok.json',
                  height: 300, width: 300),
            )
                : body(context)),
      ),
    );
  }

  Widget body(BuildContext context) =>
      SingleChildScrollView(
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
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.03),
                              child: textbold(
                                textAlign: TextAlign.right,
                                text: resultResponse!.userName ?? "Guest",
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              height: 30,
                              child: PopupMenuButton<int>(
                                icon: Icon(Icons.menu),
                                itemBuilder: (context) =>
                                [
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
                                  PopupMenuDivider(height: 4),
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
                                  ),
                                  PopupMenuDivider(height: 1),
                                  PopupMenuItem(
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
                                          text: resultResponse!.identifierCode
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
                                onSelected: (item) => onSelected(context, item),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.16,
                          ),
                        ),
                        (resultResponse!.imageUrl != null &&
                            resultResponse!.imageUrl != "")
                            ? Card(
                          shape: CircleBorder(),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.network(
                            Config.fileurl + resultResponse!.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception,
                                StackTrace? stackTrace) {
                              return const Icon(Icons.person);
                            },
                            loadingBuilder: (BuildContext context,
                                Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
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
                            height: 100,
                            width: 100,
                          ),
                        )
                            : Image.asset(
                          'assets/images/home/user.png',
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            textbold(
                              text: resultResponse!.nameAlias ?? "Guest",
                              color: Colors.green,
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
                                    child: textspan(
                                      text: ranksadad[resultResponse!.rank!],
                                      color: Colors.purpleAccent,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  textspan(
                                    text: ranks[resultResponse!.rank!],
                                    color: Colors.black,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
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
                                }),
                            SizedBox(
                              height: 4,
                            ),
                            textspan(
                              text: resultResponse!.score.toString(),
                              color: Colors.black,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {

                                showDialog<void>(
                                    context: context,
                                    builder: (context) => ArshadDialog());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black12),
                                height: 30,
                                width: 30,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/ram/man1.jpg")),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            textspan(
                              text: "ارشد",
                              color: Colors.black,
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
                        right: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03,
                        bottom: MediaQuery
                            .of(context)
                            .size
                            .height * 0.02,
                        top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.01,
                      ),
                      child: textspan(
                        text: resultResponse!.bio ?? "empty bio",
                        color: Colors.black,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Buttonfull(
                      text: AppLocalizations.of(context)!.translate(
                        'Edit Profile',
                      )!,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditProfile(model: resultResponse!)));
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
                    Body(textAlign: TextAlign.center,
                      color: Colors.cyan,
                      text: resultResponseGetUserAbandon['data'] ?? tarikh,),
                    Buttonfull(
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
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      );

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
      /* Share.share('اشتراک گذاری کد معرف', subject: resultResponse!.identifierCode
            .toString() );*/
        Share.share(resultResponse!.identifierCode.toString());

        break;
      case 3:
        showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                  title: Text(AppLocalizations.of(context)!.translate(
                    'apptitle',
                  )!),
                  content: Text(AppLocalizations.of(context)!.translate(
                    'quExit',
                  )!),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(
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
                        final preferences = await SharedPreferences
                            .getInstance();
                        await preferences.clear();
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          exit(0);
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
}
