import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/phone_text_filde.dart';
import 'package:Nahvino/features/registration/main/screen/privacy_screen.dart';
import 'package:Nahvino/features/registration/main/screen/registration.dart';
import 'package:Nahvino/features/registration/main/screen/terms_services_screen.dart';
import 'package:Nahvino/features/registration/otp/controllers/otp_phone_controller.dart';
import 'package:Nahvino/features/registration/otp/screen/code_otp_phone.dart';
import 'package:Nahvino/features/registration/otp/service/otp_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class OtpPhone extends StatelessWidget {
  OtpPhone({Key? key,}) : super(key: key);
  OtpPhoneController otp_phone_controller = Get.put(OtpPhoneController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      /*    appBar: AppBar(
        elevation: 0,
        title: Title3(
            color: Colors.black,
            textAlign: TextAlign.start,
            text: AppLocalizations.of(context)!.translate(
              'reotp',
            )!,),
        backgroundColor: Colors.grey[50],
        leading: BackButton(
          color: Colors.black,
          onPressed: (() {
            OtpPhoneController.clear();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Registration()));
          }),
        ),
      ),*/
      body: SafeArea(
        child: Form(
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
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Body(
                      text: "شماره تلفن را وارد نمایید.",
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    TextOtpPhone(
                      hint: AppLocalizations.of(context)!.translate(
                        'phoneNumber',
                      )!,
                      controller: otp_phone_controller.phone_text_controller,
                      onChanged: (value) {
                        if (value.length == 11) {
                          otp_phone_controller.start();
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: width * 0.4,
                      child: Buttonfull(
                          text: AppLocalizations.of(context)!.translate(
                            'OK',
                          )!,
                          onPressed: () {
                            otp_phone_controller.start();
                          }),
                    ),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
