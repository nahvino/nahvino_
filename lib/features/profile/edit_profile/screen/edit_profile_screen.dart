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
import 'package:iconsax/iconsax.dart';
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
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:  Icon(
            Iconsax.arrow_right,
            color: Colors.black,
          ),
          //replace with our own icon data.
        ),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Footnate(text: editcontroller.databox.username.value),
            Row(
              children: [
                Footnate(text: AppLocalizations.of(context)!.translate(
                  'OK',
                )),
                IconButton(
                    icon:  Icon(
                      Iconsax.save_2,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                      } else {
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
      body: Obx((() => SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 12,left: 30),
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
                                                "null")
                                        ? Icon(Icons.add)
                                        : Icon(Icons.edit),
                                    menuItems: <FocusedMenuItem>[
                                      FocusedMenuItem(
                                        title: Footnate(
                                          text: AppLocalizations.of(context)!.translate(
                                            'Camera',
                                          ),
                                        ),
                                        trailingIcon: Icon(Icons.camera),
                                        onPressed: () async {
                                          final XFile? photo =
                                              await editcontroller.picker
                                                  .pickImage(
                                                      source:
                                                          ImageSource.camera,
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
                                            text: AppLocalizations.of(context)!.translate(
                                              'Gallery',
                                            ),
                                          ),
                                          trailingIcon: Icon(Icons.storage),
                                          onPressed: () async {
                                            final XFile? photo =
                                                await editcontroller.picker
                                                    .pickImage(
                                                        source:
                                                            ImageSource.gallery,
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
                                      text: AppLocalizations.of(context)!.translate(
                                        'DELIMAGE',
                                      )!,
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
                                      text: 'Cancel',
                                    ),
                                  ],
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    EnglishTextFilde(
                      prefixIcon:
                      Icon(
                        Iconsax.user,
                        color: Colors.cyan,
                      ),
                      controller: editcontroller.userNameController,
                      hint: AppLocalizations.of(context)!.translate(
                        'username',
                      )!,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PublicTextFilde(
                      prefixIcon:
                       Icon(
                        Iconsax.user_square,
                        color: Colors.cyan,
                      ),
                      controller: editcontroller.nameAliasController,
                      hint: AppLocalizations.of(context)!.translate(
                        'name',
                      )!,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetBuilder<EditProfileController>(builder: (logic) {
                      return NotValidFilde(
                          prefixIcon:
                          Icon(
                            Iconsax.calendar_tick,
                            color: Colors.cyan,
                          ),
                          controller: editcontroller.tarikhController,
                          hint:  AppLocalizations.of(context)!.translate(
                            'tark_ct',
                          )! +
                             "      "+
                              editcontroller.databox.dateTimeAbandon.value,
                          ontap: () async {
                            editcontroller.selectDate(context);
                          });
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    TextProfileBio(
                      prefixIcon:
                      Column(
                        children: [
                          Positioned(
                            bottom: 130,
                            child:
                          Icon(
                            Iconsax.note_text,
                            color: Colors.cyan,
                          ),),
                        ],
                      ),
                      controller: editcontroller.bioController,
                      hint: AppLocalizations.of(context)!.translate(
                        'bio',
                      )!,
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
