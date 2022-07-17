import 'package:Nahvino/Pages/Account/Login/registration.dart';
import 'package:Nahvino/Services/version/version_service.dart';
import 'package:Nahvino/Utils/Button/Button.dart';
import 'package:Nahvino/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionData extends GetxController {
  late ServiceVersion serversion;
  String lastVersion = "1";
  bool? versionResponse;
  SharedPreferences? preferences;

  @override
  void onInit() {
    super.onInit();
    GetStorage.init();
    // versionrequest();
    //checkVersion();
    //checkVersioEixt();
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

  versionrequest() {
    Future.microtask(() {
      ServiceVersion.getversion(lastVersion).then((response) {
        print("------------Version-------------- => $response");
        versionResponse = response;
        checkVersion();
      });
    }).onError((error, stackTrace) {
      print(error);
    });
    update();
  }

  checklogin() async {
    //  await Future.delayed(Duration(seconds: 3));
    preferences = await SharedPreferences.getInstance();
    String? token = preferences!.getString("token");
    if (token != null) {
      Get.offAll(MyTabs());
    } else {
      Get.offAll(Registration());
    }
  }

  checkVersion() {
    //versionrequest();
    if (versionResponse == false) {
      // Get.offAll(MyTabs());
      checklogin();
    } else {
      Get.defaultDialog(
          barrierDismissible: false,
          title: "به روز رسانی نحوینو",
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
                      text: "دانلود",
                      onPressed: _launchUrl,
                    ),
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

  checkVersioEixt() {
    if (versionResponse == false) {
      Get.offAll(Registration());
    } else {
      Get.defaultDialog(
          barrierDismissible: false,
          title: "به روز رسانی نحوینو",
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
                      text: "دانلود",
                      onPressed: _launchUrl,
                    ),
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

  final Uri _url = Uri.parse('https://dl.nahvino.com/app/v1/Nahvino.1.2.1.apk');

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }
}
