import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/phone_text_filde.dart';
import 'package:Nahvino/features/settings/menu/screen/user_security_stting_menus.dart';
import 'package:Nahvino/features/settings/user_security/set_phone/screen/check_code_set_phone_number.dart';
import 'package:Nahvino/features/settings/user_security/set_phone/service/set_phone_service.dart';
import 'package:flutter/material.dart';


class SetPhoneNumber extends StatefulWidget {
  const SetPhoneNumber({Key? key}) : super(key: key);

  @override
  State<SetPhoneNumber> createState() => _SetPhoneNumberState();
}

class _SetPhoneNumberState extends State<SetPhoneNumber> {
  bool isApiCallProgress = true;
  bool value = false;
  TextEditingController setPhoneNumber = TextEditingController();
  late SetPhoneService set_phone_service;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    set_phone_service = SetPhoneService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(child: body(context)),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserSecuritySttingMenus()));
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
            Callout(
              textAlign: TextAlign.center,
              text: AppLocalizations.of(context)!.translate(
                'set_phone_test',
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
              SizedBox(
                height: 20,
              ),
              Buttonfull(
                color: Colors.white,
                text: AppLocalizations.of(context)!.translate(
                  'OK',
                )!,
                onPressed: () {

                  if (!_formKey.currentState!.validate()) {
                  } else {
                    set_phone_service
                        .setphonenumber(setPhoneNumber.text)
                        .then((response) async {
                      setState(() {
                        isApiCallProgress = false;
                      });
                      //idficode = identifierCode;
                      //if (response.data != null) {
                      if (response != false) {
                        set_phone_service.showSnackBar(text: response['message']);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckCodeSetPhoneNumber(
                                    setPhoneNumber: setPhoneNumber.text)));
                      } else {
                        set_phone_service.showSnackBar(text: response['message']);
                      }
                    });
                  }
                },
              )
            ],
          ),
        )
      ]);
}
