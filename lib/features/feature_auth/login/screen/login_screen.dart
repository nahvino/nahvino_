import 'package:Nahvino/config/generated/assets.dart';
import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/english_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/password_text_filde.dart';
import 'package:Nahvino/features/feature_auth/forgot_password/screen/check_question_answer_screen.dart';
import 'package:Nahvino/features/feature_auth/login/controllers/login_controller.dart';
import 'package:Nahvino/features/feature_auth/register/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  // const NewLogin({
  //   Key? key,
  // }) : super(key: key);

  LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.reg_background),
                fit: BoxFit.cover),
          ),
          child: Obx(
            () => loginController.isApiCallProcess.value
                ? Center(
                    child: Lottie.asset(
                        Assets.verification_login,
                        width: 300,
                        height: 300),
                  )
                : SafeArea(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                Container(
                      decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(45),topRight: Radius.circular(45))
                      ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Column(
                                children: [
                                  EnglishTextFilde(
                                    hint:
                                        AppLocalizations.of(context)!.translate(
                                      'username',
                                    )!,
                                    controller:
                                        loginController.usernameController,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextPassReAndLog(
                                    hint:
                                        AppLocalizations.of(context)!.translate(
                                      'Password',
                                    )!,
                                    controller:
                                        loginController.passwordController,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ///باتن شیت فراموشی رمز عبور
                                      TextButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20.0),
                                                  topRight: Radius.circular(20.0),
                                                ),
                                              ),
                                              context: context,
                                              builder: (context) => CheckQuestionAnswerScreen());
                                        },
                                        child: Caption1(
                                          color: Colors.cyan,
                                          textAlign: TextAlign.center,
                                          text: AppLocalizations.of(context)!
                                              .translate(
                                            'SignIn_fpass_text',
                                          )!,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterScreen()));
                                        },
                                        child: Caption1(
                                          color: Colors.cyan,
                                          textAlign: TextAlign.center,
                                          text: AppLocalizations.of(context)!
                                              .translate(
                                            'SignIn_btn_text',
                                          )!,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Buttonfull(
                                        text: AppLocalizations.of(context)!
                                            .translate(
                                          'OK',
                                        )!,
                                        onPressed: () {
                                          if (!_formKey.currentState!
                                              .validate()) {
                                          } else {
                                            loginController.login();
                                            //loginController.isApiCallProcess.value = true;
                                          }
                                         /// loginController.cleartext();
                                          // loginController.isApiCallProcess.value = false;
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          )),
    );
  }
}
