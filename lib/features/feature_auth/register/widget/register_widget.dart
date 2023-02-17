import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/english_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/password_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/question_text_filde.dart';
import 'package:Nahvino/core/Utils/drop_down/dropdownbtn.dart';
import 'package:Nahvino/features/feature_auth/login/screen/login_screen.dart';
import 'package:Nahvino/features/feature_auth/main/screen/privacy_screen.dart';
import 'package:Nahvino/features/feature_auth/main/screen/terms_services_screen.dart';
import 'package:Nahvino/features/feature_auth/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterWidget extends StatelessWidget {
  RegisterWidget({Key? key}) : super(key: key);
  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Obx(() {
      return Column(
        children: [
          EnglishTextFilde(
            hint: AppLocalizations.of(context)!.translate(
              'username',
            )!,
            controller: registerController.usernameController,
          ),
          SizedBox(
            height: 15,
          ),
          TextPassReAndLog(
            hint: AppLocalizations.of(context)!.translate(
              'Password',
            )!,
            controller: registerController.passwordController,
          ),
          SizedBox(
            height: 15,
          ),
          DrapDoonButton(
              value: registerController.Questionselected?.value,
              onChanged: (value) {
                registerController.Questionselectedv.value = value;
                print(registerController.Questionselectedv.value);
              }),
          SizedBox(
            height: 15,
          ),
          QuestionTextFilde(
            hint: AppLocalizations.of(context)!.translate(
              'sqAnswer',
            )!,
            controller: registerController.sqAnswerController,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 35,
              left: 39,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Caption1(
                  color: Colors.black,
                  textAlign: TextAlign.center,
                  text: "قبلا ثبت نام کرده اید؟",
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Caption1(
                    color: Colors.cyan,
                    textAlign: TextAlign.center,
                    text: "ورود",
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                child: Checkbox(
                  value: this.registerController.chackvaule.value,
                  onChanged: (value) {
                    this.registerController.chackvaule.value = value!;
                    registerController.chackBoxSelect.value = false;
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => new AlertDialog(
                            title: Callout(
                              color: Colors.black,
                              textAlign: TextAlign.right,
                              text: AppLocalizations.of(context)!.translate(
                                'Privacy_policy',
                              )!,
                            ),
                            actions: [
                              Buttonfull(
                                  text: "بستن",
                                  onPressed: () => Navigator.pop(context))
                            ],
                            content: TermsservicesScreen(),
                          ));
                },
                child: Caption1(
                  color: Colors.cyan,
                  textAlign: TextAlign.center,
                  text: AppLocalizations.of(context)!.translate(
                    'Termsandservices',
                  )!,
                ),
              ),
              Caption1(
                color: Colors.black,
                textAlign: TextAlign.center,
                text: AppLocalizations.of(context)!.translate(
                  'And',
                )!,
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => new AlertDialog(
                            title: Callout(
                              color: Colors.black,
                              textAlign: TextAlign.right,
                              text: AppLocalizations.of(context)!.translate(
                                'Privacy_policy',
                              )!,
                            ),
                        actions: [
                          Buttonfull(
                              text: "بستن",
                              onPressed: () => Navigator.pop(context))
                        ],
                            content: PrivacyScreen(),
                          ));
                },
                child: Caption1(
                  color: Colors.cyan,
                  textAlign: TextAlign.center,
                  text: AppLocalizations.of(context)!.translate(
                    'Privacy',
                  )!,
                ),
              ),
              Caption1(
                color: Colors.black,
                textAlign: TextAlign.center,
                text: AppLocalizations.of(context)!.translate(
                  'IAccept',
                )!,
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
            width: 150,
            child: Buttonfull(
                text: AppLocalizations.of(context)!.translate(
                  'OK',
                )!,
                onPressed: () => registerController.register_btn(context)),
          ),
        ],
      );
    });
  }
}
