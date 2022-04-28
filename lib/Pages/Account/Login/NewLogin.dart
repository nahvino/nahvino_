import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../App_localizations.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Button/TextField.dart';
import '../../../Utils/Widget/Text.dart';
import '../../../tabs.dart';
import '../User/ViewProfile.dart';
import 'CodeOtpPhoneNew.dart';
import 'NewCheckQuestionAnswer.dart';
import 'SignUp.dart';

class NewLogin extends StatefulWidget {
  const NewLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<NewLogin> createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  bool isApiCallProcess = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late APIService apiService;
  late SharedPreferences logindata;

  String? userToken;
  String? token;

  @override
  void initState() {
    super.initState();
    apiService = APIService(context);
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          }),
        ),
      ),
      body: isApiCallProcess
          ? Center(
              child: Lottie.asset('assets/anim/login/fingerprint-verification.json',
                  width: 300, height: 300),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Lottie.asset('assets/anim/login/key-login.json',
                          height: 150, width: 150),
                    ),
                    TextOtpPhone(
                      icon: Icon(Icons.person),
                      suffixIcon: null,
                      prefixIcon: null,
                      hint: AppLocalizations.of(context)!.translate(
                        'username',
                      )!,
                      controller: usernameController,
                    ),
                    TextOtpPhone(
                      icon: Icon(Icons.lock),
                      suffixIcon: null,
                      prefixIcon: null,
                      hint: AppLocalizations.of(context)!.translate(
                        'Password',
                      )!,
                      controller: passwordController,
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
                          if (usernameController.text.isEmpty) {
                            apiService.showSnackBar(text: "filed is empty!");
                            return;
                          }

                          setState(() {
                            isApiCallProcess = true;
                          });
                          apiService.NewLogin(usernameController.text,
                                  passwordController.text)
                              .then((response) async {
                            setState(() {
                              isApiCallProcess = false;
                            });
                            if (response != false) {
                              logindata = await SharedPreferences.getInstance();
                              await logindata.setString("token",
                                  response['data']['userToken']['token']);
                              await logindata.setString(
                                  "userId", response['data']['id']);

                              apiService.showSnackBar(
                                //Todo توکن
                                  text: "به جای توکن");

                              //await Future.delayed(Duration(seconds: 2));

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyTabs()),
                                (route) => false,
                              );
                            } else {
                              apiService.showSnackBar(
                                  text: response['message']);
                            }
                          });
                        }),
                  ],
                ),
              ),
            ),
    );
  }
}
