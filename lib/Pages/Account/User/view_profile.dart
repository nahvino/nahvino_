import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:nahvino/Pages/Account/User/edit_profile.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../../Model/user/user/viewprofile_response_model.dart';
import '../../../Services/login/api_service.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Widget/profile_image.dart';
import '../../../app_localizations.dart';
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

  // String? data;
  // String? userid;
  // String? userName;
  // String? nameAlias;
  // String? bio;
  // String? imageFile;
  // int? identifierCode;
  // int? rank;
  // int? score;
  var resultResponse;
  var resultResponsee;

  @override
  void initState() {
    super.initState();

    //debugPrint("-----------------");
    APIService.getprofileuser().then((response) {
      setState(() {
        isApiCallProgress = false;
        resultResponse = response;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
/*
    APIService.GetUserAbandon().then((response) {
      setState(() {
        isApiCallProgress = false;
        resultResponsee = response;
      });
    });*/

    APIService.GetLastVisit().then((response) {
      setState(() {
        isApiCallProgress = false;
        resultResponsee = response;
      });
    });
  }

  bool lang = false; // en => true / fa => false
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        /*
        appBar: AppBar(title: Text(""),
        actions: [
          PopupMenuButton(itemBuilder: (context)=>[
            PopupMenuItem<int>(
                value: 0,
                child: Text("تنظیمات امنیتی")),
          ]),
        ],),*/
        backgroundColor: Colors.grey[200],
        body: SafeArea(
            child: isApiCallProgress
                ? Center(
                    child: Lottie.asset('assets/anim/data.json',
                        height: 300, width: 300),
                  )
                : body(context)),
      ),
    );
  }

  // ViewProfileUI(BuildContext context) {
  //   return Stack(
  //     children: [
  //       Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Container(
  //                 height: 49,
  //                 alignment: Alignment.topLeft,
  //                 child: PopupMenuButton<int>(
  //                   itemBuilder: (context) => [
  //                     PopupMenuItem(
  //                       value: 0,
  //                       child: Row(
  //                         mainAxisSize: MainAxisSize.max,
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         children: [
  //                           Text(
  //                             "تنظیمات امنیتی",
  //                             textAlign: TextAlign.right,
  //                           ),
  //                           const SizedBox(
  //                             width: 7,
  //                           ),
  //                           Icon(
  //                             Icons.security,
  //                             color: Colors.cyan,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     PopupMenuDivider(),
  //                     PopupMenuItem(
  //                       value: 1,
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         children: [
  //                           Text(
  //                             "اعلان ها",
  //                             textAlign: TextAlign.right,
  //                           ),
  //                           const SizedBox(
  //                             width: 7,
  //                           ),
  //                           Icon(
  //                             Icons.notifications,
  //                             color: Colors.cyan,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     PopupMenuDivider(),
  //                     PopupMenuDivider(),
  //                     PopupMenuItem(
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         children: [
  //                           Text(
  //                             "کد شما جهت معرفی عضو جدید",
  //                             textAlign: TextAlign.center,
  //                           ),
  //                           const SizedBox(
  //                             width: 7,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     PopupMenuItem(
  //                       value: 2,
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Icon(
  //                             Icons.share,
  //                             color: Colors.cyan,
  //                           ),
  //                           SizedBox(
  //                             width: 8,
  //                           ),
  //                           Text(
  //                             "54586",
  //                             textAlign: TextAlign.center,
  //                           ),
  //                           const SizedBox(
  //                             width: 7,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                   onSelected: (item) => onSelected(context, item),
  //                 ),
  //
  //                 /*IconButton(
  //              icon: Icon(Icons.menu_sharp),
  //              onPressed: (){
  //              },*/
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Container(
  //             padding: EdgeInsets.only(top: 10, right: 5),
  //             height: 100,
  //             alignment: Alignment.topRight,
  //             child: ProfileImage(),
  //           ),
  //         ],
  //       ),
  //       Column(
  //         children: [
  //           Padding(
  //               padding: EdgeInsets.only(
  //                 left: MediaQuery.of(context).size.height * 0.32,
  //               ),
  //               child: isApiCallProgress
  //                   ? Text("${resultResponse['nameAlias']}")
  //                   : CircularProgressIndicator()
  //             //Text("${resultResponse['userName']}"),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(
  //                 left: MediaQuery.of(context).size.height * 0.32),
  //             child: SizedBox(
  //                 height: 30,
  //                 width: 50,
  //                 child: Image.asset('assets/images/nahvino_logo.png')),
  //           ),
  //         ],
  //       ),
  //       Container(
  //         padding: EdgeInsets.only(top: 115, right: 15),
  //         alignment: Alignment.topRight,
  //         child: Text("محل قرار گیری بیو"),
  //       ),
  //       Container(
  //         padding: EdgeInsets.only(top: 150),
  //         child: Buttonfull(
  //             text: "ویرایش پروفایل",
  //             onPressed: () {
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => EditProfile()));
  //             }),
  //       ),
  //       Container(
  //           alignment: Alignment.center,
  //           padding: EdgeInsets.only(
  //             top: MediaQuery.of(context).size.height * 0.15,
  //           ),
  //           child: Lottie.asset('assets/anim/data.json')),
  //       Container(
  //         padding: EdgeInsets.only(
  //           top: MediaQuery.of(context).size.height * 0.79,
  //         ),
  //         child: Buttonfull(
  //             text: "تاریخ آغاز ترک خود را وراد کنید",
  //             onPressed: () {
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => EditProfile()));
  //             }),
  //       ),
  //     ],
  //   );
  // }

  Widget body(BuildContext context) => Column(
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 49,
                            alignment: Alignment.topLeft,
                            child: PopupMenuButton<int>(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 0,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "تنظیمات امنیتی",
                                        textAlign: TextAlign.right,
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Icon(
                                        Icons.security,
                                        color: Colors.cyan,
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuDivider(),
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "اعلان ها",
                                        textAlign: TextAlign.right,
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Icon(
                                        Icons.notifications,
                                        color: Colors.cyan,
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuDivider(),
                                PopupMenuItem(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "کد شما جهت معرفی عضو جدید",
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.share,
                                        color: Colors.cyan,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        resultResponse['identifierCode'].toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                    ],
                                  ),
                                ),
                              ],onSelected: (item) => onSelected(context, item),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.redAccent),
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Text(resultResponse['userName']),
                          Text(resultResponse['nameAlias']),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [Icon(Icons.send), Text("10")],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [Icon(Icons.person), Text("arshad")],
                      ),
                    ],
                  ),
                  Text(resultResponse['bio']),
                  Buttonfull(
                      text: "Edit Profile",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()));
                      })
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
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.0,
                    ),
                    child: Lottie.asset('assets/anim/data.json'),
                  ),
                  Buttonfull(
                      text: AppLocalizations.of(context)!
                          .translate('Date_of_departure')!,
                      onPressed: () {})
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
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.0,
                    ),
                    child: Text(resultResponsee["data"].toString()),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UserSecuritySttingMenus(
                  )));
        break;
      case 1:Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Notifications(
                  )));
      break;
    }
  }
}
