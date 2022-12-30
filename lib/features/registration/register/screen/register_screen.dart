import 'package:Nahvino/config/generated/assets.dart';
import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/english_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/password_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/question_text_filde.dart';
import 'package:Nahvino/core/Utils/drop_down/dropdownbtn.dart';
import 'package:Nahvino/features/registration/login/screen/login_screen.dart';
import 'package:Nahvino/features/registration/main/screen/privacy_screen.dart';
import 'package:Nahvino/features/registration/main/screen/terms_services_screen.dart';
import 'package:Nahvino/features/registration/register/controllers/register_controller.dart';
import 'package:Nahvino/features/registration/register/service/register_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({
    Key? key,
  }) : super(key: key);

  RegisterController registerController = Get.put(RegisterController());

  late RegisterService seregister;
  bool obscurePasswordVisibility = true;
  late SharedPreferences logindata;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Obx(() {
      return Container(
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.reg_background), fit: BoxFit.cover),
        ),
        child: registerController.animationShow.value
            ? Center(
                child: Lottie.asset(Assets.application_successfully,
                    height: 300, width: 300),
              )
            : SafeArea(
                child: Form(
                key: registerController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30, top: 30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // Lottie.asset('assets/anim/login/contract.json',
                                //     height: 150, width: 150),
                              ],
                            ),
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
                                value:
                                    registerController.Questionselected.value,
                                onChanged: (value) {
                                  registerController.Questionselected.value =
                                      value;
                                  print(registerController
                                      .Questionselected.value);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Caption1(
                                    color: Colors.black,
                                    textAlign: TextAlign.center,
                                    text: "قبلا ثبت نام کرده اید؟",
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    },
                                    child: Caption1(
                                      color: Colors.cyan,
                                      textAlign: TextAlign.center,
                                      text: "به صفحه ورود بروید",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.to(TermsservicesScreen());
                                  },
                                  child: Caption1(
                                    color: Colors.cyan,
                                    textAlign: TextAlign.center,
                                    text:
                                        AppLocalizations.of(context)!.translate(
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
                                    Get.to(PrivacyScreen());
                                  },
                                  child: Caption1(
                                    color: Colors.cyan,
                                    textAlign: TextAlign.center,
                                    text:
                                        AppLocalizations.of(context)!.translate(
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
                              width: 150,
                              child: Buttonfull(
                                  text: AppLocalizations.of(context)!.translate(
                                    'OK',
                                  )!,
                                  onPressed: () {
                                    if (!registerController
                                        .formKey.currentState!
                                        .validate()) {
                                    } else {
                                      /*
                                     setState(() {
                                       isApiCallProcess = true;
                                     });
                                     seregister.Register(
                                             usernameController.text,
                                             passwordController.text,
                                             securityQuestionselected as String,
                                             sqAnswerController.text)
                                         .then((response) async {
                                       if (response != false) {
                                         logindata =
                                             await SharedPreferences.getInstance();
                                         await logindata.setString("token",
                                             response['data']['userToken']['token']);
                                         await logindata.setString(
                                             "userId", response['data']['id']);

                                         seregister.showSnackBar(
                                             text: AppLocalizations.of(context)!
                                                 .translate(
                                           'Welcome',
                                         )!);

                                         Navigator.pushAndRemoveUntil(
                                           context,
                                           MaterialPageRoute(
                                               builder: (context) => AddIntroduced()),
                                           (route) => false,
                                         );
                                       } else {
                                         setState(() {
                                           isApiCallProcess = false;
                                         });
                                         seregister.showSnackBar(
                                             text: response['message']);
                                       }
                                     });*/
                                      registerController.register();
                                      registerController.cleartext();
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
      );
    });
  }
}
