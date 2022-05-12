import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_button/timer_button.dart';

import '../../../App_localizations.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/Text.dart';

import '../../../tabs.dart';
import 'AddIntroduced.dart';
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

  late String otpcode = "";
  late APIService apiService;
  late SharedPreferences logindata;
  bool hasError = false;

  var resultResponsepro;
  var parentName;
  //String? parentName;

  @override
  void initState() {
    apiService = APIService(context);
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );*/
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
                    /*
              Padding(
                padding: const EdgeInsets.only(right: 3033,left: 30),
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

              ),*/
                    SizedBox(
                      height: 20,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: OtpCodeController,
                        autofocus: true,
                        enabled: true,
                        length: 5,
                        keyboardType: TextInputType.number,
                        mainAxisAlignment: MainAxisAlignment.center,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                                  text: AppLocalizations.of(context)!.translate(
                                'Welcome',
                              )!);

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddIntroduced()),
                                    (route) => false,
                              );
                              /*
                              APIService.profilleall().then((response) {
                                print("APIService.profilleall => $response");
                                setState(() {
                                  isApiCallProcess = false;
                                  resultResponsepro = response;
                                });
                                parentName =
                                    resultResponsepro['parentName'].toString();
                               // print(parentName);

                                if (parentName !=null) {
                                  print("mogdar kali => $parentName");
                                   Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyTabs()),
                                  (route) => false,
                                );
                                }else{
                                  print("mghdar por => $parentName");
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddIntroduced()),
                                        (route) => false,
                                  );

                                }
*/
                              /*  if (parentName != null) {
                                  print("mogdar por => $parentName");
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyTabs()),
                                        (route) => false,
                                  );
                                }*/




                              //});
                              /*   if (response != null) {
                                  resultResponsepro = response ?? "اطلاعات یافت نشد";
                                } else {
                                  setState(() {
                                    isApiCallProcess = false;
                                    resultResponsepro = response;
                                  });
                                }
                              });*/





                              /*   Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddIntroduced()),
                              (route) => false,
                        );*/
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
                              'Resendcode',
                            )!);
                          } else {
                            setState(() {
                              isApiCallProcess = true;
                            });
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
