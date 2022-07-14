import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../Services/login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/Text.dart';
import '../../../App_localizations.dart';
import 'set_phone_number.dart';
import 'view_profile.dart';

class CheckCodeSetPhoneNumber extends StatefulWidget {
  const CheckCodeSetPhoneNumber({Key? key, required this.setPhoneNumber})
      : super(key: key);
  final String setPhoneNumber;

  @override
  State<CheckCodeSetPhoneNumber> createState() =>
      _CheckCodeSetPhoneNumberState();
}

class _CheckCodeSetPhoneNumberState extends State<CheckCodeSetPhoneNumber> {
  bool isApiCallProgress = true;
  bool value = false;
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
                            builder: (context) => SetPhoneNumber()));
                  }),
                ),
              ),
              /*Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.task_alt),
                  onPressed: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ViewProfile()));
                  }),
                ),
              ),*/
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(width: 3),
                //Text(widget.setPhoneNumber)
                textspan(
                  textAlign: TextAlign.center,
                  text: widget.setPhoneNumber,
                  color: Colors.green,
                ),
              ]),
              /*  TextProfile(
                controller: code,
                hint: AppLocalizations.of(context)!.translate(
                  'phone_text_filed',
                )!,
              ),*/
              SizedBox(
                height: 10,
              ),
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
              SizedBox(
                height: 10,
              ),
              Buttonfull(
                color: Colors.white,
                text: AppLocalizations.of(context)!.translate(
                  'OK',
                )!,
                onPressed: () {
                  if (code.text.isEmpty) {
                    apiService.showSnackBar(
                        text: "شماره تلفن نمی تواند خالی باشد");
                    return;
                  }
                  apiService
                      .checkcodesetPhoneNumber(widget.setPhoneNumber.toString(),
                          int.parse(code.text))
                      .then((response) async {
                    setState(() {
                      isApiCallProgress = false;
                    });
                    //idficode = identifierCode;
                    //if (response.data != null) {
                    if (response != false) {
                      apiService.showSnackBar(
                          text: response['message'] ?? "کد تایید ارسال شد");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewProfile()));
                    } else {
                      apiService.showSnackBar(
                          text: response['message'] ?? "sdd");
                    }
                  });
                },
              )
            ],
          ),
        ]),
      );
}
