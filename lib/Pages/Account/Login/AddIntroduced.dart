import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../../../Model/user/user/viewprofile_response_model.dart';
import '../../../Services/login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Button/TextField.dart';
import '../../../Utils/Widget/Text.dart';
import '../../../App_localizations.dart';
import 'Pandect.dart';

class AddIntroduced extends StatefulWidget {
  const AddIntroduced({Key? key,}) : super(key: key);
  @override
  State<AddIntroduced> createState() => _AddIntroducedState();
}

class _AddIntroducedState extends State<AddIntroduced> {
  TextEditingController identifierCode = TextEditingController();
  bool isApiCallProgress = true;
  GetProfileUserResponseModel? resultResponse;
  late int idficode;

  late APIService apiService;

  @override
  void initState() {
    super.initState();
    apiService = APIService(context);
    APIService.getprofileuser().then((response) {
      setState(() {
        isApiCallProgress = false;
        if (response != false) {
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
                      textbold(
                        textAlign: TextAlign.right,
                        text: resultResponse!.userName ?? "Guest",
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 03,
                      ),
                      textspan(
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
                      Container(
                        height: 50,
                        child: Buttonfull(
                          text: AppLocalizations.of(context)!.translate(
                            'OK',
                          )!,
                          onPressed: () {
                            if (identifierCode.text.isEmpty) {
                              apiService.showSnackBar(text: "filed is empty!");
                              return;
                            }

                            apiService.AddIntroduced(identifierCode.text)
                                .then((response) async {
                              setState(() {
                                isApiCallProgress = false;
                              });
                              //idficode = identifierCode;
                              //if (response.data != null) {
                              if (response !=false) {
                                apiService.showSnackBar(text:response['message'] ?? "");
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Pandect()),
                                  (route) => false,
                                );
                              } else {
                                apiService.showSnackBar(text:response['message'] ?? "");
                              }
                            });
                          },
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 200,
                        height: 50,
                        child: Buttonfull(
                          text: AppLocalizations.of(context)!.translate(
                            'NotIntroduced',
                          )!,
                          onPressed: () {
                            apiService.NotIntroduced()
                                .then((response) async {
                              setState(() {
                                isApiCallProgress = false;
                              });
                              if (response !=false) {
                                apiService.showSnackBar(text:response['message'] ?? "");

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Pandect()),
                                      (route) => false,
                                );
                              } else {
                                apiService.showSnackBar(text:response['message'] ?? "sdd");
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
