import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Services/login/api_service.dart';
import '../../../Utils/Button/TextField.dart';
import '../../../Utils/Button/Textsall.dart';
import '../../../app_localizations.dart';
import '../User/view_profile.dart';

class ChangePhoneNumber extends StatefulWidget {
  const ChangePhoneNumber({Key? key}) : super(key: key);

  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  bool isApiCallProgress = true;
  bool value = false;
  TextEditingController identifierCode = TextEditingController();
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
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.task_alt),
                onPressed: (() {
                  String text = identifierCode.text;
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
        TextProfile(
          controller: identifierCode,
          hint: AppLocalizations.of(context)!.translate(
            'phone_text_old',
          )!,
        ),
        TextProfile(
          controller: identifierCode,
          hint: AppLocalizations.of(context)!.translate(
            'phone_text_new',
          )!,
        ),
      ],
    ),
      ]);
}
