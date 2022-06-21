import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../App_localizations.dart';
import '../Services/login/ApiService.dart';
import '../Utils/Button/Button.dart';
import '../Utils/Text/TextField.dart';
import '../Utils/TextField/publictextfilde.dart';
import '../main.dart';
import 'Account/Login/SignUp.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  var resultResponsee;
  bool isApiCallProgress = true;
  TextEditingController tokenController = TextEditingController();
  SharedPreferences? toooo;
  var tl;
  void tos() async {
    toooo = await SharedPreferences.getInstance();
    String? tOken = toooo!.getString('firebasetoken');
    tl = tOken;
  }

  String? end;

  @override
  void initState() {
    super.initState();
    tos();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Buttonfull(
              text: "توکن",
              onPressed: () {
                Share.share(tl);
              },
              color: Colors.amber),
          ButtonSignUP(
            text: "sas",
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                    title: Text(AppLocalizations.of(context)!.translate(
                      'apptitle',
                    )!),
                    content: Text(AppLocalizations.of(context)!.translate(
                      'quExit',
                    )!),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(
                            context,
                            AppLocalizations.of(context)!.translate(
                              'Cancel',
                            )!),
                        child: Text(
                          AppLocalizations.of(context)!.translate(
                            'Cancel',
                          )!,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final preferences =
                              await SharedPreferences.getInstance();
                          await preferences.clear();
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            // exit(0);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                              (route) => false,
                            );
                          });
                        },
                        child: Text(AppLocalizations.of(context)!.translate(
                          'OK',
                        )!),
                      ),
                    ]),
              );
            },
            icon: Icon(
              Icons.phone_android_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
