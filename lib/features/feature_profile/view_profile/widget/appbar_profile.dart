import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/shared/presentation/menu/widget/global_menu.dart';
import 'package:Nahvino/features/feature_profile/view_profile/controllers/profile_controller.dart';
import 'package:Nahvino/features/feature_profile/view_profile/data/view_profial_data.dart';
import 'package:Nahvino/features/feature_profile/view_profile/widget/popup_menu_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarProfile extends StatelessWidget {
  AppBarProfile({Key? key}) : super(key: key);
  ProfileController profile_Controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppBar(
        elevation: 0.1,
        title: Subhead(
          textAlign: TextAlign.right,
          text: profile_Controller.profileUserModelResponse!.userName,
          //color: Colors.white,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                  visible: profile_Controller.help.value,
                  child: Row(
                    children: [
                      Caption1(
                        textAlign: TextAlign.right,
                        text: AppLocalizations.of(context)!.translate(
                          'close_tutorial',
                        )!,
                        // color: Colors.white,
                      ),
                      InkWell(
                        onTap: () => profile_Controller.help.value = false,
                        child:
                        Icon(Icons.close, color: Colors.redAccent.shade700),
                      ),
                    ],
                  )),
              // PopUpMenuProfile(),
              GlobalMenu(),
            ],
          ),
        ],
      );
    });
  }
}
