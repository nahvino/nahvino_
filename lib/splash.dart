import 'package:Nahvino/controllers/getx/Utils/check_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../App_localizations.dart';
import 'Utils/Text/Text.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  CheckController checkcontroller = Get.put(CheckController());
/*
  Future checkLogin() async {
    await Future.delayed(Duration(seconds: 3));
    preferences = await SharedPreferences.getInstance();
    String? token = preferences!.getString("token");
    if (token != null) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        //checkversion.checkVersion();
        Get.offAll(MyTabs());
      } else {
        Get.defaultDialog(
            barrierDismissible: false,
            title: "مشکل در اتصال به اینترنت",
            titleStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Vazirmatn_Light'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      child: Buttontest(
                        text: "تلاش مجدد",
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Splash()));
                        },
                      ),

                      /*TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Splash()));
                        },
                        child: Caption1(
                          color: Colors.cyan,
                          textAlign: TextAlign.center,
                          text: "تلاش مجدد",
                        ),
                      ),*/
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 120,
                      child: Buttontest(
                        text: "خروج",
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ));
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Registration()));
    //  Get.offAll(SignUp);
    }
  }
*/
/*
  Future interchekr() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('YAY! Free cute dog pics!');
  //  Get.snackbar("اتصال اینترنت", "خوبه");
    } else {
      print('No internet :( Reason:');
      Get.defaultDialog(
          title: "مشکل در اتصال",
          content: Row(
            children: [
              ButtonSignUP(
                text: "تلاش مجدد",
                onPressed: () {
                  interchekr();
                },
                icon: Icon(
                  Icons.phone_android_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              ButtonSignUP(
                text: "خروج",
                onPressed: () {
                  SystemNavigator.pop();
                },
                icon: Icon(
                  Icons.phone_android_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ));
//  print(InternetConnectionChecker().lastTryResults);
    }
  }
*/
  @override
  void initState() {
    super.initState();
    //checkLogin();
    checkcontroller.checkInternetConnection();
    // apiService = APIService(context);
    // Future.microtask(() {
    //   APIService.GetLastVisit().then((response) {
    //     print(" قوقوی---------------------------- => $response");
    //   });
    // }).onError((error, stackTrace) {
    //   print(error);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(child: Lottie.asset('assets/splash/animtiopsh.json')),
              Container(
                  child: textbold(
                color: Colors.black,
                textAlign: TextAlign.center,
                text: AppLocalizations.of(context)!.translate(
                  'TextSplashn',
                )!,
              )),
              Column(
                children: [
                  textspan(
                    color: Colors.black,
                    textAlign: TextAlign.center,
                    text: AppLocalizations.of(context)!.translate(
                      'TextSplash',
                    )!,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
