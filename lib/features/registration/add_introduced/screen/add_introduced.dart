import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Text/TextField.dart';
import 'package:Nahvino/features/profile/view_profile/service/profile_service.dart';
import 'package:Nahvino/features/registration/add_introduced/service/add_code_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../welcome/screen/welcome_user.dart';

class AddIntroduced extends StatefulWidget {
  const AddIntroduced({
    Key? key,
  }) : super(key: key);
  @override
  State<AddIntroduced> createState() => _AddIntroducedState();
}

class _AddIntroducedState extends State<AddIntroduced> {
  TextEditingController identifierCode = TextEditingController();
  TextEditingController code = TextEditingController();
  bool isApiCallProgress = true;
  //GetProfileUserResponseModel? resultResponse;
  var resultResponse;
  int? idficode;

  late AddCodeService seraddcodeservice;

  @override
  void initState() {
    super.initState();
    seraddcodeservice = AddCodeService();
    ProfileService.profileuser().then((response) {
      setState(() {
        isApiCallProgress = false;
        if (response != false) {
          resultResponse = response;
        }
      });
    });
    /*   APIService.getprofileuser().then((response) {
      setState(() {
        isApiCallProgress = false;
        if (response != false) {
          resultResponse = response;
        }
      });
    }).onError((error, stackTrace) {
      print(error);
    });*/
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
                    child: Lottie.asset('assets/anim/loading/loading.json',
                        height: 300, width: 300),
                  )
                : body(context)),
      ),
    );
  }

  Widget body(BuildContext context) => Column(children: [
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
                      Subhead(
                        textAlign: TextAlign.right,
                        text: resultResponse['userName'],
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 03,
                      ),
                      Callout(
                        textAlign: TextAlign.right,
                        text: AppLocalizations.of(context)!.translate(
                          'nahvinoismaslk',
                        )!,
                        color: Colors.black,
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
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextProfile(
                        controller: identifierCode,
                        hint: AppLocalizations.of(context)!.translate(
                          'AddIntroducedhint',
                        )!,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        child: Buttonfull(
                          text: AppLocalizations.of(context)!.translate(
                            'OK',
                          )!,
                          onPressed: () {
                            if (identifierCode.text.isEmpty) {
                              seraddcodeservice.showSnackBar(
                                text: AppLocalizations.of(context)!.translate(
                                  'NotEmptyAddIntroduced',
                                )!,
                              );
                              return;
                            }
                            // idficode = int.parse(identifierCode.text);
                            seraddcodeservice
                                .addIntroduced(int.parse(identifierCode.text))
                                .then((response) async {
                              setState(() {
                                isApiCallProgress = false;
                              });
                              if (response != false) {
                                seraddcodeservice.showSnackBar(
                                    text: response['message'] ?? "");
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WelcomeUser()),
                                  (route) => false,
                                );
                              } else {
                                seraddcodeservice.showSnackBar(
                                    text: response['message'] ?? "");
                              }
                            });
                          },
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 200,
                        height: 50,
                        child: Buttonfull(
                          text: AppLocalizations.of(context)!.translate(
                            'NotIntroduced',
                          )!,
                          onPressed: () {
                            seraddcodeservice.NotIntroduced()
                                .then((response) async {
                              setState(() {
                                isApiCallProgress = false;
                              });
                              if (response != false) {
                                seraddcodeservice.showSnackBar(
                                    text: response['message'] ??
                                        AppLocalizations.of(context)!.translate(
                                          'No_introduction_found',
                                        )!,);

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WelcomeUser()),
                                  (route) => false,
                                );
                              } else {
                                seraddcodeservice.showSnackBar(
                                    text: /*response['message'] ?? "sdd")*/ "هیچ معرفی یافت نشد");
                              }
                            });
                            print(Text("-----------"));

                            /*
                            var data =
                                await APIService(context).NotIntroduced();
                            //if (response.data != null) {
                            if (data) {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                AppLocalizations.of(context)!.translate(
                                  'apptitle',
                                )!,
                                data.message,
                                AppLocalizations.of(context)!.translate(
                                  'OK',
                                )!,
                                () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Pandect()));
                                },
                              );
                            }*/
                          },
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]);
}
