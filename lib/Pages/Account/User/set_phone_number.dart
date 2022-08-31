import 'package:Nahvino/Services/Users/User/menu_service.dart';
import 'package:flutter/material.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/Text.dart';
import '../../../App_localizations.dart';
import '../../../Utils/TextField/phone_text_filde.dart';
import 'check_code_set_phone_number.dart';
import 'user_security_stting_menus.dart';

class SetPhoneNumber extends StatefulWidget {
  const SetPhoneNumber({Key? key}) : super(key: key);

  @override
  State<SetPhoneNumber> createState() => _SetPhoneNumberState();
}

class _SetPhoneNumberState extends State<SetPhoneNumber> {
  bool isApiCallProgress = true;
  bool value = false;
  TextEditingController setPhoneNumber = TextEditingController();
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
                icon: Icon(Icons.phone_android, size: 32),
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
                  /*    if (setPhoneNumber.text.isEmpty) {
                  apiService.showSnackBar(text: AppLocalizations.of(context)!.translate(
                    'ValidphoneNumber',
                  )!);
                  return;
                }
                if (!setPhoneNumber.text.startsWith("09")) {
                  apiService.showSnackBar(text:AppLocalizations.of(context)!.translate(
                    'MobileNumberIncorrect',
                  )!);
                  return;
                }
                if (setPhoneNumber.text.length < 11) {
                  apiService.showSnackBar(
                    text: AppLocalizations.of(context)!.translate(
                      'MobileNumberIncorrect',
                    )!,
                  );
                  return;
                }*/
                  if (!_formKey.currentState!.validate()) {
                  } else {
                    menuservice
                        .setphonenumber(setPhoneNumber.text)
                        .then((response) async {
                      setState(() {
                        isApiCallProgress = false;
                      });
                      //idficode = identifierCode;
                      //if (response.data != null) {
                      if (response != false) {
                        menuservice.showSnackBar(text: response['message']);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckCodeSetPhoneNumber(
                                    setPhoneNumber: setPhoneNumber.text)));
                      } else {
                        menuservice.showSnackBar(text: response['message']);
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
