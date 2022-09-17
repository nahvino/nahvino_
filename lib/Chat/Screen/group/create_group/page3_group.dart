import 'package:Nahvino/Chat/Widget/public_group_widget.dart';
import 'package:Nahvino/Chat/controllers/group/create_group_controller.dart';
import 'package:Nahvino/Utils/Button/Button.dart';
import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:Nahvino/Utils/Widget/image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Page3Group extends StatelessWidget {
  Page3Group({Key? key}) : super(key: key);
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
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          public_group.textfilde(
              " قوانین گروه : ", context, creategroupcontroller.rulscontroller),
          SizedBox(
            height: 10,
          ),
          public_group.textfilde(" قول و قرار : ", context,
              creategroupcontroller.gholghrarcontroller),
          SizedBox(
            height: 10,
          ),

          Buttonfull(
              text: "ایجاد گروه",
              color: Colors.white,
              onPressed: () => creategroupcontroller.createGroup()),


        ],
      ),
    );
  }
}
