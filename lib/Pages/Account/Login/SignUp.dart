import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nahvino/Pages/Account/User/EditProfile.dart';
import 'package:nahvino/Pages/Account/login/SignIn.dart';
import 'package:nahvino/Pages/Account/login/Register.dart';
import '../../../Utils/Widget/Text.dart';
import 'NewLogin.dart';
import 'NewOtpPhone.dart';
import 'NewRegister.dart';
import 'OtpLogin.dart';
import '../../../App_localizations.dart';
import 'package:connectivity/connectivity.dart';

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    textspan(color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
                      'Signup_top_text',
                    )!,


                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => /*RegisterPage()*/ NewRegister()));
                      },
                      child: textspan(color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
                        'SignIn_btn_text',
                      )!,


                      ),
                    ),
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
                    SizedBox(
                      height: 20,
                    ),
                    OutlinedButton.icon(
                      onPressed: (() {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => /*SignIn()*/ NewLogin()));
                      }),
                      icon: Image.asset('assets/images/nahvino_logo.png'),
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

/*
 void  _checkInternetConnectiviy(BuildContext context) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      GetSnackBar(
        title: "اعلان",
        message: "به اینترنت متصل نیستید",
      );
    } else if (result == ConnectivityResult.mobile) {
      GetSnackBar(
        title: "اعلان",
        message: "به اینترنت موبایل متصل هستید",
      );
    } else if (result == ConnectivityResult.wifi) {
      GetSnackBar(
        title: "اعلان",
        message: "به اینترنت وای فا متصل هستید",
      );
    }
  }
  */
}
