import 'package:Nahvino/Pages/Chat/Widget/public_group_widget.dart';

import 'package:Nahvino/Pages/Chat/group/create_group/page1_group.dart';
import 'package:Nahvino/Pages/Chat/group/edit_group.dart';
import 'package:Nahvino/Pages/Chat/group/group.dart';
import 'package:Nahvino/Pages/Chat/group/info_group.dart';
import 'package:Nahvino/Pages/Chat/private/person.dart';
import 'package:Nahvino/Pages/Chat/settings/setting_global.dart';
import 'package:Nahvino/Utils/Button/Button.dart';
import 'package:Nahvino/Utils/Menu/menu_pop.dart';
import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:Nahvino/Utils/Widget/dialog_tow_btn.dart';
import 'package:Nahvino/controllers/getx/chat/group/home_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';

class HomeScren extends StatelessWidget {
  HomeScren({Key? key}) : super(key: key);
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
                              home_group_controller.update();
                            },
                            icon: Icon(
                                home_group_controller.isInSearchMode.value
                                    ? Icons.search
                                    : Icons.close)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                    title: home_group_controller.isInSearchMode.value
                        ? Subhead(
                            text: "چت نحوینو",
                          )
                        : gowidget.searchmood(),
                    leadingWidth: 60,
                    leading: MenuPopUp(
                      menuItems: <FocusedMenuItem>[
                        FocusedMenuItem(
                            title: Footnate(
                              text: "تنظیمات",
                            ),
                            trailingIcon: Icon(Icons.settings),
                            onPressed: () => Get.to(SettingGlobal())),
                        FocusedMenuItem(
                            title: Footnate(
                              text: "لینک",
                            ),
                            trailingIcon: Icon(Icons.share),
                            onPressed: () {
                              print("درسته");
                            }),
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
                            Icon(Icons.group),
                            SizedBox(
                              width: 3,
                            ),
                            Text("گروه")
                          ],
                        )),
                        Tab(
                            child: Row(
                          children: [
                            Icon(Icons.group),
                            SizedBox(
                              width: 3,
                            ),
                            Text("خصوصی")
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
    return Group();
  }

  taptow(BuildContext context) {
    return Person();
  }
/*
  tapone(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Buttonfull(
          text: "حذف پیام",
          onPressed: () {
            showDialog<void>(
                context: context,
                builder: (context) => DialogTowButton(
                      title: "از حذف پیام انتخابی مطمئن هستید؟",
                      textbutton: "ثبت",
                      onPressed: () {
                        print("API Delete Massage");
                        Navigator.pop(context, true);
                      },
                    ));

            // Get.defaultDialog(title: "ddds");
          },
          color: Colors.blueAccent,
        ),
        SizedBox(
          height: 10,
        ),
        Buttonfull(
          text: "ویرایش گروه",
          onPressed: () {
            Get.to(EditGroup());
          },
          color: Colors.blueAccent,
        ),
        SizedBox(
          height: 10,
        ),
        Buttonfull(
          text: "ایجاد گروه",
          onPressed: () {
            Get.to(CreateGroup());
          },
          color: Colors.blueAccent,
        ),
        SizedBox(
          height: 10,
        ),
        Buttonfull(
          text: "درباره ی گروه",
          onPressed: () {
            Get.to(InfoGroup());
          },
          color: Colors.blueAccent,
        ),
      ],
    );
  }
*/

}
