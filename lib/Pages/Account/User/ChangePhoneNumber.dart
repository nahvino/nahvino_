import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Services/login/ApiService.dart';
import '../../../Utils/Text/TextField.dart';
import '../../../Utils/Text/Text.dart';
import '../../../App_localizations.dart';
import 'CheckCodeChangePhoneNumber.dart';
import 'UserSecuritySttingMenus.dart';

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
  late APIService apiService;

  @override
  void initState() {
    super.initState();
    apiService = APIService(context);
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserSecuritySttingMenus()));
                  }),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.task_alt),
                  onPressed: (() {
                    if (currentPhoneNumber.text.isEmpty) {
                      apiService.showSnackBar(
                          text: "شماره تلفن نمی تواند خالی باشد");
                      return;
                    }
                    if (newPhoneNumber.text.isEmpty) {
                      apiService.showSnackBar(
                          text: "شماره تلفن نمی تواند خالی باشد");
                      return;
                    }
                    if (!currentPhoneNumber.text.startsWith("09")) {
                      apiService.showSnackBar(text: "number is incorrect");
                      return;
                    }
                    if (!newPhoneNumber.text.startsWith("09")) {
                      apiService.showSnackBar(text: "number is incorrect");
                      return;
                    }
                    apiService.ChangePhoneNumber(
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
                                builder: (context) => CheckCodeChangePhoneNumber(
                                    currentPhoneNumber: currentPhoneNumber.text,
                                    newPhoneNumber: newPhoneNumber.text)));
                      } else {
                        //apiService.showSnackBar(text: response['message'] ?? "sdd");
                        apiService.showSnackBar(
                            text: response['message'] ?? "کد تایید ارسال شد");
                        // Get.snackbar(
                        //   "اعلان",
                        //   response['message'],
                        //   icon: Icon(Icons.person, color: Colors.white),
                        //   snackPosition: SnackPosition.TOP,
                        // );
                      }
                    });
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextOtpPhone(
                controller: currentPhoneNumber,
                hint: AppLocalizations.of(context)!.translate(
                  'phone_text_old',
                )!,
              ),
              TextOtpPhone(
                controller: newPhoneNumber,
                hint: AppLocalizations.of(context)!.translate(
                  'phone_text_new',
                )!,
              ),
            ],
          ),
        ]),
  );
}
