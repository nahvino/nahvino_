import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:nahvino/Model/user/user/viewprofile_request_model.dart';
import 'package:nahvino/Model/user/user/viewprofile_response_model.dart';

import '../../../Services/login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Widget/Text.dart';
import '../../../App_localizations.dart';
import 'Regulation.dart';

class WelcomeUser extends StatefulWidget {
  const WelcomeUser({Key? key}) : super(key: key);

  @override
  State<WelcomeUser> createState() => _WelcomeUserState();
}

class _WelcomeUserState extends State<WelcomeUser> {
  bool isApiCallProgress = true;
  GetProfileUserResponseModel? resultResponse;

  @override
  void initState() {
    super.initState();
    APIService.getprofileuser().then((response) {
      setState(() {
        isApiCallProgress = false;
        if(response != false){
          resultResponse = response;
        }
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  bool lang = false; // en => true / fa => false
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
            child: isApiCallProgress
                ? Center(
                    child: Lottie.asset('assets/anim/data.json',
                        height: 300, width: 300),
                  )
                : body(context)),
      ),
    );
  }

  Widget body(BuildContext context) => Column(
        children: [
          Card(
            margin: EdgeInsets.only(bottom: 6),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.height * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(resultResponse!.nameAlias ?? "Guest",
                            style: TextStyle(color: Colors.green)),
                        SizedBox(
                          width: 02,
                        ),
                    textspan(color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
                      'nahvinoismaslk',
                    )!,
                    ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(bottom: 6),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black12),
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        resultResponse!.nameAlias ?? "Guest",
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(resultResponse!.nameAlias ?? "Guest",
                            style: TextStyle(color: Colors.green)),
                        SizedBox(
                          width: 02,
                        ),
                        textspan(color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
                          'nahvinoismaslk',
                        )!,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 02,
                        ),
                        textspan(color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
                          'rankwellcomemani',
                        )!,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(resultResponse!.nameAlias ?? "Guest",
                            style: TextStyle(color: Colors.green)),
                        SizedBox(
                          width: 02,
                        ),
                        textspan(color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
                          'maslkamtiz',
                        )!,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50,),
                  Buttonfull(
                      text: AppLocalizations.of(context)!.translate(
                        'next',
                      )!,

                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Regulation()));
                      }, color: Colors.white,),
                ],
              ),
            ),
          ),
        ],
      );
}
