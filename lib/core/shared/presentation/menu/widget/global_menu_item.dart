import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/shared/presentation/controllers/public/public_controller.dart';
import 'package:Nahvino/core/shared/presentation/menu/widget/global_menu_item_button.dart';
import 'package:Nahvino/features/feature_profile/view_profile/controllers/profile_controller.dart';
import 'package:Nahvino/features/feature_profile/view_profile/data/view_profial_data.dart';
import 'package:Nahvino/features/feature_settings/menu/screen/user_security_stting_menus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';

class GlobalMenuItem extends StatelessWidget {
  GlobalMenuItem({Key? key}) : super(key: key);
  PublicController pu_Controller = Get.put(PublicController());
  ViewProfileController databox = Get.put(ViewProfileController());
  ProfileController profile_Controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.30,
      child: Column(children: [
        SizedBox(
          width: 70,
          height: 20,
          child: Card(
            elevation: 0,
            color: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        GlobalMenuItemButton(
          text: AppLocalizations.of(context)!.translate(
            'Security_settings',
          )!,
          icon: Icon(
            Iconsax.security,
            color: Colors.cyan,
          ),
          ontop: () => Get.to(() => UserSecuritySttingMenus()),
        ),
        GlobalMenuItemButton(
          text: AppLocalizations.of(context)!.translate(
            'YCTIANM',
          )!,
          icon: Icon(
            Iconsax.share,
            color: Colors.cyan,
          ),
          ontop: () => Share.share(databox.identifierCode.toString() +
              AppLocalizations.of(context)!.translate(
                'identification_code',
              )!),
        ),
        GlobalMenuItemButton(
          text: "راهنما ی بخش های مختلف نحوینو",
          icon: Icon(
            Iconsax.triangle,
            color: Colors.cyan,
          ),
          ontop: () {
            profile_Controller.help_vizi();
            Navigator.pop(context, true);
          },
        ),
        GlobalMenuItemButton(
          text: AppLocalizations.of(context)!.translate(
            'Eixt',
          )!,
          icon: Icon(
            Iconsax.logout_1,
            color: Colors.cyan,
          ),
          ontop: () => pu_Controller.allclear(),
        )
      ]),
    );
  }
}
