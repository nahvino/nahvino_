import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/SttingMenusButton.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/shared/presentation/Widget/theme_switcher.dart';
import 'package:Nahvino/features/feature_chat/service/notification_service.dart';
import 'package:Nahvino/features/feature_my_tabs/main/screen/tabs.dart';
import 'package:Nahvino/features/feature_profile/view_profile/controllers/profile_controller.dart';
import 'package:Nahvino/features/feature_auth/main/screen/registration.dart';
import 'package:Nahvino/features/feature_settings/menu/controllers/menu_controllers.dart';
import 'package:Nahvino/features/feature_settings/menu/service/security_menu_service.dart';
import 'package:Nahvino/features/feature_settings/user_security/change_phone/screen/change_phone_number.dart';
import 'package:Nahvino/features/feature_settings/user_security/set_phone/screen/set_phone_number.dart';
import 'package:Nahvino/features/feature_version/data/version_data.dart';
import 'package:Nahvino/features/feature_version/screen/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../user_security/change_passwrod/screen/change_passwrod.dart';

class UserSecuritySttingMenus extends StatelessWidget {
  UserSecuritySttingMenus({Key? key}) : super(key: key);
  ProfileController profile_Controller = Get.put(ProfileController());
  VersionData version = Get.put(VersionData());
  MenueController menu_controller = Get.put(MenueController());

  @override
  Widget build(BuildContext context) {
    return
      (menu_controller.userSecurtiyMenuModel != null)?Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () => Get.offAll(MyTabs())),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: Subhead(
              textAlign: TextAlign.right,
              text: profile_Controller.profileUserModelResponse!.userName,
              color: Colors.black,
            ),
            actions: [
                /*
              Container(
                height: 40,
                child: PopupMenuButton<int>(
                  icon: Icon(
                    Icons.more_vert_rounded,
                  ),
                  itemBuilder: (context) =>
                  [
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
                            text: profile_Controller
                                .profileUserModelResponse!.identifierCode
                                .toString(),
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
                      value: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/icon/pngwing.com.png',
                              height: 24, width: 24, color: Colors.cyan),
                          //Image(image: AssetImage('graphics/background.png')),
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
                ),
              ),*/
            ]),
        backgroundColor: Colors.grey[200],
        body: SafeArea(
            child: body(context)),
      ),
    ):  Center(
        child: Lottie.asset('assets/anim/loading/loading.json',
            height: 300, width: 300),
      );
  }

  Widget body(BuildContext context) =>
      GetBuilder<MenueController>(builder: (logic) {
        return Column(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Title2(
                        textAlign: TextAlign.center,
                        text: AppLocalizations.of(context)!.translate(
                          'Security_settings',
                        )!,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: menu_controller.userSecurtiyMenuModel!
                      .password as bool,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                          MenusSttingButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangePasswrod()));
                            },
                            text: AppLocalizations.of(context)!.translate(
                              'text_ChangePasswrod',
                            )!,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: Divider(
                          height: 0,
                          thickness: 0.3,
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: menu_controller.userSecurtiyMenuModel!
                      .phoneNumber as bool,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.phone_android,
                            color: Colors.blue,
                          ),
                          MenusSttingButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SetPhoneNumber()));
                            },
                            text: AppLocalizations.of(context)!.translate(
                              'Mobile',
                            )!,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: Divider(
                          height: 0,
                          thickness: 0.3,
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: menu_controller.userSecurtiyMenuModel!
                      .phoneNumber as bool,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.phonelink_setup,
                            color: Colors.blue,
                          ),
                          MenusSttingButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangePhoneNumber()));
                            },
                            text: AppLocalizations.of(context)!.translate(
                              'phone_text_chenge',
                            )!,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: Divider(
                          height: 0,
                          thickness: 0.3,
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // info screen
                /*
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.phonelink_setup,
                          color: Colors.blue,
                        ),
                        MenusSttingButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoScreen()));
                          },
                          text: AppLocalizations.of(context)!.translate(
                            'infidivac',
                          )!,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 330,
                        child: DropdownButton<String>(
                            hint: Text('Language'),
                            value: menu_controller.selectedValue,
                            onChanged: (newValue) {
                              menu_controller.onSelected(newValue!);
                              print(newValue);
                            },
                            underline: Container(color: Colors.transparent),
                            elevation: 0,
                            items: [
                              DropdownMenuItem(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.translate(
                                        'English',
                                      )!,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 40,
                                      child: Image.network(
                                          "https://static3.parsnews.com/thumbnail/dAui7C5GYEcQ/00u_gJ5mbDPjYGfawu2HP7LRCRJqBGsxLfbtptyQEOTBhDRCzPHiEt5DkgzeYWqHX0lAEvzLGIE,/%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7.jpg"),
                                    )
                                  ],
                                ),
                                value: 'English',
                              ),
                              DropdownMenuItem(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.translate(
                                        'Persian',
                                      )!,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 40,
                                      child: Image.network(
                                          "https://www.seyedrezabazyar.com/fa/files/2016/07/iran-flag.jpg"),
                                    )
                                  ],
                                ),
                                value: 'Persian',
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Title2(
                        text: "تغییر تم",
                      ),
                      ThemeSwitcher()
                    ],
                  ),
                )*/
              ],
            )
          ],
        );
      });

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        break;
      case 1:
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Notifications()));
        break;
      case 2:
        Share.share(profile_Controller.profileUserModelResponse!.identifierCode
            .toString() +
            AppLocalizations.of(context)!.translate(
              'identification_code',
            )!);
        break;
      case 3:
        showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                  title: Text(AppLocalizations.of(context)!.translate(
                    'apptitle',
                  )!),
                  content: Text(AppLocalizations.of(context)!.translate(
                    'quExit',
                  )!),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(
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
                        final preferences = await SharedPreferences
                            .getInstance();
                        await preferences.clear();
                        ServiceNotification.deletetokennotificationapi()
                            .then((response) {
                          print(
                              "deletetokenapi---------------------------- => $response");
                        });
                        await DefaultCacheManager().emptyCache();
                        _deleteCacheDir();
                        _deleteAppDir();
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          //exit(0);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()),
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
      case 4:
        Share.share(profile_Controller.profileUserModelResponse!.identifierCode
            .toString() +
            AppLocalizations.of(context)!.translate(
              'identification_code',
            )!);
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
