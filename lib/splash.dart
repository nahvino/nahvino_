import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:Nahvino/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../App_localizations.dart';
import 'Pages/Account/login/SignUp.dart';
import 'Utils/Widget/Text.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  SharedPreferences? preferences;
  Future checkLogin() async {
    await Future.delayed(Duration(seconds: 3));
    preferences = await SharedPreferences.getInstance();
    String? token = preferences!.getString("token");
    if (token != null) {
      // todo : check auth
      /// true
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyTabs()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignUp()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(child: Lottie.asset('assets/splash/animtiopsh.json')),
              Container(
                  child: textbold(

               color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
                    'TextSplashn',
                  )!,
              )),
              Column(
                children: [
                  textspan(
                      color: Colors.black, textAlign: TextAlign.center, text:AppLocalizations.of(context)!.translate(
                    'TextSplash',
                  )!,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
