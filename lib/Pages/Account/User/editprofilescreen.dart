import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:Nahvino/Services/config.dart';

import '../../../App_localizations.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Services/Login/User/service_profile.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/Text.dart';
import '../../../Utils/Text/TextField.dart';
import '../../../Utils/TextField/englishtextfilde.dart';
import '../../../Utils/TextField/publictextfilde.dart';
import '../../../controllers/getx/user/editprofile_controller.dart';
import '../../../tabs.dart';
import 'ViewProfile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileController editcontroller = Get.put(EditProfileController());
  final ImagePicker _picker = ImagePicker();
  late APIService? apiService;
  late ServiceProfile? serpro;
  String? imagePath;
  String? imageuri;
  String berlinWallFell = "تاریخ ترک";

  @override
  void initState() {
    super.initState();
    apiService = APIService(context);
    serpro = ServiceProfile();
    imageuri = editcontroller.databox.imageUrl.value;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Obx(() {
          return SafeArea(
              child: editcontroller.isApiCallProcess.value
                  ? Center(
                      child: Lottie.asset('assets/anim/user/submit-smile.json',
                          height: 300, width: 300),
                    )
                  : body(context));
        }),
      ),
    );
  }

  body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Footnate(text: editcontroller.databox.username.value),
          ],
        ),
        leading: BackButton(
          onPressed: (() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyTabs()));
          }),
        ),
      ),
      body: SafeArea(
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
                                                  await _picker.pickImage(
                                                      source:
                                                          ImageSource.camera,
                                                      maxHeight: 512,
                                                      maxWidth: 512,
                                                      imageQuality: 25);
                                              if (photo != null) {
                                                setState(() {
                                                  imagePath = photo.path;
                                                  Navigator.pop(c);
                                                });
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
                                                  await _picker.pickImage(
                                                      source:
                                                          ImageSource.gallery,
                                                      maxHeight: 512,
                                                      maxWidth: 512,
                                                      imageQuality: 25);
                                              if (photo != null) {
                                                setState(() {
                                                  imagePath = photo.path;
                                                  Navigator.pop(c);
                                                });
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
                            child: imagePath == null
                                ? (editcontroller.databox.imageUrl.value ==
                                            null ||
                                        editcontroller.databox.imageUrl.value ==
                                            "")
                                    ? Icon(Icons.person)
                                    : Image.network(
                                        Configss.fileurl +
                                            editcontroller
                                                .databox.imageUrl.value,
                                        fit: BoxFit.cover)
                                : Image.file(File(imagePath!),
                                    fit: BoxFit.cover),
                          ),
                        )),
                    if (imagePath != null)
                      IconButton(
                          onPressed: () => setState(() => imagePath = null),
                          icon: Icon(Icons.close))
                  ],
                ),
              ),
              EnglishTextFilde(
                controller: editcontroller.userNameController,
                hint: AppLocalizations.of(context)!.translate(
                  'username',
                )!,
                errorttext: editcontroller.vlid.errorText.value,
              ),
              PublicTextFilde(
                controller: editcontroller.nameAliasController,
                hint: AppLocalizations.of(context)!.translate(
                  'name',
                )!,
              ),
              PublicTextFilde(
                  hint: berlinWallFell,
                  ontap: () async {
                    Jalali? picked = await showPersianDatePicker(
                      context: context,
                      initialDate: Jalali.now(),
                      firstDate: Jalali(1320, 1),
                      lastDate: Jalali.now(),
                    );
                    print(picked!.formatCompactDate());
                    berlinWallFell = picked.formatCompactDate();
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
                  /*    if (editcontroller.userNameController.text.isEmpty) {
                    return;
                  }*/

                  setState(() {
                    editcontroller.isApiCallProcess = true.obs;
                  });

                  if (imagePath != null) {
                    var response =
                        await apiService!.uploadProfileImage(imagePath!);
                    if (response != false) {
                      // editcontroller.databox.imageUrl.value = response;
                      imageuri = response;
                      //   Get.offAll(MyTabs());
                    } else {
                      apiService!.showSnackBar(
                        text: AppLocalizations.of(context)!.translate(
                          'UploadFaildImage',
                        )!,
                      );
                      return;
                    }
                  }

                  serpro!
                      .editprofileuser(
                    editcontroller.userNameController.text,
                    editcontroller.nameAliasController.text,
                    editcontroller.bioController.text,
                    imageuri.toString(),
                  )
                      .then((value) {
                    setState(() {
                      editcontroller.isApiCallProcess = false.obs;
                      editcontroller.databox.profilerequest();
                      Get.offAll(MyTabs());
                    });
                  });
                  apiService!
                      .AddOrEditUserAbandon(berlinWallFell)
                      .then((response) async {
                    if (response != false) {
                      apiService!.showSnackBar(text: response['message']);
                    } else {
                      apiService!.showSnackBar(text: response['message']);
                      setState(() {
                        editcontroller.isApiCallProcess = true.obs;
                      });
                    }
                  });
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
  }
}
