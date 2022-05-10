import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:Nahvino/Services/login/user/Config.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/user/user/viewprofile_response_model.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Utils/Text/Text.dart';
import '../../../App_localizations.dart';
import '../Caht/chatpage.dart';
import '../Login/SignUp.dart';
import 'Notifications.dart';
import 'UserSecuritySttingMenus.dart';

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
      APIService.GetProfileOtherUser(widget.userid.toString()).then((response)  {
        //resultResponseViewProfileUesr = response;
        setState(() {
          isApiCallProgress = false;
          resultResponseViewProfileUesr = response;
        });
        print("test------------------------------------> $resultResponseViewProfileUesr");
      });
/*
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
      }*/
    });
  }

  bool lang = false; // en => true / fa => false
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: //body(context)
          SafeArea(
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Directionality(
                              textDirection:  TextDirection.ltr,
                              child: Container(
                                alignment: Alignment.topLeft,
                                height: 30,
                                child: BackButton(
                                  onPressed: (() {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => Chatpage()));
                                  }),
                              ),
  ),
                            ),
                      ]  ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.16,
                            ),
                          ),
                          Column(children: [
                            textbold(
                              textAlign: TextAlign.right,
                              text: resultResponseViewProfileUesr['userName'],
                              color: Colors.black,
                            ),
                            (resultResponseViewProfileUesr['imageUrl']!= null &&
                                resultResponseViewProfileUesr['imageUrl'] != "")
                              ? Card(
                            shape: CircleBorder(),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.network(
                              Config.fileurl + resultResponseViewProfileUesr['imageUrl']!,
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
                              height: 75,
                              width: 75,
                            ),
                          )
                              : Image.asset(
                            'assets/images/home/user.png',
                            fit: BoxFit.cover,
                            height: 75,
                            width: 75,
                          ),],),

                          SizedBox(
                            width: 1,
                          ),
                          Column(
                            children: [
                              textbold(
                                text: resultResponseViewProfileUesr['nameAlias'],
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
                                        text: ranksadad[resultResponseViewProfileUesr['rank']],
                                        color: Colors.purpleAccent,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    textspan(
                                      text: ranks[resultResponseViewProfileUesr['rank']],
                                      color: Colors.black,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Column(
                            children: [
                              Image(
                                height: 30,
                                image: AssetImage(
                                    "assets/images/home/bbarg.png"),
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
                                height: 5,
                              ),
                              textspan(
                                text: resultResponseViewProfileUesr['score'].toString(),
                                color: Colors.black,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
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
                              (resultResponseViewProfileUesr['parentImageUrl'] != null &&
                                  resultResponseViewProfileUesr['parentImageUrl'] != "")
                                  ? Card(
                                shape: CircleBorder(),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.network(
                                  Config.fileurl + resultResponseViewProfileUesr['parentImageUrl']!,
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
                                  height: 30,
                                  width: 30,
                                ),
                              )
                                  : Image.asset(
                                'assets/images/home/user.png',
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30,
                              ),
                              /*    InkWell(
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
                              ),*/
                              SizedBox(
                                height: 4,
                              ),
                              textspan(
                                text:  resultResponseViewProfileUesr['parentName'],
                                color: Colors.black,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ],
                      ),
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
                        text: resultResponseViewProfileUesr['bio'],
                        color: Colors.black,
                        textAlign: TextAlign.start,
                      ),
                    ),
                                      ],
                ),
              ),
            ),

           /* Card(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: const [
                          BoxShadow(color: Colors.black, spreadRadius: 2),
                        ],
                      ),
                      child: Text(""),
                      //ranksadadA[resultResponsee['data']],
                    ),
                    SizedBox(width: 9,),
                    Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: const [
                          BoxShadow(color: Colors.black, spreadRadius: 2),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(children: [
                          Body(
                            textAlign: TextAlign.center,
                            color: Colors.cyan,
                            text: "تاریخ آغاز ترک",),
                          Body(
                            textAlign: TextAlign.center,
                            color: Colors.cyan,
                            text: "" /*resultResponseea['userName']*/,),
                        ],),
                      ),
                    ),

                  ],
                ),
              ),
            ),*/
         /*   Body(
                textAlign: TextAlign.center,
                color: Colors.cyan,
                text: widget.userid.toString()),*/
          ],
        ),
      );


}
