import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:Nahvino/Model/user/user/viewprofile_request_model.dart';
import 'package:Nahvino/Model/user/user/viewprofile_response_model.dart';

import '../../../Services/Login/User/Config.dart';
import '../../../Services/login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/Text.dart';
import '../../../App_localizations.dart';
import '../../../tabs.dart';
import 'Pandect.dart';

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

  Widget body(BuildContext context) => SingleChildScrollView(
    child: Column(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Callout(color: Colors.green, textAlign: TextAlign.center, text:  resultResponse!.userName!
                            ),
                          ),

                          SizedBox(
                            width: 02,
                          ),
                          Footnate(color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
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
                        (resultResponse!.parentImageUrl != null &&
                            resultResponse!.parentImageUrl != "")
                            ? Card(
                          shape: CircleBorder(),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.network(
                            Config.fileurl + resultResponse!.parentImageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception,
                                StackTrace? stackTrace) {
                              return const Icon(Icons.person);
                            },
                            loadingBuilder: (BuildContext context,
                                Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress
                                      .expectedTotalBytes !=
                                      null
                                      ? loadingProgress
                                      .cumulativeBytesLoaded /
                                      loadingProgress
                                          .expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            height: 100,
                            width: 100,
                          ),
                        )
                            : Image.asset(
                          'assets/images/home/user.png',
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          resultResponse!.parentName ?? "Guest",
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Subhead(
                              color: Colors.green, text:resultResponse!.parentName ?? "Guest", textAlign: TextAlign.start,),
                          SizedBox(
                            width: 02,
                          ),
                          Footnate(color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
                            'valad',
                          )!,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 02,
                          ),
                          Footnate(color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
                            'rankwellcomemani',
                          )!,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SingleChildScrollView(
                      child:
                     Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Subhead(
                              color: Colors.green, text:resultResponse!.parentName ?? "Guest", textAlign: TextAlign.start,),
                            SizedBox(
                              width: 02,
                            ),
                            Footnate(color: Colors.black, textAlign: TextAlign.right, text:  AppLocalizations.of(context)!.translate(
                              'maslkamtiz',
                            )!,
                            ),
                          ],
                        ),
                    ),
                    SizedBox(height: 10,),
                    Buttonfull(
                        text: AppLocalizations.of(context)!.translate(
                          'next',
                        )!,

                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Pandect()));
                        }, color: Colors.white,),
                  ],
                ),
              ),
            ),
          ],
        ),
  );
}
