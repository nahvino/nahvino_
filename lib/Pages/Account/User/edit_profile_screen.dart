import 'dart:io';

import 'package:Nahvino/Data/Local/version_data.dart';
import 'package:Nahvino/Data/Local/view_profial_data.dart';
import 'package:Nahvino/Pages/Account/User/notifications.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/controllers/getx/user/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
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
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileController editcontroller = Get.put(EditProfileController());
  ProfileController abandon = Get.put(ProfileController());
  VersionData version = Get.put(VersionData());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
  }

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
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (() {
            /* Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyTabs()));*/
            Get.offAll(MyTabs());
          }),
        ),
      ),
      body: isApiCallProcess
          ? Center(
              child: Lottie.asset('assets/anim/user/submit-smile.json',
                  height: 300, width: 300),
            )
          : Obx((() => SafeArea(
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                                    source: ImageSource
                                                                        .camera,
                                                                    maxHeight:
                                                                        512,
                                                                    maxWidth:
                                                                        512,
                                                                    imageQuality:
                                                                        25);
                                                        if (photo != null) {
                                                          editcontroller
                                                                  .imagePath
                                                                  .value =
                                                              photo.path;
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
                                                                    source: ImageSource
                                                                        .gallery,
                                                                    maxHeight:
                                                                        512,
                                                                    maxWidth:
                                                                        512,
                                                                    imageQuality:
                                                                        25);
                                                        if (photo != null) {
                                                          editcontroller
                                                                  .imagePath
                                                                  .value =
                                                              photo.path;
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
                                      child:
                                          editcontroller.imagePath.value == ""
                                              ? (editcontroller.databox.imageUrl
                                                              .value ==
                                                          "" ||
                                                      editcontroller.databox
                                                              .imageUrl.value ==
                                                          "null")
                                                  ? Icon(Icons.person)
                                                  : Image.network(
                                                      MainConfig.fileurl +
                                                          editcontroller.databox
                                                              .imageUrl.value,
                                                      fit: BoxFit.cover)
                                              : Image.file(
                                                  File(editcontroller
                                                      .imagePath.value),
                                                  fit: BoxFit.cover),
                                    ),
                                  )),
                              Column(
                                children: [
                                  if (editcontroller.databox.imageUrl.value !=
                                      "")
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            editcontroller
                                                .databox.imageUrl.value = "";
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
                                            onPressed: () => editcontroller
                                                .imagePath.value = "",
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
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                            } else {
                              version.versionrequest();
                              editcontroller.upimg();
                              editcontroller.date();
                              editcontroller.profilerequest();
                              setState(() {
                                isApiCallProcess = true;
                              });
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
