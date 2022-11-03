import 'dart:io';
import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/core/Utils/Menu/menu_pop_btn.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/english_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/multi_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/not_vlide_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/public_text_filde.dart';
import 'package:Nahvino/features/version/data/version_data.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  EditProfileScreen({Key? key}) : super(key: key);

  EditProfileController editcontroller = Get.put(EditProfileController());
  VersionData version = Get.put(VersionData());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade800,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Footnate(text: editcontroller.databox.username.value),
            Row(
              children: [
                Footnate(text: "تایید"),
                IconButton(
                    icon: Icon(Icons.check_circle_outline),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {} else {
                        version.versionrequest();
                        editcontroller.upimg();
                        editcontroller.date();
                        editcontroller.profilerequest();
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
      body: Obx((() =>
          SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Card(
                                shape: CircleBorder(),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: editcontroller.imagePath.value == ""
                                      ? (editcontroller
                                      .databox.imageUrl.value ==
                                      "" ||
                                      editcontroller
                                          .databox.imageUrl.value ==
                                          "null")
                                      ? Icon(Icons.person)
                                      : Image.network(
                                      MainConfig.fileurl +
                                          editcontroller
                                              .databox.imageUrl.value,
                                      fit: BoxFit.cover)
                                      : Image.file(
                                      File(editcontroller.imagePath.value),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 70,
                                child: MenuPopUpButton(

                                  icon: (editcontroller
                                      .databox.imageUrl.value ==
                                      "" ||
                                      editcontroller
                                          .databox.imageUrl.value ==
                                          "null") ?

                                  Icon(Icons.add) : Icon(Icons.edit),
                                    menuItems: <
                                    FocusedMenuItem>[
                                  FocusedMenuItem(
                                    title: Footnate(
                                      text: "دوربین",
                                    ),
                                    trailingIcon: Icon(Icons.camera),
                                    onPressed: () async {
                                      final XFile? photo =
                                      await editcontroller.picker.pickImage(
                                          source: ImageSource.camera,
                                          maxHeight: 512,
                                          maxWidth: 512,
                                          imageQuality: 25);
                                      if (photo != null) {
                                        editcontroller.imagePath.value =
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
                                        await editcontroller.picker
                                            .pickImage(
                                            source: ImageSource.gallery,
                                            maxHeight: 512,
                                            maxWidth: 512,
                                            imageQuality: 25);
                                        if (photo != null) {
                                          editcontroller.imagePath.value =
                                              photo.path;
                                        }
                                      }),
                                ]),
                              ),
                            ],
                          ),
                          /*   InkWell(
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (c) => Dialog(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .translate(
                                                      'Camera',
                                                    )!,
                                                  ),
                                                  onTap: () async {
                                                    final XFile? photo =
                                                        await editcontroller
                                                            .picker
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera,
                                                                maxHeight: 512,
                                                                maxWidth: 512,
                                                                imageQuality:
                                                                    25);
                                                    if (photo != null) {
                                                      editcontroller.imagePath
                                                          .value = photo.path;
                                                      Navigator.pop(c);
                                                      // setState(() {
                                                      //   editcontroller.imagePath
                                                      //       .value = photo.path;
                                                      //   Navigator.pop(c);
                                                      // });
                                                    }
                                                  },
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .translate(
                                                      'Gallery',
                                                    )!,
                                                  ),
                                                  onTap: () async {
                                                    final XFile? photo =
                                                        await editcontroller
                                                            .picker
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery,
                                                                maxHeight: 512,
                                                                maxWidth: 512,
                                                                imageQuality:
                                                                    25);
                                                    if (photo != null) {
                                                      editcontroller.imagePath
                                                          .value = photo.path;
                                                      Navigator.pop(c);
                                                      // setState(() {
                                                      //   editcontroller.imagePath
                                                      //       .value = photo.path;
                                                      //   Navigator.pop(c);
                                                      // });
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ));
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: editcontroller.imagePath.value == ""
                                      ? (editcontroller
                                                      .databox.imageUrl.value ==
                                                  "" ||
                                              editcontroller
                                                      .databox.imageUrl.value ==
                                                  "null")
                                          ? Icon(Icons.person)
                                          : Image.network(
                                              MainConfig.fileurl +
                                                  editcontroller
                                                      .databox.imageUrl.value,
                                              fit: BoxFit.cover)
                                      : Image.file(
                                          File(editcontroller.imagePath.value),
                                          fit: BoxFit.cover),
                                ),
                              )),*/
                          Column(
                            children: [
                              if (editcontroller.databox.imageUrl.value != "")
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        editcontroller.databox.imageUrl.value =
                                        "";
                                        editcontroller.imageuris.value = "";
                                      },
                                      icon: Image.asset(
                                          alignment: Alignment.center,
                                          'assets/images/icon/trash.png'),
                                    ),
                                    Caption2(
                                      text: 'حذف عکس',
                                    ),
                                  ],
                                ),
                              if (editcontroller.imagePath.value != "")
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () =>
                                        editcontroller.imagePath.value = "",
                                        icon: Icon(Icons.close)),
                                    Caption2(
                                      text: 'انصراف',
                                    ),
                                  ],
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                    EnglishTextFilde(
                      controller: editcontroller.userNameController,
                      hint: AppLocalizations.of(context)!.translate(
                        'username',
                      )!,
                    ),
                    PublicTextFilde(
                      controller: editcontroller.nameAliasController,
                      hint: AppLocalizations.of(context)!.translate(
                        'name',
                      )!,
                    ),
                    GetBuilder<EditProfileController>(
                        builder: (logic) {
                      return NotValidFilde(
                          controller: editcontroller.tarikhController,
                          hint: editcontroller.berlinWallFell.value +"   "+ editcontroller.databox.dateTimeAbandon.value,
                          ontap: () async {
                            editcontroller.selectDate(context);
                            /*
                          Jalali? picked = await showPersianDatePicker(
                            context: context,
                            initialDate: Jalali.now(),
                            firstDate: Jalali(1320, 1),
                            lastDate: Jalali.now(),
                          );
                          print(picked!.formatCompactDate());
                                                   print(editcontroller.tarikhController);
                          editcontroller.berlinWallFell.value =
                              picked.formatCompactDate();
                          print(editcontroller.berlinWallFell.value);*/
                          });
                    }),
                    TextProfileBio(
                      controller: editcontroller.bioController,
                      hint: AppLocalizations.of(context)!.translate(
                        'bio',
                      )!,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    /*
                    Buttonfull(
                      text: AppLocalizations.of(context)!.translate(
                        'OK',
                      )!,
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {} else {
                          version.versionrequest();
                          editcontroller.upimg();
                          editcontroller.date();
                          editcontroller.profilerequest();
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => MyTabs()),
                          // );
                          //Get.offAll(MyTabs());
                          // Navigator.pop(context);
                          //editcontroller.isApiCallProcess.value = false;

                        }
                      },
                      color: Colors.white,
                    ),
                    */

                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ))),
    );
  }
}
