import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/english_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/password_text_filde.dart';
import 'package:Nahvino/features/registration/forgot_password/screen/check_question_answer.dart';
import 'package:Nahvino/features/registration/login/controllers/login_controller.dart';
import 'package:Nahvino/features/registration/main/screen/registration.dart';
import 'package:Nahvino/features/registration/register/screen/Register.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: Title3(
              color: Colors.black,
              textAlign: TextAlign.start,
              text: AppLocalizations.of(context)!.translate(
                'SignIn_top_text',
              )!),
          elevation: 0,
          backgroundColor: Colors.grey[50],
          leading: BackButton(
            color: Colors.black,
            onPressed: (() {
              loginController.cleartext();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Registration()));
            }),
          ),
        ),
        body: Obx(
          () => loginController.isApiCallProcess.value
              ? Center(
                  child: Lottie.asset(
                      'assets/anim/login/fingerprint-verification.json',
                      width: 300,
                      height: 300),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Center(
                            child: Lottie.asset(
                                'assets/anim/login/key-login.json',
                                height: 150,
                                width: 150),
                          ),
                          EnglishTextFilde(
                            icon: Icon(Icons.person),
                            suffixIcon: null,
                            prefixIcon: null,
                            hint: AppLocalizations.of(context)!.translate(
                              'username',
                            )!,
                            controller: loginController.usernameController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextPassReAndLog(
                            icon: Icon(Icons.lock),
                            passwordInVisible:
                                loginController.obscurePasswordVisibility.value,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  loginController
                                          .obscurePasswordVisibility.value =
                                      !loginController
                                          .obscurePasswordVisibility.value;
                                },
                                icon: Icon(
                                    loginController.obscurePasswordVisibility ==
                                            true
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                            hint: AppLocalizations.of(context)!.translate(
                              'Password',
                            )!,
                            controller: loginController.passwordController,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder:
                                              (context) => /*RegisterPage()*/ CheckQuestionAnswer()));
                                },
                                child: Caption1(
                                  color: Colors.cyan,
                                  textAlign: TextAlign.center,
                                  text: AppLocalizations.of(context)!.translate(
                                    'SignIn_fpass_text',
                                  )!,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()));
                                },
                                child: Caption1(
                                  color: Colors.cyan,
                                  textAlign: TextAlign.center,
                                  text: AppLocalizations.of(context)!.translate(
                                    'SignIn_btn_text',
                                  )!,
                                ),
                              ),
                            ],
                          ),
                          Buttonfull(
                              text: AppLocalizations.of(context)!.translate(
                                'OK',
                              )!,
                              onPressed: () {
                                /*     if (newLoginController
                              .usernameController.text.isEmpty) {
                            newLoginController.apiService.showSnackBar(
                                text: "نام کاربری نمی تواند خالی باشد");
                            return;
                          }*/
                                /*
                                newLoginController.isApiCallProcess.value =
                                    true;

                                newLoginController.apiService
                                    .NewLogin(
                                        newLoginController
                                            .usernameController.text,
                                        newLoginController
                                            .passwordController.text)
                                    .then((response) async {
                                  newLoginController.isApiCallProcess.value =
                                      false;

                                  if (response != false) {
                                    newLoginController.logindata =
                                        await SharedPreferences.getInstance();
                                    await newLoginController.logindata
                                        .setString(
                                            "token",
                                            response['data']['userToken']
                                                ['token']);
                                    await newLoginController.logindata
                                        .setString(
                                            "userId", response['data']['id']);

                                    newLoginController.apiService.showSnackBar(
                                        text: AppLocalizations.of(context)!
                                            .translate(
                                      'Welcome',
                                    )!);

                                    //  await Future.delayed(Duration(seconds: 2));

                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyTabs()),
                                      (route) => false,
                                    );
                                  } else {
                                    newLoginController.apiService.showSnackBar(
                                        text: response['message']);
                                  }
                                });*/
                                if (!_formKey.currentState!.validate()) {
                                } else {
                                  loginController.login();
                                  //loginController.isApiCallProcess.value = true;
                                }
                                loginController.cleartext();
                                // loginController.isApiCallProcess.value = false;
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }
}
