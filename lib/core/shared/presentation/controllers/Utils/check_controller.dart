import 'dart:async';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/features/feature_intro/screen/splash.dart';
import 'package:Nahvino/features/feature_version/data/version_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckController extends GetxController {
  VersionData checkversion = Get.put(VersionData());
  SharedPreferences? preferences;
  late StreamSubscription interfaceSubscription;
  late StreamSubscription subscription;
  @override
  void onInit() {
    super.onInit();
  //  intwoek();
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
   // subscription.cancel();
 //   interfaceSubscription.cancel();
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
  intwoek() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      //result = result;
    });
    interfaceSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        inter();
      } else if (status == InternetConnectionStatus.connected) {
        Get.offAll(()=>Splash());
      }
    });
  }

  checkInternetConnection() async {
    print(
        "************************------checkInternetConnection--------------********");
    bool result = await InternetConnectionChecker().hasConnection;
    //check if the connection
    if (result == true) {
      // check token
      checkversion.versionrequest();
      // checkversion.checklogin();
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
                    child: Buttonfull(
                      text: "تلاش مجدد",
                      onPressed: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Splash()));
                        Get.offAll(()=>Splash());
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
                    child: Buttonfull(
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

  checkchatInternetConnection() async {
    print(
        " ************************------checkchatInternetConnection--------------********");
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
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
                    child: Buttonfull(
                      text: "تلاش مجدد",
                      onPressed: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Splash()));
                        Get.offAll(()=>Splash());
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
                    child: Buttonfull(
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
    } else if (connectivityResult == ConnectivityResult.wifi) {
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
                    child: Buttonfull(
                      text: "تلاش مجدد",
                      onPressed: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Splash()));
                        Get.offAll(()=>Splash());
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
                    child: Buttonfull(
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

  inter() {
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
                  child: Buttonfull(
                    text: "تلاش مجدد",
                    onPressed: () {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Splash()));
                      Get.offAll(()=>Splash());
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
                  child: Buttonfull(
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
