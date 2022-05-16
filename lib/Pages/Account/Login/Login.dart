import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:Nahvino/controllers/getx/new_login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../App_localizations.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/Text.dart';
import '../../../Utils/Text/TextField.dart';
import '../../../tabs.dart';

import 'CheckQuestionAnswer.dart';
import 'SignUp.dart';

class NewLogin extends StatefulWidget {
  const NewLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<NewLogin> createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  NewLoginController newLoginController = Get.put(NewLoginController());

  @override
  void initState() {
    super.initState();
    newLoginController.apiService = APIService(context);
  }

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
              newLoginController.cleartext();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            }),
          ),
        ),
        body: Obx(
              () => newLoginController.isApiCallProcess.value
              ? Center(
            child: Lottie.asset(
                'assets/anim/login/fingerprint-verification.json',
                width: 300,
                height: 300),
          )
              : SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Lottie.asset(
                        'assets/anim/login/key-login.json',
                        height: 150,
                        width: 150),
                  ),
                  TextAll(
                    icon: Icon(Icons.person),
                    suffixIcon: null,
                    prefixIcon: null,
                    hint: AppLocalizations.of(context)!.translate(
                      'username',
                    )!,
                    controller: newLoginController.usernameController,
                  ),
                  TextPassReAndLog(
                    icon: Icon(Icons.lock),
                    passwordInVisible: newLoginController
                        .obscurePasswordVisibility.value,
                    suffix: IconButton(
                        onPressed: () {
                          newLoginController
                              .obscurePasswordVisibility.value =
                          !newLoginController
                              .obscurePasswordVisibility.value;
                        },
                        icon: Icon(newLoginController
                            .obscurePasswordVisibility ==
                            true
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    hint: AppLocalizations.of(context)!.translate(
                      'Password',
                    )!,
                    controller: newLoginController.passwordController,
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
                      color: Colors.black,
                      textAlign: TextAlign.center,
                      text: AppLocalizations.of(context)!.translate(
                        'SignIn_fpass_text',
                      )!,
                    ),
                  ),
                  Buttontest(
                      text: AppLocalizations.of(context)!.translate(
                        'OK',
                      )!,
                      onPressed: () {
                        if (newLoginController
                            .usernameController.text.isEmpty) {
                          newLoginController.apiService.showSnackBar(
                              text: "نام کاربری نمی تواند خالی باشد");
                          return;
                        }

                        newLoginController.isApiCallProcess.value = true;

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
                            await newLoginController.logindata.setString(
                                "token",
                                response['data']['userToken']['token']);
                            await newLoginController.logindata.setString(
                                "userId", response['data']['id']);

                            newLoginController.apiService.showSnackBar(
                                text: AppLocalizations.of(context)!
                                    .translate(
                                  'Welcome',
                                )!);

                            //await Future.delayed(Duration(seconds: 2));

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyTabs()),
                                  (route) => false,
                            );
                          } else {
                            newLoginController.apiService
                                .showSnackBar(text: response['message']);
                          }
                        });
                      }),
                ],
              ),
            ),
          ),
        ));
  }

}
