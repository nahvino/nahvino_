import 'package:Nahvino/core/Utils/Menu/menu_pop_btn.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/Chat/group/Widget/public_group_widget.dart';
import 'package:Nahvino/features/Chat/group/controllers/group/create_group_controller.dart';
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
      textDirection: TextDirection.rtl,
      child: Obx(
        () => Scaffold(
            appBar: AppBar(
              excludeHeaderSemantics: true,
              primary: true,
              backgroundColor: Colors.cyan.shade800,
              automaticallyImplyLeading: true,
              elevation: 2,
              title: Footnate(text: "ایجاد گروه"),
              actions: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () => creategroupcontroller.nextOne(),
                        child: Footnate(
                          text: "بعدی",
                          color: Colors.white,
                        )),
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
      child: Form(
        key: creategroupcontroller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Stack(
                    children: [
                      //edit image
                      creategroupcontroller.imagePath.value == ""
                          ? (imagegrup != null ||
                                  imagegrup != "" ||
                                  imagegrup != "null")
                              ? img.image_assets()
                              : img.image(imagegrup!)
                          : img.image_file(
                              creategroupcontroller.imagePath.value),
                      Positioned(
                        bottom: 0,
                        right: 50,
                        left: 0,
                        child: MenuPopUpButton(menuItems: <FocusedMenuItem>[
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
                                final XFile? photo = await creategroupcontroller
                                    .picker
                                    .pickImage(
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
                      ),
                    ],
                  ),
                ),
                // public_group.namegroup(
                //     creategroupcontroller.namecontroller, context),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      controller: creategroupcontroller.namecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'مقدار نمی تواند خالی باشد';
                        }
                        if (value.length > 25) {
                          return "نام گروه نمی تواند بیشتر از 25 حروف باشد";
                        }
                        if (value.length < 6) {
                          return 'نام گروه نمی تواند کمتر از 6 حروف باشد';
                        }

                        return null;
                        // Validator().empty(value!);
                      },
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 14, fontFamily: 'Vazirmatn_Medium'),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                            fontSize: 14, fontFamily: 'Vazirmatn_Medium'),
                        hintText: "نام گروه",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            /*
            Buttonfull(
                text: "بعدی",
                color: Colors.white,
                onPressed: () => Get.to(Page2Group())),

             */
          ],
        ),
      ),
    );
  }
}
