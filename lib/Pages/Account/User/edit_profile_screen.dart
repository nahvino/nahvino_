import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:Nahvino/Services/config.dart';

import '../../../App_localizations.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/Text.dart';
import '../../../Utils/Text/TextField.dart';
import '../../../Utils/TextField/english_text_filde.dart';
import '../../../Utils/TextField/not_vlide_text_filde.dart';
import '../../../Utils/TextField/public_text_filde.dart';
import '../../../controllers/getx/user/edit_profile_controller.dart';
import '../../../tabs.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileController editcontroller = Get.put(EditProfileController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade800,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Footnate(text: editcontroller.databox.username.value),
          ],
        ),
        leading: BackButton(
          onPressed: (() {
            /* Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyTabs()));*/
            Get.offAll(MyTabs());
          }),
        ),
      ),
      body: Obx(() {
        return SafeArea(
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
                        Card(
                            shape: CircleBorder(),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (c) => Dialog(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  AppLocalizations.of(context)!
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
                                                              imageQuality: 25);
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
                                                  AppLocalizations.of(context)!
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
                                                              imageQuality: 25);
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
                                child: editcontroller.imagePath.value ==
                                        null.obs
                                    ? (editcontroller.databox.imageUrl.value ==
                                                null.obs ||
                                            editcontroller
                                                    .databox.imageUrl.value ==
                                                "")
                                        ? Icon(Icons.person)
                                        : Image.network(
                                            Configss.fileurl +
                                                editcontroller
                                                    .databox.imageUrl.value,
                                            fit: BoxFit.cover)
                                    : Image.file(
                                        File(editcontroller.imagePath.value),
                                        fit: BoxFit.cover),
                              ),
                            )),
                        if (editcontroller.imagePath.value != "")
                          IconButton(
                              onPressed: () =>
                                  editcontroller.imagePath.value != "",
                              icon: Icon(Icons.close))
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
                  NotValidFilde(
                      hint: editcontroller.databox.dateTimeAbandon.value,
                      ontap: () async {
                        Jalali? picked = await showPersianDatePicker(
                          context: context,
                          initialDate: Jalali.now(),
                          firstDate: Jalali(1320, 1),
                          lastDate: Jalali.now(),
                        );
                        print(picked!.formatCompactDate());
                        editcontroller.berlinWallFell.value =
                            picked.formatCompactDate();
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
                  Buttonfull(
                    text: AppLocalizations.of(context)!.translate(
                      'OK',
                    )!,
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                      } else {
                        //editcontroller.validatoreditprofile();
                        // editcontroller.isApiCallProcess.value == true.obs;
                        editcontroller.upimg();
                        editcontroller.profilerequest();
                        editcontroller.date();
                        Get.offAll(MyTabs());
                      }
                    },
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
