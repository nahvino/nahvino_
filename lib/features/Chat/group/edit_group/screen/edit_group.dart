import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Menu/menu_pop_btn.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/Chat/group/Widget/public_group_widget.dart';
import 'package:Nahvino/features/Chat/group/create_group/screen/select_menber.dart';
import 'package:Nahvino/features/Chat/group/edit_group/controllers/edit_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditGroup extends StatelessWidget {
  EditGroup({Key? key}) : super(key: key);
  EditGroupController editgroupcontroller = Get.put(EditGroupController());
  Imageview img = Imageview();
  PublicGroupWidget public_group = PublicGroupWidget();
  String? imagegrup;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Obx(
        (() => Scaffold(
            appBar: AppBar(
              excludeHeaderSemantics: true,
              primary: true,
              backgroundColor: Colors.cyan.shade800,
              automaticallyImplyLeading: true,
              elevation: 2,
              actions: [
                Row(
                  children: [
                    Footnate(text: "ویرایش گروه"),
                    SizedBox(
                      width: 8,
                    ),
                    (imagegrup != null &&
                            imagegrup != "" &&
                            imagegrup != "null")
                        ? img.image(imagegrup!)
                        : img.image_assets(),
                    SizedBox(
                      width: 8,
                    ),
                    //menu pop up

                    SizedBox(
                      width: 8,
                    ),
                  ],
                )
              ],
            ),
            body: buildChild(context))),
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
                  padding: EdgeInsets.only(right: width / 6),
                  child: public_group.informationtow("10", "5"),
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
                                await editgroupcontroller.picker.pickImage(
                                    source: ImageSource.camera,
                                    maxHeight: 512,
                                    maxWidth: 512,
                                    imageQuality: 25);
                            if (photo != null) {
                              editgroupcontroller.imagePath.value = photo.path;
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
                                  await editgroupcontroller.picker.pickImage(
                                      source: ImageSource.gallery,
                                      maxHeight: 512,
                                      maxWidth: 512,
                                      imageQuality: 25);
                              if (photo != null) {
                                editgroupcontroller.imagePath.value =
                                    photo.path;
                              }
                            }),
                      ]),
                      editgroupcontroller.imagePath.value == ""
                          ? (imagegrup != null ||
                                  imagegrup != "" ||
                                  imagegrup != "null")
                              ? img.image_assets()
                              : img.image(imagegrup!)
                          : img.image_file(editgroupcontroller.imagePath.value)
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                public_group.suport("", "نسرین", "معاون اول", () {
                  Get.to(SelectManber());
                }),
                public_group.suport("", "مهدی", "معاون دوم", () {
                  Get.to(SelectManber());
                }),
              ],
            ),
            public_group.textfilde(
                " :قوانین گروه", context, editgroupcontroller.rulscontroller),
            SizedBox(
              height: 10,
            ),
            public_group.textfilde(" :قول و قرار  ", context,
                editgroupcontroller.gholghrarcontroller),
            SizedBox(
              height: 10,
            ),
            Buttonfull(
              text: "اعمال تغییرات",
              color: Colors.white,
              onPressed: () => editgroupcontroller.apply(),
            ),
          ],
        ),
      ),
    );
  }
}
