import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nahvino/Pages/Account/login/sign_up.dart';
import 'package:nahvino/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_localizations.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(child: Lottie.asset('assets/splash/animtiopsh.json')),
            Container(
                child: Text(
              AppLocalizations.of(context)!.translate(
                'TextSplashn',
              )!,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'byekan'),
            )),
            Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.translate(
                    'TextSplash',
                  )!,
                  style: TextStyle(fontSize: 18, fontFamily: 'byekan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
