import 'package:Nahvino/Data/Local/version_data.dart';
import 'package:Nahvino/Pages/Account/Login/registration.dart';
import 'package:Nahvino/Utils/Button/Button.dart';
import 'package:Nahvino/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_core/signalr_core.dart';

class CheckController extends GetxController {
  VersionData checkversion = Get.put(VersionData());

  SharedPreferences? preferences;

  @override
  void onInit() {
    super.onInit();
    // checkInternetConnection();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // checklogin() async {
  //   //  await Future.delayed(Duration(seconds: 3));
  //   preferences = await SharedPreferences.getInstance();
  //   String? token = preferences!.getString("token");
  //   if (token != null) {
  //     Get.offAll(MyTabs());
  //   } else {
  //     Get.offAll(Registration());
  //   }
  // }

  checkInternetConnection() async {
    print("checkInternetConnection");
    bool result = await InternetConnectionChecker().hasConnection;
    //check if the connection
    if (result == true) {
      // checkversion.checkVersion();
      //  Get.offAll(MyTabs());
      // check token
      checkversion.checklogin();
    } else {
      Get.defaultDialog(
          barrierDismissible: false,
          title: "مشکل در اتصال به اینترنت",
          titleStyle: TextStyle(
              color: Colors.black, fontSize: 16, fontFamily: 'Vazirmatn_Light'),
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
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Splash()));
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
  }
}
