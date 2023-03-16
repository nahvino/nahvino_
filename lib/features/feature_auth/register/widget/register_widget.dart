import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Button/arrow_back_button.dart';
import 'package:Nahvino/core/Utils/Button/close_button.dart';
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
import 'package:iconsax/iconsax.dart';

class RegisterWidget extends StatefulWidget {
  RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  RegisterController registerController = Get.put(RegisterController());
  String? securityQuestionselected;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Obx(() {
      return Column(
        children: [
          EnglishTextFilde(
            ontop: () {
              registerController.usernameController.selection =
                  TextSelection.collapsed(offset: registerController.usernameController.text.length);
            },
            hint: AppLocalizations.of(context)!.translate(
              'username',
            )!,
            controller: registerController.usernameController,
          ),
          SizedBox(
            height: 15,
          ),
          TextPassReAndLog(
            ontop: () {
              registerController.usernameController.selection =
                  TextSelection.collapsed(offset: registerController.usernameController.text.length);
            },
            hint: AppLocalizations.of(context)!.translate(
              'Password',
            )!,
            controller: registerController.passwordController,
          ),
          SizedBox(
            height: 15,
          ),
          DrapDoonButton(
            value: securityQuestionselected,
            onChanged: (value) {
              setState(() {
                securityQuestionselected = value as String;
                print(securityQuestionselected);
              });
              registerController.Questionselectedv.value =
                  securityQuestionselected!;
              print(registerController.Questionselectedv.value);
            },
          ),
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
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    CloseBotton(),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Callout(
                                  color: Colors.black,
                                  textAlign: TextAlign.right,
                                  text: AppLocalizations.of(context)!.translate(
                                    'Privacy_policy',
                                  )!,
                                ),
                              ],
                            ),
                            // actions: [
                            //   Buttonfull(
                            //       text: "بستن",
                            //       onPressed: () => Navigator.pop(context))
                            // ],
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
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    CloseBotton(),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Callout(
                                  color: Colors.black,
                                  textAlign: TextAlign.right,
                                  text: AppLocalizations.of(context)!.translate(
                                    'Privacy_policy',
                                  )!,
                                ),
                              ],
                            ),
                            // actions: [
                            //   Buttonfull(
                            //       text: "بستن",
                            //       onPressed: () => Navigator.pop(context))
                            // ],
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
          Padding(
            padding: EdgeInsets.only(right: height * 0.073),
            child: Visibility(
                visible: registerController.chackBoxSelect.value,
                child: Padding(
                  padding: EdgeInsets.only(right: 10, top: 12),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.minus_square,
                        color: Colors.deepOrange,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Caption1(text: "شما هنوز قوانین را نپذفته اید."),
                    ],
                  ),
                )),
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
                onPressed: () => registerController.register_btn()),
          ),
        ],
      );
    });
  }
}
