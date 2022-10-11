import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/profile/view_profile/screen/view_profile.dart';
import 'package:Nahvino/features/settings/menu/screen/user_security_stting_menus.dart';
import 'package:Nahvino/features/settings/user_security/change_phone/service/change_phone_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class CheckCodeChangePhoneNumber extends StatefulWidget {
  const CheckCodeChangePhoneNumber(
      {Key? key,
      required this.currentPhoneNumber,
      required this.newPhoneNumber})
      : super(key: key);
  final String currentPhoneNumber;
  final String newPhoneNumber;

  @override
  State<CheckCodeChangePhoneNumber> createState() =>
      _CheckCodeChangePhoneNumberState();
}

class _CheckCodeChangePhoneNumberState
    extends State<CheckCodeChangePhoneNumber> {
  TextEditingController code = TextEditingController();
  late ChangePhoneService chhange_phone_service;

  bool isApiCallProgress = true;

  @override
  void initState() {
    super.initState();
    chhange_phone_service = ChangePhoneService();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(child: body(context)),
      ),
    );
  }

  Widget body(BuildContext context) => SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: BackButton(
                  onPressed: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserSecuritySttingMenus()));
                  }),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.task_alt),
                  onPressed: () {
                    /*  Get.snackbar(
                      "Welcome to Flutter Agency",
                      "We are expert in FLutter App Development",
                      icon: Icon(Icons.person, color: Colors.white),
                      snackPosition: SnackPosition.TOP,
                    );*/

                    if (code.text.isEmpty) {
                      chhange_phone_service.showSnackBar(
                          text: "شماره تلفن نمی تواند خالی باشد");
                      return;
                    }
                    chhange_phone_service.CheckCodeChangePhoneNumber(
                            widget.currentPhoneNumber.toString(),
                            widget.newPhoneNumber.toString(),
                            int.parse(code.text))
                        .then((response) async {
                      setState(() {
                        isApiCallProgress = false;
                      });
                      //idficode = identifierCode;
                      //if (response.data != null) {
                      if (response != false) {
                        // apiService.showSnackBar(
                        //text: response['message'] ?? "کد تایید ارسال شد");
                        Get.snackbar(
                          "اعلان",
                          response['message'] ?? "تغیر کرد",
                          icon: Icon(Icons.person, color: Colors.white),
                          snackPosition: SnackPosition.TOP,
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewProfile()));
                      } else {
                        chhange_phone_service.showSnackBar(
                            text: response['message'] ?? "sdd");
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Callout(
                textAlign: TextAlign.center,
                text: AppLocalizations.of(context)!.translate(
                  'set_phone_test',
                )!,
                color: Colors.black,
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(AppLocalizations.of(context)!.translate(
              'OldPhoneNumber',
            )!),
            SizedBox(width: 3),
            //Text(widget.setPhoneNumber)
            Callout(
              textAlign: TextAlign.center,
              text: widget.currentPhoneNumber,
              color: Colors.green,
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(AppLocalizations.of(context)!.translate(
              'NewPhoneNumber',
            )!),
            SizedBox(width: 3),
            //Text(widget.setPhoneNumber)
            Callout(
              textAlign: TextAlign.center,
              text: widget.newPhoneNumber,
              color: Colors.green,
            ),
          ]),
          SizedBox(
            height: 20,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            /* TextProfile(
              controller: code,
              hint: AppLocalizations.of(context)!.translate(
                'phone_text_filed',
              )!,
            ),*/
            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                controller: code,
                autofocus: true,
                enabled: true,
                length: 5,
                keyboardType: TextInputType.number,
                mainAxisAlignment: MainAxisAlignment.center,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
              ),
            ),
          ]),
        ]),
      );
}
