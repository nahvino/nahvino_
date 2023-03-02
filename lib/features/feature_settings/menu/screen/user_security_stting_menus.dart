import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/SttingMenusButton.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_profile/view_profile/controllers/profile_controller.dart';

import 'package:Nahvino/features/feature_settings/menu/controllers/menu_controllers.dart';
import 'package:Nahvino/features/feature_settings/menu/controllers/re_mene_controllers.dart';
import 'package:Nahvino/features/feature_settings/user_security/change_phone/screen/change_phone_number.dart';
import 'package:Nahvino/features/feature_settings/user_security/set_phone/screen/set_phone_number.dart';
import 'package:Nahvino/features/feature_version/data/version_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../user_security/change_passwrod/screen/change_passwrod.dart';

class UserSecuritySttingMenus extends StatelessWidget {
  UserSecuritySttingMenus({Key? key}) : super(key: key);
  ProfileController profile_Controller = Get.put(ProfileController());
  MenueController menu_controller = Get.put(MenueController());
  REMenueController reM_controller = Get.put(REMenueController());

  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<REMenueController>(builder: (logic) {
        return  (reM_controller.userSecurtiyMenuModel != null)?Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_rounded),
                  onPressed: () => Navigator.pop(context)),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              title: Subhead(
                textAlign: TextAlign.right,
                text: profile_Controller.profileUserModelResponse!.userName,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.grey[200],
            body: SafeArea(
                child: body(context)),
          ),
        ):  Container(
          color: Colors.grey.shade100,
          child: Center(
            child: Lottie.asset('assets/anim/loading/loading.json',
                height: 300, width: 300),
          ),
        );
      });
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
                  visible: reM_controller.userSecurtiyMenuModel!
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
                  visible: reM_controller.userSecurtiyMenuModel!
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
                  visible: reM_controller.userSecurtiyMenuModel!
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


}
