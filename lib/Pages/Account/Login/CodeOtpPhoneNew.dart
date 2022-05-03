import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
  late StreamController<ErrorAnimationType> errorController;

  late String otpcode="";
  late APIService apiService;
  late SharedPreferences logindata;
  bool hasError = false;

  @override
  void initState() {
    apiService = APIService(context);
    errorController = StreamController<ErrorAnimationType>();
    super.initState();

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
              /* TextOtpPhone(
                      icon: Icon(Icons.phone_android, size: 24),
                      suffixIcon: null,
                      prefixIcon: null,
                      hint: AppLocalizations.of(context)!.translate(
                        'vrifycode',
                      )!,
                      controller: OtpCodeController,
                    ),*/
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 50,left: 50),
                child: PinCodeTextField(
                    appContext: context,
                    length: 5,
                    enableActiveFill: true,
                    pastedTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Vazirmatn_Regular'
                    ),
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 60,
                      fieldWidth: 50,
                      activeFillColor:
                      hasError ? Colors.orange : Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    textStyle: TextStyle(fontSize: 20, height: 1.6),
                    beforeTextPaste: (text) {

                      return true;
                    },
                    boxShadows: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 5,
                      )
                    ],
                    controller: OtpCodeController,
                    errorAnimationController: errorController ,
                    onChanged: (value) {
                      setState(() {
                        otpcode = value;
                      });
                    }),
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
                        apiService.showSnackBar(
                            text: AppLocalizations.of(context)!
                                .translate(
                              'Welcome',
                            )!);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyTabs()),
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
                  apiService.NewReSendCode(
                    widget.OtpCode.toString(),
                  ).then((response) async {
                    setState(() {
                      isApiCallProcess = false;
                    });
                    if (response != false) {
                      apiService.showSnackBar(
                          text: AppLocalizations.of(context)!.translate(
                            'Welcome',
                          )!);
                    } else {
                      apiService.showSnackBar(text: response['message']);
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
