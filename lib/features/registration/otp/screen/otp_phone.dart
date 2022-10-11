import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/phone_text_filde.dart';
import 'package:Nahvino/features/registration/main/screen/privacy_screen.dart';
import 'package:Nahvino/features/registration/main/screen/registration.dart';
import 'package:Nahvino/features/registration/main/screen/terms_services_screen.dart';
import 'package:Nahvino/features/registration/otp/screen/code_otp_phone.dart';
import 'package:Nahvino/features/registration/otp/service/otp_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class OtpPhone extends StatefulWidget {
  const OtpPhone({Key? key, this.phone}) : super(key: key);
  final phone;

  @override
  State<OtpPhone> createState() => _OtpPhoneState();
}

class _OtpPhoneState extends State<OtpPhone> {
  bool isApiCallProcess = false;
  TextEditingController OtpPhoneController = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '# ###-###-###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late OtpService otpService;

  @override
  void initState() {
    super.initState();
    otpService = OtpService();
    OtpPhoneController = TextEditingController(text: widget.phone ?? "");
    OtpPhoneController.value = maskFormatter.updateMask(mask: '# ###-###-###');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Title3(
            color: Colors.black,
            textAlign: TextAlign.start,
            text: "ورود و ثبت نام با شماره موبایل"),
        backgroundColor: Colors.grey[50],
        leading: BackButton(
          color: Colors.black,
          onPressed: (() {
            OtpPhoneController.clear();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Registration()));
          }),
        ),
      ),
      body: isApiCallProcess
          ? Center(
              child: Lottie.asset('assets/anim/login/send-massage.json',
                  height: 300, width: 300),
            )
          : SafeArea(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Lottie.asset('assets/anim/login/send.json',
                            height: 150, width: 150),
                      ),
                      TextOtpPhone(
                        icon: Icon(Icons.phone_android, size: 32),
                        suffixIcon: null,
                        prefixIcon: null,
                        hint: AppLocalizations.of(context)!.translate(
                          'phoneNumber',
                        )!,
                        controller: OtpPhoneController,
                      ),

                      /*
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        width: 320,
                                                        child: TextOtpPhone(
                                                          icon: Icon(Icons.phone_android, size: 32),
                                                          suffixIcon: null,
                                                          prefixIcon: null,
                                                          hint: AppLocalizations.of(context)!.translate(
                                                            'phoneNumber',
                                                          )!,
                                                          controller: OtpPhoneController,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(bottom: 23),
                                                        child: Card(
                                                          shape: Ro,
              )
              undedRectangleBorder(
                                              side: BorderSide(color: Colors.black38, width: 0.9),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Text("09"),
                                            ),
                                          ),
                             ,
                )
                           ),
                      ],
                    ),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(TermsservicesScreen());
                            },
                            child: Caption1(
                              color: Colors.cyan,
                              textAlign: TextAlign.center,
                              text: AppLocalizations.of(context)!.translate(
                                'Termsandservices',
                              )!,
                            ),
                          ),
                          Caption1(
                            color: Colors.black,
                            textAlign: TextAlign.center,
                            text: AppLocalizations.of(context)!.translate(
                              'And',
                            )!,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(PrivacyScreen());
                            },
                            child: Caption1(
                              color: Colors.cyan,
                              textAlign: TextAlign.center,
                              text: AppLocalizations.of(context)!.translate(
                                'Privacy',
                              )!,
                            ),
                          ),
                          Caption1(
                            color: Colors.black,
                            textAlign: TextAlign.center,
                            text: AppLocalizations.of(context)!.translate(
                              'IAccept',
                            )!,
                          ),
                        ],
                      ),
                      Buttonfull(
                          text: AppLocalizations.of(context)!.translate(
                            'OK',
                          )!,
                          onPressed: () {
                            /*   if (OtpPhoneController.text.isEmpty) {
                            apiService.showSnackBar(
                              text: AppLocalizations.of(context)!.translate(
                                'ValidphoneNumber',
                              )!,
                            );
                            return;
                          }
                          if (!OtpPhoneController.text.startsWith("09")) {
                            apiService.showSnackBar(
                              text: AppLocalizations.of(context)!.translate(
                                'MobileNumberIncorrect',
                              )!,
                            );
                            return;
                          }
                          if (OtpPhoneController.text.length < 11) {
                            apiService.showSnackBar(
                              text: AppLocalizations.of(context)!.translate(
                                'MobileNumberIncorrect',
                              )!,
                            );
                            return;
                          } */

                            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("number is incorrect")));
                            if (!_formKey.currentState!.validate()) {
                            } else {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              otpService
                                  .otpphone(OtpPhoneController.text)
                                  .then((response) async {
                                if (response != false) {
                                  otpService.showSnackBar(
                                      text: response['message']);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CodeOtpPhone(
                                              OtpCode: OtpPhoneController.text,
                                            )),
                                    (route) => false,
                                  );
                                } else {
                                  otpService.showSnackBar(
                                      text: response['message'] ?? "sdd");
                                }
                              });
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
