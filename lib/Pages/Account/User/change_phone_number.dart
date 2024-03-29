import 'package:Nahvino/Services/Users/User/menu_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/Text/TextField.dart';
import '../../../Utils/Text/Text.dart';
import '../../../App_localizations.dart';
import 'check_code_change_phone_number.dart';
import 'user_security_stting_menus.dart';

class ChangePhoneNumber extends StatefulWidget {
  const ChangePhoneNumber({Key? key}) : super(key: key);

  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  bool isApiCallProgress = true;
  bool value = false;
  TextEditingController currentPhoneNumber = TextEditingController();
  TextEditingController newPhoneNumber = TextEditingController();
  late MenuService menuservice;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    menuservice = MenuService();
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
                  onPressed: (() {
                    /*   if (currentPhoneNumber.text.isEmpty) {
                      apiService.showSnackBar(text: AppLocalizations.of(context)!.translate(
                        'ValidphoneNumber',
                      )!);
                      return;
                    }
                    if (newPhoneNumber.text.isEmpty) {
                      apiService.showSnackBar(text: AppLocalizations.of(context)!.translate(
                        'ValidphoneNumber',
                      )!);
                      return;
                    }
                    if (!currentPhoneNumber.text.startsWith("09")) {
                      apiService.showSnackBar(text:AppLocalizations.of(context)!.translate(
                        'MobileNumberIncorrect',
                      )!);
                      return;
                    }
                    if (!newPhoneNumber.text.startsWith("09")) {
                      apiService.showSnackBar(text:AppLocalizations.of(context)!.translate(
                        'MobileNumberIncorrect',
                      )!);                      return;
                    }
                    if (currentPhoneNumber.text.length < 11) {
                      apiService.showSnackBar(
                        text: AppLocalizations.of(context)!.translate(
                          'MobileNumberIncorrect',
                        )!,
                      );
                      return;
                    }
                    if (newPhoneNumber.text.length < 11) {
                      apiService.showSnackBar(
                        text: AppLocalizations.of(context)!.translate(
                          'MobileNumberIncorrect',
                        )!,
                      );
                      return;
                    }*/
                    if (!_formKey.currentState!.validate()) {
                    } else {
                      menuservice.ChangePhoneNumber(
                              currentPhoneNumber.text, newPhoneNumber.text)
                          .then((response) async {
                        setState(() {
                          isApiCallProgress = false;
                        });
                        if (response != false) {
                          //apiService.showSnackBar(text:response['message'] ?? "کد تایید ارسال شد");
                          Get.snackbar(
                            "اعلان",
                            response['message'] ?? "کد تایید ارسال شد",
                            icon: Icon(Icons.person, color: Colors.white),
                            snackPosition: SnackPosition.TOP,
                          );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CheckCodeChangePhoneNumber(
                                          currentPhoneNumber:
                                              currentPhoneNumber.text,
                                          newPhoneNumber:
                                              newPhoneNumber.text)));
                        } else {
                          //apiService.showSnackBar(text: response['message'] ?? "sdd");
                          menuservice.showSnackBar(
                              text: response['message'] ?? "کد تایید ارسال شد");
                          // Get.snackbar(
                          //   "اعلان",
                          //   response['message'],
                          //   icon: Icon(Icons.person, color: Colors.white),
                          //   snackPosition: SnackPosition.TOP,
                          // );
                        }
                      });
                    }
                  }),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textspan(
                textAlign: TextAlign.center,
                text: AppLocalizations.of(context)!.translate(
                  'phone_text_chenge',
                )!,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextOtpPhone(
                  controller: currentPhoneNumber,
                  icon: Icon(Icons.phone_android, size: 32),
                  hint: AppLocalizations.of(context)!.translate(
                    'phone_text_old',
                  )!,
                ),
                SizedBox(
                  height: 10,
                ),
                TextOtpPhone(
                  controller: newPhoneNumber,
                  icon: Icon(Icons.phone_android, size: 32),
                  hint: AppLocalizations.of(context)!.translate(
                    'phone_text_new',
                  )!,
                ),
              ],
            ),
          )
        ]),
      );
}
