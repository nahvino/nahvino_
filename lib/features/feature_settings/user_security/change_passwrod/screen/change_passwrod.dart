import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/password_text_filde.dart';
import 'package:Nahvino/features/feature_auth/forgot_password/screen/check_question_answer_screen.dart';
import 'package:Nahvino/features/feature_profile/view_profile/screen/view_profile.dart';
import 'package:Nahvino/features/feature_settings/menu/screen/user_security_stting_menus.dart';
import 'package:Nahvino/features/feature_settings/user_security/change_passwrod/controllers/change_passwrod_controller.dart';
import 'package:Nahvino/features/feature_settings/user_security/change_passwrod/service/change_password_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswrod extends StatefulWidget {
  const ChangePasswrod({Key? key}) : super(key: key);

  @override
  State<ChangePasswrod> createState() => _ChangePasswrodState();
}

class _ChangePasswrodState extends State<ChangePasswrod> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  late ChangePasswordService change_password_service;
  ChangePasswrodController changepasswrodcontroller =
      Get.put(ChangePasswrodController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errortext;

  @override
  void initState() {
    super.initState();
    change_password_service = ChangePasswordService();
  }

  bool isApiCallProgress = true;
  bool lang = false; // en => true / fa => false
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(child: body(context)),
      ),
    );
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
                        change_password_service.ChangePasswrod(
                                currentPassword.text, newPassword.text)
                            .then((response) async {
                          setState(() {
                            isApiCallProgress = false;
                          });
                          if (currentPassword.text == newPassword.text) {
                            errortext = AppLocalizations.of(context)!.translate(
                              'tcpcbtstnp',
                            );
                          } else {
                            if (response != false) {
                              change_password_service.showSnackBar(
                                  text: response['message']);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewProfile()),
                                (route) => false,
                              );
                            } else {
                              change_password_service.showSnackBar(
                                  text: response['message']);
                            }
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
                Callout(
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
                                builder: (context) => CheckQuestionAnswerScreen()));
                      },
                      child: Footnate(
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
