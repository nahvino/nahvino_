import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/Chat/service/notification_service.dart';
import 'package:Nahvino/features/profile/view_profile/controllers/profile_controller.dart';
import 'package:Nahvino/features/profile/view_profile/data/view_profial_data.dart';
import 'package:Nahvino/features/registration/main/screen/registration.dart';
import 'package:Nahvino/features/settings/menu/screen/user_security_stting_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopUpMenuProfile extends StatelessWidget {
  PopUpMenuProfile({Key? key}) : super(key: key);
  ViewProfileController databox = Get.put(ViewProfileController());
  ProfileController profile_Controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.more_vert_rounded),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.security,
                color: Colors.cyan,
              ),
              const SizedBox(
                width: 7,
              ),
              Callout(
                textAlign: TextAlign.end,
                text: AppLocalizations.of(context)!.translate(
                  'Security_settings',
                )!,
                color: Colors.black,
              ),
            ],
          ),
        ),
        PopupMenuDivider(height: 1),
        PopupMenuItem(
          value: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Caption1(
                textAlign: TextAlign.center,
                color: Colors.black,
                text: AppLocalizations.of(context)!.translate(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.share,
                color: Colors.cyan,
              ),
              SizedBox(
                width: 8,
              ),
              Callout(
                textAlign: TextAlign.center,
                text: databox.identifierCode.value.toString(),
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
          value: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Caption1(
                textAlign: TextAlign.center,
                text: "راهنما ی بخش های مختلف نحوینو",
                color: Colors.black,
              ),
            ],
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/icon/pngwing.com.png',
                  height: 24, width: 24, color: Colors.cyan),
              SizedBox(
                width: 8,
              ),
              Callout(
                textAlign: TextAlign.center,
                color: Colors.black,
                text: AppLocalizations.of(context)!.translate(
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
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Get.to(UserSecuritySttingMenus());
        break;
      case 1:
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Notifications()));
        break;
      case 2:
        Share.share(databox.identifierCode.toString() +
            " \n این عدد کد معرف من در نحوینو می باشد. اگر هنگام ثبت نام از این کد استفاده کنید ده شاهپر به شما اهدا میکنم و راهنمای شما در این مسلک زیبا خواهم بود");

        break;
      case 5:
        profile_Controller.help_vizi();
        break;
      case 4:
        Share.share(databox.identifierCode.toString() +
            " \n این عدد کد معرف من در نحوینو می باشد. اگر هنگام ثبت نام از این کد استفاده کنید ده شاهپر به شما اهدا میکنم و راهنمای شما در این مسلک زیبا خواهم بود");

        break;
      case 3:
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.translate(
                'apptitle',
              )!),
              content: Text(AppLocalizations.of(context)!.translate(
                'quExit',
              )!),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(
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
                    final preferences = await SharedPreferences.getInstance();
                    await preferences.clear();
                    ServiceNotification.deletetokennotificationapi()
                        .then((response) {
                      print(
                          "deletetokenapi---------------------------- => $response");
                    });
                    await DefaultCacheManager().emptyCache();
                    databox.clerdata();
                    _deleteCacheDir();
                    _deleteAppDir();
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      // exit(0);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Registration()),
                        (route) => false,
                      );
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

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationDocumentsDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }
}
