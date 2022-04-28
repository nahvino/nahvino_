import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_button/timer_button.dart';

import '../../../App_localizations.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Button/TextField.dart';
import '../../../Utils/Widget/Text.dart';
import '../../../tabs.dart';
import '../User/ViewProfile.dart';
import 'SignUp.dart';

class CodeOtpPhoneNew extends StatefulWidget {
  const CodeOtpPhoneNew({Key? key, required this.OtpCode}) : super(key: key);
  final OtpCode;

  @override
  State<CodeOtpPhoneNew> createState() => _CodeOtpPhoneNewState();
}

class _CodeOtpPhoneNewState extends State<CodeOtpPhoneNew> {
  bool isApiCallProcess = false;
  TextEditingController OtpCodePhoneController = TextEditingController();
  TextEditingController OtpCodeController = TextEditingController();
  late APIService apiService;
  late SharedPreferences logindata;

  @override
  void initState() {
    super.initState();
    apiService = APIService(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        leading: BackButton(
          color: Colors.black,
          onPressed: (() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          }),
        ),
      ),
      body: isApiCallProcess
          ? Center(
              child: Lottie.asset('assets/anim/login/send-massage.json',
                  height: 300, width: 300),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Lottie.asset('assets/anim/login/send.json',
                          height: 150, width: 150),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(AppLocalizations.of(context)!.translate(
                        'set_phone_test',
                      )!),
                      SizedBox(width: 3),
                      //Text(widget.setPhoneNumber)
                      textspan(
                        textAlign: TextAlign.center,
                        text: widget.OtpCode,
                        color: Colors.green,
                      ),
                    ]),
                    TextOtpPhone(
                      icon: Icon(Icons.phone_android),
                      suffixIcon: null,
                      prefixIcon: null,
                      hint: AppLocalizations.of(context)!.translate(
                        'phoneNumber',
                      )!,
                      controller: OtpCodeController,
                    ),
                    Buttontest(
                        text: AppLocalizations.of(context)!.translate(
                          'OK',
                        )!,
                        onPressed: () {
                          if (OtpCodeController.text.isEmpty) {
                            apiService.showSnackBar(text: "filed is empty!");
                            return;
                          }
                          setState(() {
                            isApiCallProcess = true;
                          });
                          apiService.OtpCodePhone(widget.OtpCode.toString(),
                                  int.parse(OtpCodeController.text))
                              .then((response) async {

                            if (response != false) {
                              logindata = await SharedPreferences.getInstance();
                              await logindata.setString("token",
                                  response['data']['userToken']['token']);
                              await logindata.setString(
                                  "userId", response['data']['id']);
                              apiService.showSnackBar(text: response['message']);

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => MyTabs()),
                                (route) => false,
                              );
                            } else {
                              apiService.showSnackBar(
                                  text: response['message'] ?? "sdd");
                            }
                          });
                        }),
                    TimerButton(
                      timeOutInSeconds: 120,
                      disabledColor: Colors.transparent,
                      color: Colors.cyan,
                      buttonType: ButtonType.TextButton,
                      label: AppLocalizations.of(context)!.translate(
                        'ReCode',
                      )!,
                      onPressed: () {
                        apiService.NewReSendCode(widget.OtpCode.toString(),)
                            .then((response) async {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          if (response != false) {
                            apiService.showSnackBar(text: response['message']);

                          } else {
                            apiService.showSnackBar(
                                text: response['message']);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
