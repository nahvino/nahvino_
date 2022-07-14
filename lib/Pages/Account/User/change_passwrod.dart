import 'package:flutter/material.dart';
import 'package:Nahvino/Pages/Account/User/view_profile.dart';
import 'package:get/get.dart';
import '../../../Services/login/ApiService.dart';
import '../../../Utils/Text/Text.dart';
import '../../../App_localizations.dart';
import '../../../Utils/TextField/password_text_filde.dart';
import '../../../controllers/getx/user/change_passwrod_controller.dart';
import '../Login/check_question_answer.dart';
import 'user_security_stting_menus.dart';

class ChangePasswrod extends StatefulWidget {
  const ChangePasswrod({Key? key}) : super(key: key);

  @override
  State<ChangePasswrod> createState() => _ChangePasswrodState();
}

class _ChangePasswrodState extends State<ChangePasswrod> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  late APIService apiService;
  ChangePasswrodController changepasswrodcontroller =
      Get.put(ChangePasswrodController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    apiService = APIService(context);
  }

  bool isApiCallProgress = true;
  bool lang = false; // en => true / fa => false
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: SafeArea(child: body(context)),
        ),
      );
    });
  }

  Widget body(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    onPressed: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserSecuritySttingMenus()));
                    }),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.task_alt),
                    onPressed: (() {
                      /* if (currentPassword.text.isEmpty) {
                        apiService.showSnackBar(
                            text: AppLocalizations.of(context)!.translate(
                          'ValidPassword',
                        )!);
                        return;
                      }

                      if (newPassword.text.isEmpty) {
                        apiService.showSnackBar(
                            text: AppLocalizations.of(context)!.translate(
                          'ValidPassword',
                        )!);
                        return;
                      }*/

                      if (!_formKey.currentState!.validate()) {
                      } else {
                        apiService.ChangePasswrod(
                                currentPassword.text, newPassword.text)
                            .then((response) async {
                          setState(() {
                            isApiCallProgress = false;
                          });
                          if (response != false) {
                            apiService.showSnackBar(text: response['message']);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewProfile()),
                              (route) => false,
                            );
                          } else {
                            apiService.showSnackBar(text: response['message']);
                          }
                        });
                      }
                    }),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textspan(
                  textAlign: TextAlign.center,
                  text: AppLocalizations.of(context)!.translate(
                    'text_ChangePasswrod',
                  )!,
                  color: Colors.black,
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*  TextProfile(
                controller: currentPassword,
                hint: AppLocalizations.of(context)!.translate(
                  'textfilde_currentPassword',
                )!,
              ),*/
                    TextPassReAndLog(
                      icon: Icon(Icons.lock),
                      passwordInVisible: changepasswrodcontroller
                          .obscurecurrentPasswordVisibility.value,
                      suffix: IconButton(
                          onPressed: () {
                            changepasswrodcontroller
                                    .obscurecurrentPasswordVisibility.value =
                                !changepasswrodcontroller
                                    .obscurecurrentPasswordVisibility.value;
                          },
                          icon: Icon(changepasswrodcontroller
                                      .obscurecurrentPasswordVisibility ==
                                  true
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      hint: AppLocalizations.of(context)!.translate(
                        'textfilde_currentPassword',
                      )!,
                      controller: currentPassword,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NewCheckQuestionAnswer()));
                      },
                      child: textspan(
                        color: Colors.blue,
                        textAlign: TextAlign.center,
                        text: AppLocalizations.of(context)!.translate(
                          'SignIn_fpass_text',
                        )!,
                      ),
                    ),
                    /* TextProfile(
                controller: newPassword,
                hint: AppLocalizations.of(context)!.translate(
                  'textfilde_newPassword',
                )!,
              ),*/
                    TextPassReAndLog(
                      icon: Icon(Icons.lock),
                      passwordInVisible: changepasswrodcontroller
                          .obscurenewPasswordVisibility.value,
                      suffix: IconButton(
                          onPressed: () {
                            changepasswrodcontroller
                                    .obscurenewPasswordVisibility.value =
                                !changepasswrodcontroller
                                    .obscurenewPasswordVisibility.value;
                          },
                          icon: Icon(changepasswrodcontroller
                                      .obscurenewPasswordVisibility ==
                                  true
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      hint: AppLocalizations.of(context)!.translate(
                        'textfilde_newPassword',
                      )!,
                      controller: newPassword,
                    ),
                  ]),
            )
          ],
        ),
      );
}
