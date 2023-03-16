import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_auth/phone_number/controllers/code_otp_controller.dart';
import 'package:Nahvino/features/feature_auth/phone_number/controllers/otp_phone_controller.dart';
import 'package:Nahvino/features/feature_auth/phone_number/screen/otp_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';

class CodeOtpPhone extends StatelessWidget {
  CodeOtpPhone({
    Key? key,
  }) : super(key: key);

  OtpPhoneController otp_phone_controller = Get.put(OtpPhoneController());
  CodeOtpConrtoller code_controller = Get.put(CodeOtpConrtoller());
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      boxShadow: [
        BoxShadow(
            color: Colors.cyanAccent,
            spreadRadius: 0.00,
            blurStyle: BlurStyle.normal,
            blurRadius: 12,
            offset: Offset(-1, 3))
      ],
      // border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(9),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GetBuilder<CodeOtpConrtoller>(builder: (logic) {
            return Form(
              key: code_controller.formKey,
              child: Column(
                children: [
                  Image(
                      image: NetworkImage(
                          "https://cdn.dribbble.com/users/1597968/screenshots/7114886/media/2bbe83d0e87d6e7aae278f2a38ced50f.png?compress=1&resize=400x300&vertical=top")),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    HeadLine(text: "ورود و ثبت نام با شماره تلفن"),
                    SizedBox(
                      height: height * 0.09,
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    //Text(widget.setPhoneNumber)
                    HeadLine(
                      textAlign: TextAlign.center,
                      text: otp_phone_controller.phone_text_controller.text,
                      color: Colors.black,
                    ),
                  ]),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Body(
                    text: AppLocalizations.of(context)!.translate(
                      'vrifycodephonetoptext',
                    )!,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Column(
                      children: [
                        Pinput(
                          defaultPinTheme: (code_controller.vlide.value)
                              ? PinTheme(
                                  width: 56,
                                  height: 56,
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(30, 60, 87, 1),
                                      fontWeight: FontWeight.w600),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.redAccent.shade700,
                                          spreadRadius: -3,
                                          blurStyle: BlurStyle.values[1],
                                          blurRadius: 5,
                                          offset: Offset(-4, 3)),
                                    ],
                                    // border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                )
                              : PinTheme(
                                  width: 56,
                                  height: 56,
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(30, 60, 87, 1),
                                      fontWeight: FontWeight.w600),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.cyanAccent.shade700,
                                          spreadRadius: -3,
                                          blurStyle: BlurStyle.values[1],
                                          blurRadius: 5,
                                          offset: Offset(-4, 3)),

                                    ],
                                    // border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                ),
                          controller: code_controller.OtpCodeController,
                          autofocus: true,
                          enabled: true,
                          length: 5,
                          onChanged: (value) {
                            if (value.length == 5) {
                              code_controller.start(context);
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.translate(
                                'notull',
                              );
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp('[./,]'))
                          ],
                          keyboardType: TextInputType.number,
                          mainAxisAlignment: MainAxisAlignment.center,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OtpTimerButton(
                              height: 37,
                              text: Text(
                                'ارسال مجدد',
                              ),
                              duration: 120,
                              radius: 30,
                              backgroundColor: Colors.cyan,
                              textColor: Colors.white,
                              buttonType: ButtonType.text_button,
                              // or ButtonType.outlined_button
                              loadingIndicator: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.cyan,
                              ),
                              loadingIndicatorColor: Colors.cyan,
                              onPressed: () {
                                code_controller.resendStart(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 33,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.arrow_right_14,
                              color: Colors.cyan,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OtpPhone()));
                              },
                              child: Caption1(
                                color: Colors.cyan,
                                textAlign: TextAlign.right,
                                text: AppLocalizations.of(context)!.translate(
                                  'MobileNumberCorrection',
                                )!,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    width: width * 0.4,
                    child: Buttonfull(
                        text: AppLocalizations.of(context)!.translate(
                          'OK',
                        )!,
                        onPressed: () {
                          code_controller.start(context);
                        }),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
