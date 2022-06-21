import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:Nahvino/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../App_localizations.dart';
import 'Pages/Account/login/SignUp.dart';
import 'Utils/Button/Button.dart';
import 'Utils/Text/Text.dart';
import 'controllers/getx/aboutgroupcontroller.dart';
import 'main.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  AboutGroupController notfiController = Get.put(AboutGroupController());
  MyApp mapp = MyApp();
  SharedPreferences? preferences;
  Future checkLogin() async {
    await Future.delayed(Duration(seconds: 3));
    preferences = await SharedPreferences.getInstance();
    String? token = preferences!.getString("token");
    if (token != null) {
      print("<===================>");
      print(notfiController.notfi.value);
      print("<===================>");
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        print('YAY! Free cute dog pics!');
        // Get.snackbar("اتصال اینترنت", "خوبه");
        //Get.snackbar("مقایسه", notfiController.notfi.value.toString());
        if (notfiController.notfi.value == true) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MyTabs(
                        tabIndex: 1,
                      )));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MyTabs(
                        tabIndex: 0,
                      )));
        }
      } else {
        print('No internet :( Reason:');
        Get.defaultDialog(
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

                      /*TextButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: Caption1(
                          color: Colors.cyan,
                          textAlign: TextAlign.center,
                          text: "خروج",
                        ),
                      ),*/
                    ),
                  ],
                ),
              ],
            ));
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignUp()));
      //SignUp()
    }
  }

  Future interchekr() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('YAY! Free cute dog pics!');
      Get.snackbar("اتصال اینترنت", "خوبه");
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

  @override
  void initState() {
    super.initState();
    checkLogin();
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
