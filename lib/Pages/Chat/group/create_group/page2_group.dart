import 'package:Nahvino/Pages/Chat/Widget/public_group_widget.dart';
import 'package:Nahvino/Pages/Chat/group/create_group/page3_group.dart';
import 'package:Nahvino/Utils/Button/Button.dart';
import 'package:Nahvino/Utils/Menu/menu_pop_btn.dart';
import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:Nahvino/Utils/TextField/public_text_filde.dart';
import 'package:Nahvino/Utils/Widget/image_view.dart';
import 'package:Nahvino/controllers/getx/chat/group/create_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Page2Group extends StatelessWidget {
  Page2Group({Key? key}) : super(key: key);
  CreateGroupController creategroupcontroller =
      Get.put(CreateGroupController());

  Imageview img = Imageview();
  PublicGroupWidget public_group = PublicGroupWidget();

  String? imagegrup;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          appBar: AppBar(
            excludeHeaderSemantics: true,
            primary: true,
            backgroundColor: Colors.cyan.shade800,
            automaticallyImplyLeading: true,
            elevation: 2,
            actions: [
              Row(
                children: [
                  Footnate(text: "ایجاد گروه"),
                  SizedBox(
                    width: 18,
                  ),
                ],
              )
            ],
          ),
          body: buildChild(context)),
    );
  }

  buildChild(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    public_group.suport("", "نسرین", "معاون اول", () {}),
                    public_group.suport("", "مهدی", "معاون دوم", () {}),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Buttonfull(
                text: "بعدی",
                color: Colors.white,
                onPressed: () => Get.to(Page3Group())),
          ],
        ),
      ),
    );
  }
}
