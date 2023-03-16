import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Button/close_button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/phone_text_filde.dart';
import 'package:Nahvino/features/feature_auth/main/screen/privacy_screen.dart';
import 'package:Nahvino/features/feature_auth/main/screen/terms_services_screen.dart';
import 'package:Nahvino/features/feature_auth/phone_number/controllers/otp_phone_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class OtpPhone extends StatelessWidget {
  OtpPhone({Key? key,}) : super(key: key);
  OtpPhoneController otp_phone_controller = Get.put(OtpPhoneController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return Form(
            key: otp_phone_controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image: NetworkImage(
                              "https://cdn.dribbble.com/users/1597968/screenshots/7114886/media/2bbe83d0e87d6e7aae278f2a38ced50f.png?compress=1&resize=400x300&vertical=top")),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      HeadLine(text: "ورود و ثبت نام با شماره تلفن"),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      /*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Body(
                          text: "رمز عبور ",
                          color: Colors.grey,
                        ),
                        Body(
                          text: " موقت ",
                        ),
                        Body(
                          text: " برای شما ارسال خواهد شد.",
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  */
                      SizedBox(
                        height: height * 0.04,
                      ),
                      // Body(
                      //
                      //   text: "شماره\u200Cموبایل\u200Cخود\u200Cرا‌\u200Cوارد\u200C‌نمایید.",
                      //   color: Colors.grey,
                      // ),
                      SizedBox(
                        height: height * 0.012,
                      ),
                      TextOtpPhone(
                        hint: AppLocalizations.of(context)!.translate(
                          'phoneNumber',
                        )!,
                        controller: otp_phone_controller.phone_text_controller,
                        onChanged: (value) {
                          if (value.length == 11) {
                            otp_phone_controller.start(context);
                          }
                        },
                      ),
                      SizedBox(
                        height: height*0.040,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            child: Checkbox(
                              value: this.otp_phone_controller.chackvaule.value,
                              onChanged: (value) {
                                this.otp_phone_controller.chackvaule.value =
                                value!;
                                otp_phone_controller.chackBoxSelect.value =
                                false;
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                  new AlertDialog(
                                    title: Column(
                                      children: [
                                        Row(children: [
                                          CloseBotton(),
                                        ],),
                                        SizedBox(height: height * 0.02,),
                                        Callout(
                                          color: Colors.black,
                                          textAlign: TextAlign.right,
                                          text: AppLocalizations.of(context)!
                                              .translate(
                                            'Privacy_policy',
                                          )!,
                                        ),
                                      ],
                                    ),
                                    // actions: [
                                    //   Buttonfull(
                                    //       text: "بستن",
                                    //       onPressed: () => Navigator.pop(context))
                                    // ],
                                    content: TermsservicesScreen(),
                                  ));
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
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                  new AlertDialog(
                                    title: Column(
                                      children: [
                                        Row(children: [
                                          CloseBotton(),
                                        ],),
                                        SizedBox(height: height * 0.02,),
                                        Callout(
                                          color: Colors.black,
                                          textAlign: TextAlign.right,
                                          text: AppLocalizations.of(context)!
                                              .translate(
                                            'Privacy_policy',
                                          )!,
                                        ),
                                      ],
                                    ),
                                    // actions: [
                                    //   Buttonfull(
                                    //       text: "بستن",
                                    //       onPressed: () => Navigator.pop(context))
                                    // ],
                                    content: PrivacyScreen(),
                                  ));
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
                      Padding(
                        padding: EdgeInsets.only(right: height * 0.073),
                        child: Visibility(
                            visible: otp_phone_controller.chackBoxSelect.value,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10, top: 1),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.minus_square,
                                    color: Colors.deepOrange,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Caption1(
                                      text: "شما هنوز قوانین را نپذفته اید."),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        height: height*0.020,
                      ),
                      SizedBox(
                        width: width * 0.4,
                        child: Buttonfull(
                            text: AppLocalizations.of(context)!.translate(
                              'OK',
                            )!,
                            onPressed: () {
                              otp_phone_controller.start(context);
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
