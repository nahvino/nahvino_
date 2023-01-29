import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/core/Utils/Menu/menu_pop.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_chat/group/chat_group/controllers/chat_group_controller.dart';
import 'package:Nahvino/features/feature_chat/group/edit_group/screen/edit_group_screen.dart';
import 'package:Nahvino/features/feature_chat/group/info_group/controllers/info_group_controller.dart';
import 'package:Nahvino/features/feature_chat/group/shared/screen/mission_screen.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
class MenuAppbarChatGroupWudght extends StatelessWidget {
   MenuAppbarChatGroupWudght({Key? key}) : super(key: key);
   InfoGroupController info_group_controller = Get.put(InfoGroupController());
   ChatGroupController chat_group_controller = Get.put(ChatGroupController());

   @override
  Widget build(BuildContext context) {
    return  MenuPopUp(
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
            title: Footnate(
              text: "سرچ",
            ),
            trailingIcon: Icon(chat_group_controller.serach_mood.value
            ? Icons.close
                : Icons.search),
            onPressed: () {
                    chat_group_controller.serach_mood.value =
                    !chat_group_controller.serach_mood.value;
                    chat_group_controller.update();

            }), FocusedMenuItem(
            title: Footnate(
              text: AppLocalizations.of(context)!.translate(
                'Settings',
              )!,
            ),
            trailingIcon: Icon(Icons.settings),
            onPressed: () {
              Get.to(EditGroup());
            }),
        FocusedMenuItem(
            title: Footnate(
              text: AppLocalizations.of(context)!.translate(
                'link',
              )!,
            ),
            trailingIcon: Icon(Icons.share),
            onPressed: () {
              Share.share(MainConfig.baseURL +
                  "/" +
                  info_group_controller.link
                      .toString());
            }),
        FocusedMenuItem(
            title: Footnate(
              text: AppLocalizations.of(context)!.translate(
                'Maram_Namah',
              )!,
            ),
            trailingIcon:
            Icon(Icons.pending_actions),
            onPressed: () {
              Get.to(MissionScreen());
            }),
        if (info_group_controller.join.value ==
            false)
          FocusedMenuItem(
              title: Footnate(
                color: Colors.redAccent,
                text: AppLocalizations.of(context)!.translate(
                  'Leave_group',
                )!,
              ),
              trailingIcon: Icon(
                Icons.exit_to_app,
                color: Colors.redAccent,
              ),
              onPressed: () {
                info_group_controller.leavegroup();
              }),
      ],
    );
  }
}
