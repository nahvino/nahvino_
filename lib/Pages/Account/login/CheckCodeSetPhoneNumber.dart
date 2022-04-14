import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Services/login/api_service.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Button/TextField.dart';
import '../../../Utils/Button/Textsall.dart';
import '../../../app_localizations.dart';
import '../User/view_profile.dart';
import 'Pandect.dart';

class CheckCodeSetPhoneNumber extends StatefulWidget {
  const CheckCodeSetPhoneNumber({Key? key}) : super(key: key);

  @override
  State<CheckCodeSetPhoneNumber> createState() => _CheckCodeSetPhoneNumberState();
}

class _CheckCodeSetPhoneNumberState extends State<CheckCodeSetPhoneNumber> {
  bool isApiCallProgress = true;
  bool value = false;
  TextEditingController setPhoneNumber = TextEditingController();
  TextEditingController code = TextEditingController();
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
                  MaterialPageRoute(builder: (context) => ViewProfile()));
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
        textspan(
          textAlign: TextAlign.center,
          text: AppLocalizations.of(context)!.translate(
            'set_phone_test',
          )!,
          color: Colors.black,
        ),
        TextProfile(
          controller: code,
          hint: AppLocalizations.of(context)!.translate(
            'phone_text_filed',
          )!,
        ),
        Buttonfull(
          color: Colors.white,
          text: AppLocalizations.of(context)!.translate(
            'OK',
          )!,
          onPressed: () {
            /*
            if (setPhoneNumber.text.isEmpty) {
              apiService.showSnackBar(text: "filed is empty!");
              return;
            }
            apiService.CheckCodeSetPhoneNumber(setPhoneNumber.text).then((response) async {
              setState(() {
                isApiCallProgress = false;
              });
              //idficode = identifierCode;
              //if (response.data != null) {
              if (response) {
                apiService.showSnackBar(text:response['message'] ?? "معرف مورد نظر با موفقیت ثبت شد");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Pandect()));
              }else{
                apiService.showSnackBar(text:response['message'] ?? "sdd");
              }
            });*/
          },
        )
      ],
    ),
  ]);
}