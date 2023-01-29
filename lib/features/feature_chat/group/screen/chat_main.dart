import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Menu/menu_pop.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_chat/group/controllers/home_group_controller.dart';
import 'package:Nahvino/features/feature_chat/private/screen/person.dart';
import 'package:Nahvino/features/feature_chat/group/Widget/public_group_widget.dart';
import 'package:Nahvino/features/feature_chat/group/create_group/screen/create_group_screen.dart';
import 'package:Nahvino/features/feature_chat/group/main/screen/group_screen.dart';
import 'package:Nahvino/features/feature_chat/settings/setting_global.dart';
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
    var theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.cyan.shade800,
              child: Icon(Icons.group_add),
              onPressed: (() => Get.to(CreateGroup()))),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    backgroundColor: Colors.cyan.shade800,
                    actions: [
                      Container(
                        child: IconButton(
                            onPressed: () {
                              /*
                              home_group_controller.isInSearchMode.value =
                                  !home_group_controller.isInSearchMode.value;
                              home_group_controller.serchtext.value = "";
                              home_group_controller.update();
                              */
                            },
                            icon: Icon(
                                Icons.search)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                    title: /* home_group_controller.isInSearchMode.value
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.cyan.shade700,
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 19),
                                child: TextFormField(
                                  controller: home_group_controller.search_controller,
                                  onChanged: (value) {
                                    home_group_controller.serchtext.value =
                                        value;
                                    home_group_controller.update();
                                  },
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Vazirmatn_Medium',
                                      color: Colors.white),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Vazirmatn_Medium',
                                        color: Colors.white),
                                    hintText: "جستوجو",
                                  ),
                                ),
                              ),
                            ),
                          )
                        :*/ Subhead(
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
                          children: [
                            Icon(
                              Iconsax.people,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              AppLocalizations.of(context)!.translate(
                                'group',
                              )!,
                            )
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
                            Text(
                              AppLocalizations.of(context)!.translate(
                                'private',
                              )!,
                            )
                          ],
                        )),
                      ],
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
