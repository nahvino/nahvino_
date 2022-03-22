import 'package:flutter/material.dart';
import 'package:nahvino/Pages/Account/login/Login.dart';
import 'package:nahvino/Pages/Account/login/Register.dart';
import '../Pages/Account/login/Otp_login_page.dart';
import '../app_localizations.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login/sinupbak.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.45,
                  right: 35,
                  left: 35),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate(
                      'Signup_top_text',
                    )!,
                    style: TextStyle(fontSize: 25, fontFamily: 'byekan'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.translate(
                        'SignIn_btn_text',
                      )!,
                      style: TextStyle(fontSize: 14, fontFamily: 'byekan'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton.icon(
                    onPressed: (() {}),
                    icon: Image.asset('assets/images/google.png'),
                    label: Text(
                      AppLocalizations.of(context)!.translate(
                        'Signup_google_btn',
                      )!,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'byekan',
                          color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      primary: Color.fromARGB(255, 255, 255, 255),
                      fixedSize: const Size(308, 50),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OutlinedButton.icon(
                    onPressed: (() {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhoneNumberPage()));
                    }),
                    icon: Image.asset('assets/images/phone.png'),
                    label: Text(
                      AppLocalizations.of(context)!.translate(
                        'Signup_phone_btn',
                      )!,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'byekan',
                          color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      primary: Color.fromARGB(255, 255, 255, 255),
                      fixedSize: const Size(308, 50),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OutlinedButton.icon(
                    onPressed: (() {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    }),
                    icon: Image.asset('assets/images/nahvino_logo.png'),
                    label: Text(
                      AppLocalizations.of(context)!.translate(
                        'Signup_nahvino_btn',
                      )!,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'byekan',
                          color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      primary: Color.fromARGB(255, 255, 255, 255),
                      fixedSize: const Size(308, 50),
                    ),
                  ),
                ],
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
