import 'package:flutter/material.dart';
import '../../../Services/login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/Text.dart';
import '../../../App_localizations.dart';
import '../../../Utils/TextField/phonefextfilde.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            textspan(
              textAlign: TextAlign.center,
              text: AppLocalizations.of(context)!.translate(
                'set_phone_test',
              )!,
              color: Colors.black,
            ),
          ],
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
                    apiService.SetPhoneNumber(setPhoneNumber.text)
                        .then((response) async {
                      setState(() {
                        isApiCallProgress = false;
                      });
                      //idficode = identifierCode;
                      //if (response.data != null) {
                      if (response != false) {
                        apiService.showSnackBar(text: response['message']);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckCodeSetPhoneNumber(
                                    setPhoneNumber: setPhoneNumber.text)));
                      } else {
                        apiService.showSnackBar(text: response['message']);
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
