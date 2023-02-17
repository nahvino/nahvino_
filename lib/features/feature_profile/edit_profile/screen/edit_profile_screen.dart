import 'dart:io';
import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Menu/menu_pop_btn.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/english_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/multi_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/not_vlide_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/public_text_filde.dart';
import 'package:Nahvino/features/feature_my_tabs/main/screen/mytab.dart';
import 'package:Nahvino/features/feature_my_tabs/main/screen/tabs.dart';
import 'package:Nahvino/features/feature_profile/view_profile/controllers/profile_controller.dart';
import 'package:Nahvino/features/feature_version/data/version_data.dart';
import 'package:Nahvino/main.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  EditProfileScreen({Key? key}) : super(key: key);

  EditProfileController editcontroller = Get.put(EditProfileController());
  ProfileController profile_Controller = Get.put(ProfileController());
  VersionData version = Get.put(VersionData());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Iconsax.arrow_right,
            color: theme.secondaryHeaderColor,
          ),
          //replace with our own icon data.
        ),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Footnate(
                text: profile_Controller.profileUserModelResponse!.userName),
            InkWell(
              onTap: () {
                if (!_formKey.currentState!.validate()) {
                } else {
                  editcontroller.upimg();
                  editcontroller.date();
                  editcontroller.profilerequest();
                  //موقعه خروجی صفر شود
                  Get.offAll(() => MyTabs(
                        tabIndex: 1,
                      ));
                }
              },
              child: Row(
                children: [
                  Footnate(
                      text: AppLocalizations.of(context)!.translate(
                    'OK',
                  )),
                  Icon(
                    Iconsax.save_2,
                    color: theme.secondaryHeaderColor,
                  ),
                ],
              ),
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
                      padding:
                          const EdgeInsets.only(right: 30, top: 12, left: 30),
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
                                      ? (profile_Controller
                                                      .profileUserModelResponse!
                                                      .imageUrl ==
                                                  "" ||
                                              profile_Controller
                                                      .profileUserModelResponse!
                                                      .imageUrl ==
                                                  "null" ||
                                              profile_Controller
                                                      .profileUserModelResponse!
                                                      .imageUrl ==
                                                  null)
                                          ? Icon(
                                              Icons.person,
                                              color: theme.secondaryHeaderColor,
                                            )
                                          : Image.network(
                                              profile_Controller
                                                  .profileUserModelResponse!
                                                  .imageUrl
                                                  .toString(),
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
                                    icon: (profile_Controller
                                                    .profileUserModelResponse!
                                                    .imageUrl ==
                                                "" ||
                                            profile_Controller
                                                    .profileUserModelResponse!
                                                    .imageUrl ==
                                                "null")
                                        ? Icon(
                                            Icons.add,
                                            color: theme.secondaryHeaderColor,
                                          )
                                        : Icon(
                                            Icons.edit,
                                            color: theme.secondaryHeaderColor,
                                          ),
                                    menuItems: <FocusedMenuItem>[
                                      FocusedMenuItem(
                                        title: Footnate(
                                          text: AppLocalizations.of(context)!
                                              .translate(
                                            'Camera',
                                          ),
                                        ),
                                        trailingIcon: Icon(
                                          Icons.camera,
                                          color: theme.secondaryHeaderColor,
                                        ),
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
                                            text: AppLocalizations.of(context)!
                                                .translate(
                                              'Gallery',
                                            ),
                                          ),
                                          trailingIcon: Icon(
                                            Icons.storage,
                                            color: theme.secondaryHeaderColor,
                                          ),
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
                              if (profile_Controller
                                      .profileUserModelResponse!.imageUrl !=
                                  "")
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        profile_Controller
                                            .profileUserModelResponse!
                                            .imageUrl = "";
                                        editcontroller.imageuris.value = "";
                                      },
                                      icon: Image.asset(
                                        alignment: Alignment.center,
                                        'assets/images/icon/trash.png',
                                        color: theme.secondaryHeaderColor,
                                      ),
                                    ),
                                    Caption2(
                                      text: AppLocalizations.of(context)!
                                          .translate(
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
                                        icon: Icon(
                                          Icons.close,
                                          color: theme.secondaryHeaderColor,
                                        )),
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
                      // prefixIcon: Icon(
                      //   Iconsax.user,
                      //   color: Colors.cyan,
                      // ),
                      controller: editcontroller.userNameController,
                      hint: AppLocalizations.of(context)!.translate(
                        'username',
                      )!,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PublicTextFilde(
                      suffixIcon: Icon(
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
                          suffixIcon: Icon(
                            Iconsax.calendar_tick,
                            color: Colors.cyan,
                          ),
                          controller: editcontroller.tarikhController,
                          hint: profile_Controller
                              .profileUserModelResponse!.dateTimeAbandon,
                          ontap: () async {
                            editcontroller.selectDate(context);
                          });
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    TextProfileBio(
                      suffixIcon: Icon(
                        Iconsax.note_text,
                        color: Colors.cyan,
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
