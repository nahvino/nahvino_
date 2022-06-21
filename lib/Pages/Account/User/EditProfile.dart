import 'dart:io';
import 'package:Nahvino/Services/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:Nahvino/Model/user/user/viewprofile_response_model.dart';
import 'package:Nahvino/Pages/Account/User/ViewProfile.dart';
import 'package:Nahvino/Services/login/ApiService.dart';
import 'package:Nahvino/tabs.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/Text.dart';
import '../../../Utils/Text/TextField.dart';
import '../../../App_localizations.dart';
import '../../../Utils/TextField/englishtextfilde.dart';
import '../../../Utils/TextField/publictextfilde.dart';
import '../../../Utils/Validator/validator.dart';

class EditProfile extends StatefulWidget {
  final GetProfileUserResponseModel model;

  EditProfile({Key? key, required this.model}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  final alphanumeric = RegExp("[A-Z a-z 0-9]");
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameAliasController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController tarikhController = TextEditingController();
  Validator vlid = Get.put(Validator()); // controller
  String? imagePath;
  final ImagePicker _picker = ImagePicker();
  APIService? apiService;
  late String berlinWallFell = "تاریخ ترک";
  String? error;
  void initState() {
    super.initState();
    apiService = APIService(context);
    userNameController =
        TextEditingController(text: widget.model.userName ?? "");
    nameAliasController =
        TextEditingController(text: widget.model.nameAlias ?? "");
    bioController = TextEditingController(text: widget.model.bio ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Footnate(text: widget.model.userName),
          ],
        ),
        leading: BackButton(
          onPressed: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ViewProfile()));
          }),
        ),
      ),
      body: isApiCallProcess
          ? Center(
              child: Lottie.asset('assets/anim/user/submit-smile.json',
                  height: 300, width: 300),
            )
          : SafeArea(
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
                                                    AppLocalizations.of(
                                                            context)!
                                                        .translate(
                                                      'Camera',
                                                    )!,
                                                  ),
                                                  onTap: () async {
                                                    final XFile? photo =
                                                        await _picker.pickImage(
                                                            source: ImageSource
                                                                .camera,
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
                                                    AppLocalizations.of(
                                                            context)!
                                                        .translate(
                                                      'Gallery',
                                                    )!,
                                                  ),
                                                  onTap: () async {
                                                    final XFile? photo =
                                                        await _picker.pickImage(
                                                            source: ImageSource
                                                                .gallery,
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
                                      ? (widget.model.imageUrl == null ||
                                              widget.model.imageUrl == "")
                                          ? Icon(Icons.person)
                                          : Image.network(
                                              configss.fileurl +
                                                  widget.model.imageUrl!,
                                              fit: BoxFit.cover)
                                      : Image.file(File(imagePath!),
                                          fit: BoxFit.cover),
                                ),
                              )),
                          if (imagePath != null)
                            IconButton(
                                onPressed: () =>
                                    setState(() => imagePath = null),
                                icon: Icon(Icons.close))
                        ],
                      ),
                    ),
                    EnglishTextFilde(
                      controller: userNameController,
                      hint: AppLocalizations.of(context)!.translate(
                        'username',
                      )!,
                      errorttext: vlid.errorText.value,
                    ),
                    PublicTextFilde(
                      controller: nameAliasController,
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
                      controller: bioController,
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
                        if (userNameController.text.isEmpty) {
                          print("thvsd");
                          return;
                        }
                        
                        setState(() {
                          isApiCallProcess = true;
                        });

                        if (imagePath != null) {
                          var response =
                              await apiService?.uploadProfileImage(imagePath!);
                          if (response != false) {
                            widget.model.imageUrl = response;
                          } else {
                            apiService!.showSnackBar(
                              text: AppLocalizations.of(context)!.translate(
                                'UploadFaildImage',
                              )!,
                            );
                            return;
                          }
                        }
                        widget.model.imageUrl ??= "";
                        widget.model.userName = userNameController.text;
                        widget.model.nameAlias = nameAliasController.text;
                        widget.model.bio = bioController.text;

                        apiService!.editprofileuser(widget.model).then((value) {
                          setState(() {
                            isApiCallProcess = false;
                            Get.offAll(MyTabs());
                          });
                          
                        });
                        apiService?.AddOrEditUserAbandon(berlinWallFell)
                            .then((response) async {
                          if (response != false) {
                            apiService?.showSnackBar(text: response['message']);
                          } else {
                            apiService?.showSnackBar(text: response['message']);
                            setState(() {
                              isApiCallProcess = true;
                            });
                          }
                        });
                      },
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /* Buttonfull(
                        text: AppLocalizations.of(context)!
                            .translate('Date_of_departure')!,
                        onPressed: () async {
                          Jalali? picked = await showPersianDatePicker(
                            context: context,
                            initialDate: Jalali.now(),
                            firstDate: Jalali(1320, 1),
                            lastDate: Jalali.now(),

                          );
                          print(picked!.formatCompactDate());
                          /*var time = await showPersianTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );*/
                          final berlinWallFell = picked.formatCompactDate();
                          //berlinWallFell.toUtc();
                          //print(berlinWallFell.toString());
                          //print(time.toString());
                          //String formattedDate = time.toString()+berlinWallFell.toString();

                          // final output = time.replaceAll(RegExp('[^0-9]'));
                          // setState(() {
                          //   time = output as TimeOfDay?;
                          // });
                          // print(output.toString());

                          // String formattedDate =intl.DateFormat.yMMMd().format(time) as TimeOfDay; +berlinWallFell;
                          //print(formattedDate);    // apiService.AddOrEditUserAbandon()
                          setState(() {
                            isApiCallProcess = true;
                          });
                          apiService?.AddOrEditUserAbandon(berlinWallFell)
                              .then((response) async {

                            if (response != false) {
                              apiService?.showSnackBar(
                                  text: response['message']);
                                Get.offAll(MyTabs());

                            } else {
                              apiService?.showSnackBar(
                                  text: response['message']);
                              setState(() {
                                isApiCallProcess = true;
                              });

                            }
                          });

                        },
                        color: Colors.white,
                      ),*/
                  ],
                ),
              ),
            ),
    );
  }
}
