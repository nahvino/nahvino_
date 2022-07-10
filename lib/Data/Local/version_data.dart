import 'package:Nahvino/Services/version/version_service.dart';
import 'package:Nahvino/Utils/Button/Button.dart';
import 'package:Nahvino/splash.dart';
import 'package:Nahvino/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VersionData extends GetxController {
  late ServiceVersion serversion;
  String lastVersion = "2";
  bool? versionResponse;

  @override
  void onInit() {
    super.onInit();
    GetStorage.init();
    checkVersion();
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

  checkVersion() {
    versionrequest();
    if (versionResponse == true) {
      Get.defaultDialog(
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
                      text: "تلاش مجدد",
                      onPressed: () {
                        Get.offAll(Splash());
                      },
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
    } else if (versionResponse == false) {
      Get.offAll(MyTabs(
        tabIndex: 0,
      ));
    }
  }

  versionrequest() {
    Future.microtask(() {
      ServiceVersion.getversion(lastVersion).then((response) {
        print("------------Version-------------- => $response");
        versionResponse = response;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
    update();
  }
}
