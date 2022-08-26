import 'package:Nahvino/Pages/Chat/Widget/public_group_widget.dart';
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

class CreateGroup extends StatelessWidget {
  CreateGroup({Key? key}) : super(key: key);
  CreateGroupController creategroupcontroller =
      Get.put(CreateGroupController());

  Imageview img = Imageview();
  PublicGroupWidget public_group = PublicGroupWidget();

  String? imagegrup;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Obx(
        () => Scaffold(
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
      ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: width / 100),
                  child: public_group
                      .namegroup(creategroupcontroller.namecontroller,context),
                ),

                //edit image
                Padding(
                  padding: EdgeInsets.only(right: width / 30),
                  child: Row(
                    children: [
                      MenuPopUpButton(menuItems: <FocusedMenuItem>[
                        FocusedMenuItem(
                          title: Footnate(
                            text: "دوربین",
                          ),
                          trailingIcon: Icon(Icons.camera),
                          onPressed: () async {
                            final XFile? photo =
                                await creategroupcontroller.picker.pickImage(
                                    source: ImageSource.camera,
                                    maxHeight: 512,
                                    maxWidth: 512,
                                    imageQuality: 25);
                            if (photo != null) {
                              creategroupcontroller.imagePath.value =
                                  photo.path;
                            }
                          },
                        ),
                        FocusedMenuItem(
                            title: Footnate(
                              text: "حافظه",
                            ),
                            trailingIcon: Icon(Icons.storage),
                            onPressed: () async {
                              final XFile? photo =
                                  await creategroupcontroller.picker.pickImage(
                                      source: ImageSource.gallery,
                                      maxHeight: 512,
                                      maxWidth: 512,
                                      imageQuality: 25);
                              if (photo != null) {
                                creategroupcontroller.imagePath.value =
                                    photo.path;
                              }
                            }),
                      ]),
                      creategroupcontroller.imagePath.value == ""
                          ? (imagegrup != null ||
                                  imagegrup != "" ||
                                  imagegrup != "null")
                              ? img.image_assets()
                              : img.image(imagegrup!)
                          : img
                              .image_file(creategroupcontroller.imagePath.value)
                    ],
                  ),
                )
              ],
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
            public_group.textfilde(
                " :قوانین گروه", context, creategroupcontroller.rulscontroller),
            SizedBox(
              height: 10,
            ),
            public_group.textfilde(" :قول و قرار  ", context,
                creategroupcontroller.gholghrarcontroller),
            SizedBox(
              height: 10,
            ),
            Buttonfull(
                text: "اعمال تغییرات",
                color: Colors.white,
                onPressed: () => creategroupcontroller.apply()),
          ],
        ),
      ),
    );
  }
}
