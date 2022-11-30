import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/Chat/fake_info/model_user.dart';
import 'package:Nahvino/features/Chat/group/Widget/public_group_widget.dart';
import 'package:Nahvino/features/Chat/group/edit_group/controllers/edit_group_controller.dart';
import 'package:Nahvino/features/Chat/group/controllers/home_group_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SelectManber extends StatelessWidget {
  SelectManber({Key? key}) : super(key: key);
  HomeGroupController home_group_controller = Get.put(HomeGroupController());
  Imageview img = Imageview();
  String? imagegrup;
  EditGroupController editgroupcontroller = Get.put(EditGroupController());
  PublicGroupWidget gowidget = PublicGroupWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.cyan.shade800,
          title: home_group_controller.isInSearchMode.value
              ? gowidget.searchmood(changed: (value) {
                  home_group_controller.serchtext.value = value;
                  home_group_controller.update();
                })
              : Subhead(
                  text: AppLocalizations.of(context)!.translate(
                    'select_deputy',
                  )!,
                ),
          actions: [
            Container(
              child: IconButton(
                  onPressed: () {
                    home_group_controller.isInSearchMode.value =
                        !home_group_controller.isInSearchMode.value;
                    home_group_controller.serchtext.value = "";
                    home_group_controller.update();
                  },
                  icon: Icon(home_group_controller.isInSearchMode.value
                      ? Icons.close
                      : Icons.search)),
            ),
          ],
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: home_group_controller.serchtext.value != "" &&
                  home_group_controller.isInSearchMode.value
              ? user
                  .where((element) => element.name!
                      .contains(home_group_controller.serchtext.value))
                  .toList()
                  .length
              : user.length,
          itemBuilder: chatItem,
          physics: NeverScrollableScrollPhysics(),
        ),
      );
    });
  }

  Widget chatItem(context, index) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (home_group_controller.InSearchMode.value == true)
                    Row(
                      children: [
                        (imagegrup != null &&
                                imagegrup != "" &&
                                imagegrup != "null")
                            ? img.image(imagegrup!)
                            : img.image_asset_user(user[index].img!, true),
                        SizedBox(
                          width: 10,
                        ),

                            Footnate(
                              text: user[index].name!,
                            ),
                        SizedBox(
                          width: 85,
                        ),
                        Footnate(
                          text: "10",
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        img.image_assetsa("assets/images/home/barg.png")


                      ],
                    ),
                  Container(
                    width: 60,
                    child: Buttonfull(
                      text: AppLocalizations.of(context)!.translate(
                        'add',
                      )!,
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
