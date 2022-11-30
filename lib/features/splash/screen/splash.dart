import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/shared/presentation/controllers/getx/Utils/check_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:Nahvino/config/lang/App_localizations.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  CheckController checkcontroller = Get.put(CheckController());
  @override
  void initState() {
    super.initState();
    checkcontroller.checkInternetConnection();
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
              SizedBox(child: Lottie.asset('assets/anim/splash/splash.json')),
              Container(
                  child: Subhead(
                color: Colors.black,
                textAlign: TextAlign.center,
                text: AppLocalizations.of(context)!.translate(
                  'TextSplashn',
                )!,
              )),
              Column(
                children: [
                  Callout(
                    color: Colors.black,
                    textAlign: TextAlign.center,
                    text: AppLocalizations.of(context)!.translate(
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
