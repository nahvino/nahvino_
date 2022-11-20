import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/shared/presentation/Widget/theme_switcher.dart';
import 'package:Nahvino/features/profile/view_profile/controllers/profile_controller.dart';
import 'package:Nahvino/features/profile/view_profile/data/view_profial_data.dart';
import 'package:Nahvino/features/profile/view_profile/widget/popup_menu_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarProfile extends StatelessWidget {
  AppBarProfile({Key? key}) : super(key: key);
  ViewProfileController databox = Get.put(ViewProfileController());
  ProfileController profile_Controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0.1,
        title: Subhead(
          textAlign: TextAlign.right,
          text: databox.username.value,
          //color: Colors.white,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ThemeSwitcher(),
              Visibility(
                  visible: profile_Controller.help.value,
                  child: Row(
                    children: [
                      Caption1(
                        textAlign: TextAlign.right,
                        text: "بستن آموزش",
                       // color: Colors.white,
                      ),
                      InkWell(
                        onTap: () => profile_Controller.help.value = false,
                        child:
                        Icon(Icons.close, color: Colors.redAccent.shade700),
                      ),
                    ],
                  )),
              PopUpMenuProfile(),
            ],
          ),
        ],
      );
    });
  }
}
