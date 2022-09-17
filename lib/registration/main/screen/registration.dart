import 'package:Nahvino/registration/login/screen/Login.dart';
import 'package:Nahvino/registration/otp/screen/otp_phone.dart';
import 'package:Nahvino/registration/register/screen/Register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Utils/Button/Button.dart';
import '../../../../Utils/Text/Text.dart';
import '../../../../App_localizations.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _Registration();
}

class _Registration extends State<Registration> {
  @override
  void initState() {
    super.initState();
  }

  culercash() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    print(preferences.getString("userId"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login/sin.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Image.asset(
                alignment: Alignment.center,
                'assets/images/login/logo_top.png'),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.45,
                  right: 35,
                  left: 35),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                 
                    SizedBox(
                      height: 20,
                    ),
                    ButtonSignUP(
                      text: AppLocalizations.of(context)!.translate(
                        'Signup_phone_btn',
                      )!,
                      onPressed: () {
                        culercash();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder:
                                    (context) => /*PhoneNumberPage()*/ OtpPhone()));
                      },
                      icon: Icon(
                        Icons.phone_android_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
          
                    ButtonSignUP(
                      text: AppLocalizations.of(context)!.translate(
                        'Signup_nahvino_btn',
                      )!,
                      onPressed: () {
                        culercash();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login()));
                      },
                      icon: Image.asset('assets/images/login/logo.png',
                          width: 30, height: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Caption1(
                            color: Colors.black,
                            textAlign: TextAlign.center,
                            text: AppLocalizations.of(context)!.translate(
                              'Register_top_text',
                            )!,
                          ),
                          TextButton(
                            onPressed: () {
                              culercash();
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
