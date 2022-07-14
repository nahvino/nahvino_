import 'package:Nahvino/Data/Local/version_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/Text.dart';
import 'login.dart';
import 'otp_phone.dart';
import 'register.dart';
import '../../../App_localizations.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _Registration();
}

class _Registration extends State<Registration> {
  // VersionData checkversion = Get.put(VersionData());
  // chaklogin() async {
  //   bool result = await InternetConnectionChecker().hasConnection;
  //   if (result == true) {
  //     checkversion.checkVersioEixt();
  //   }
  // }

  @override
  void initState() {
    super.initState();
   // chaklogin();
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
                    /*    textspan(color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
                      'Signup_top_text',
                    )!,
                    ),*/

                    const SizedBox(
                      height: 20,
                    ),
                    /*    OutlinedButton.icon(
                      onPressed: (() {
                        //DialogHelper.rules(context);
                      }),
                      icon: Image.asset('assets/images/google.png'),
                      label: textspan(color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
                        'Signup_google_btn',
                      )!,
                     ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: Color.fromARGB(255, 255, 255, 255),
                        fixedSize: const Size(308, 50),
                      ),
                    ),*/
                    SizedBox(
                      height: 20,
                    ),
                    /*
                    OutlinedButton.icon(
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => /*PhoneNumberPage()*/ OtpPhoneNew()));
                      }),
                      icon: Image.asset('assets/images/phone.png'),
                      label: textspan(color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
                        'Signup_phone_btn',
                      )!,


                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: Color.fromARGB(255, 255, 255, 255),
                        fixedSize: const Size(308, 50),
                      ),
                    ),
*/
                    ButtonSignUP(
                      text: AppLocalizations.of(context)!.translate(
                        'Signup_phone_btn',
                      )!,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder:
                                    (context) => /*PhoneNumberPage()*/ OtpPhoneNew()));
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
                    /*          OutlinedButton.icon(
                      onPressed: (() {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => /*SignIn()*/ NewLogin()));
                      }),
                      icon: Image.asset('assets/images/login/logo.png',
                          height: 40, width: 40),
                      label: textspan(
                        color: Colors.black,
                        textAlign: TextAlign.center,
                        text: AppLocalizations.of(context)!.translate(
                          'Signup_nahvino_btn',
                        )!,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: Color.fromARGB(255, 255, 255, 255),
                        fixedSize: const Size(308, 50),
                      ),
                    ),
*/
                    ButtonSignUP(
                      text: AppLocalizations.of(context)!.translate(
                        'Signup_nahvino_btn',
                      )!,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => /*SignIn()*/ NewLogin()));
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
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder:
                                          (context) => /*RegisterPage()*/ NewRegister()));
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
/*
            Container(
            ),
            */
          ],
        ),
      ),
    );
  }
}
