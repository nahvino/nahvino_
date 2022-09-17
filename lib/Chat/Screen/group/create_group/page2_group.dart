import 'package:Nahvino/Chat/Widget/public_group_widget.dart';
import 'package:Nahvino/Chat/controllers/group/create_group_controller.dart';
import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:Nahvino/Utils/Widget/image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            excludeHeaderSemantics: true,
            primary: true,
            backgroundColor: Colors.cyan.shade800,
            automaticallyImplyLeading: true,
            elevation: 2,
            title:  Footnate(text: "ایجاد گروه"),

            actions: [
              Row(
                children: [
                  TextButton(onPressed: () => creategroupcontroller.nextTow(), child: Footnate(text: "بعدی",color: Colors.white,)),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                public_group.suport("", "نسرین", "معاون اول", () {}),
                public_group.suport("", "مهدی", "معاون دوم", () {}),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            /*
            Buttonfull(
                text: "بعدی",
                color: Colors.white,
                onPressed: () => Get.to(Page3Group())),

             */
          ],
        ),
      ),
    );
  }
}
