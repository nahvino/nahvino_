import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/features/feature_auth/main/screen/registration.dart';
import 'package:Nahvino/features/feature_auth/register/controllers/register_controller.dart';
import 'package:Nahvino/features/feature_auth/register/screen/register_screen.dart';
import 'package:Nahvino/features/feature_my_tabs/main/screen/tabs.dart';
import 'package:Nahvino/features/feature_profile/view_profile/model/Profile_user_model_response.dart';
import 'package:Nahvino/features/feature_version/service/version_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VersionData extends GetxController {
  RegisterController registerController = Get.put(RegisterController());
  GetStorage box = GetStorage();
  late ServiceVersion serversion;
  double lastVersion = 1.0;
  double? versionResponse;
  SharedPreferences? preferences;
  ProfileUserModelResponse? profileUserModelResponse;

  @override
  void onInit() {
    super.onInit();
    GetStorage.init();
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
      ServiceVersion.getversion().then((response) {
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
    bool showIntro = preferences?.getBool("shouldShowIntro") ?? true;
    String? token = preferences!.getString("token");
    // if(showIntro){
    //   Get.offAll(IntroScreen());
    // }else {
      if (token != null) {
        RegisterController().reRequset();
        if(registerController.profileUserModelResponse?.parentName == null){
              Get.offAll(()=>RegisterScreen());
              registerController.showTextReg.value = false;
              registerController.showAddIntroduced.value = true;
            }else {
              Get.offAll(() => MyTabs());
            }

       // Get.offAll(MyTab());
      } else {
        Get.offAll(()=>Registration());
      }
   // }
  }

  checkVersion() {
    //versionrequest();
    if (versionResponse! <= lastVersion) {
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
                    child: Buttonfull(
                      text: "دانلود",
                      onPressed: () async {
                        _deleteAppDir();
                        var status = await Permission.storage.status;
                        if (status.isDenied) {
                          await Permission.storage.request();
                        }
                        final baseStorage = await getExternalStorageDirectory();
                        final taskId = await FlutterDownloader.enqueue(
                          url: 'https://dl.nahvino.com/app/Nahvino.1.0.0.apk',
                          savedDir: baseStorage!.path,
                          showNotification:
                              true, // show download progress in status bar (for Android)
                          openFileFromNotification:
                              true, // click on notification to open downloaded file (for Android)
                        );
                      },
                    ),
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

  Future<void> _deleteAppDir() async {
    final appDir = await getExternalStorageDirectory();

    if (appDir!.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }
}
