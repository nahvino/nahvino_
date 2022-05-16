import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Services/login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/TextField.dart';
import '../../../Utils/Text/Text.dart';
import '../../../App_localizations.dart';
import 'CheckCodeSetPhoneNumber.dart';
import 'UserSecuritySttingMenus.dart';

class SetPhoneNumber extends StatefulWidget {
  const SetPhoneNumber({Key? key}) : super(key: key);

  @override
  State<SetPhoneNumber> createState() => _SetPhoneNumberState();
}

class _SetPhoneNumberState extends State<SetPhoneNumber> {
  bool isApiCallProgress = true;
  bool value = false;
  TextEditingController setPhoneNumber = TextEditingController();
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

  Widget body(BuildContext context) => Column(children: [
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
            /*   Container(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.task_alt),
            onPressed: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewProfile()));
            }),
          ),
        ), */
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textspan(
              textAlign: TextAlign.center,
              text: AppLocalizations.of(context)!.translate(
                'set_phone_test',
              )!,
              color: Colors.black,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*TextProfile(
              controller: setPhoneNumber,
              hint: AppLocalizations.of(context)!.translate(
                'phone_text_filed',
              )!,
            ),*/
            TextOtpPhone(
              controller: setPhoneNumber,
              hint: AppLocalizations.of(context)!.translate(
                'phone_text_new',
              )!,
            ),
            Buttonfull(
              color: Colors.white,
              text: AppLocalizations.of(context)!.translate(
                'OK',
              )!,
              onPressed: () {
                if (setPhoneNumber.text.isEmpty) {
                  apiService.showSnackBar(text: "شماره تلفن نمی تواند خالی باشد");
                  return;
                }
                if (!setPhoneNumber.text.startsWith("09")) {
                  apiService.showSnackBar(text: "number is incorrect");
                  return;
                }
                apiService.SetPhoneNumber(setPhoneNumber.text).then((response) async {
                  setState(() {
                    isApiCallProgress = false;
                  });
                  //idficode = identifierCode;
                  //if (response.data != null) {
                  if (response != false) {
                    apiService.showSnackBar(text:response['message'] ?? "کد تایید ارسال شد");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckCodeSetPhoneNumber(setPhoneNumber: setPhoneNumber.text)));
                  }else{
                    apiService.showSnackBar(text: response['message'] ?? "sdd");
                  }
                });
              },
            )
          ],
        ),
      ]);
}
