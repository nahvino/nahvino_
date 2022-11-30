import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Menu/menu_pop.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/Chat/group/controllers/home_group_controller.dart';
import 'package:Nahvino/features/Chat/private/screen/person.dart';
import 'package:Nahvino/features/Chat/group/Widget/public_group_widget.dart';
import 'package:Nahvino/features/Chat/group/create_group/screen/page1_group_screen.dart';
import 'package:Nahvino/features/Chat/group/main/screen/group_screen.dart';
import 'package:Nahvino/features/Chat/settings/chat_setting.dart';
import 'package:Nahvino/features/Chat/settings/setting_global.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Chats extends StatelessWidget {
  Chats({Key? key}) : super(key: key);
  final HomeGroupController home_group_controller =
      Get.put(HomeGroupController());

  PublicGroupWidget gowidget = PublicGroupWidget();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.cyan.shade800,
              child: Icon(Icons.group_add),
              onPressed: (() => Get.to(CreateGroup()))),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                Obx(
                  () => SliverAppBar(
                    backgroundColor: Colors.cyan.shade800,
                    actions: [
                      Container(
                        child: IconButton(
                            onPressed: () {
                              home_group_controller.isInSearchMode.value =
                                  !home_group_controller.isInSearchMode.value;
                              home_group_controller.serchtext.value = "";
                              home_group_controller.update();
                            },
                            icon: Icon(
                                home_group_controller.isInSearchMode.value
                                    ? Icons.close
                                    : Icons.search)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                    title: home_group_controller.isInSearchMode.value
                        ? gowidget.searchmood(changed: (value) {
                            home_group_controller.serchtext.value = value;
                            home_group_controller.update();
                          })
                        : Subhead(
                            text: "چت نحوینو",
                          ),
                    leadingWidth: 60,
                    leading: MenuPopUp(
                      menuItems: <FocusedMenuItem>[
                        FocusedMenuItem(
                            title: Footnate(
                              text: "تنظیمات",
                            ),
                            trailingIcon: Icon(Icons.settings),
                            onPressed: () => Get.to(SettingGlobal())),
                        //Get.to(SettingGlobal())),
                        // FocusedMenuItem(
                        //     title: Footnate(
                        //       text: "لینک",
                        //     ),
                        //     trailingIcon: Icon(Icons.share),
                        //     onPressed: () {
                        //       print("درسته");
                        //     }),
                      ],
                    ),
                    pinned: true,
                    floating: true,
                    bottom: TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(
                            child: Row(
                          children: [  Icon(
                            Iconsax.people,
                            color: Colors.white,
                          ),

                            SizedBox(
                              width: 3,
                            ),
                            Text( AppLocalizations.of(context)!.translate(
                              'group',
                            )!,)
                          ],
                        )),
                        Tab(
                            child: Row(
                          children: [
                            Icon(
                              Iconsax.user,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text( AppLocalizations
                                .of(context)!.translate(
                              'private',
                            )!,)
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                tapone(context),
                taptow(context),
              ],
            ),
          )),
    );
  }

  tapone(BuildContext context) {
    return SingleChildScrollView(child: Group());
  }

  taptow(BuildContext context) {
    return SingleChildScrollView(child: Person());
  }
}
