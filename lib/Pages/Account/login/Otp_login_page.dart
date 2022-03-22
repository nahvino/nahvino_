import 'package:flutter/material.dart';
import 'package:nahvino/Login/sign_up.dart';
import 'package:nahvino/app_localizations.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../../Model/user/otp/otp_request_code_model.dart';
import '../../../Model/user/otp/otp_request_model.dart';
import '../../../Services/login/api_service.dart';
import '../../../Services/login/user/config.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isAPIcallProcess = false;
  String? phoneNumber;
  int? code;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
          ),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  @override
  Widget _loginUI(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
              right: 10,
              left: 10),
          child: BackButton(
            onPressed: (() {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            }),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
              right: 35,
              left: 35),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.translate(
                  'SignIn_top_text',
                )!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontFamily: 'byekan'),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.2,
              right: 35,
              left: 35),
          child: FormHelper.inputFieldWidget(
            context,
            "phoneNumber",
            "phoneNumber",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Username con\ ' t be empty.";
              }
              return null;
            },
            (onSavedVal) {
              phoneNumber = onSavedVal;
            },
            borderFocusColor: Colors.grey,
            prefixIconColor: Colors.black,
            borderColor: Colors.green,
            textColor: Colors.black,
            hintColor: Colors.black,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.42,
              right: 110,
              left: 110),
          child: FormHelper.submitButton("کد ورود", () {
            if (validateAndSave()) {
              setState(() {
                isAPIcallProcess = true;
              });

              OtpRequestModel model =
                  OtpRequestModel(phoneNumber: phoneNumber!);

              APIService.otpphone(model).then((response) {
                setState(() {
                  isAPIcallProcess = false;
                });
                if (response) {
                  openDialog();
                } else {}
              });
            }
          }),
        ),
      ]),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(phoneNumber!),
          content: FormHelper.inputFieldWidget(
            context,
            "code",
            "code",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "کد تایید نمی تواند خالی باشد.";
              }
              return null;
            },
            (onSavedVal) {
              code = int.parse(onSavedVal);
            },
            borderFocusColor: Colors.grey,
            prefixIconColor: Colors.black,
            borderColor: Colors.green,
            textColor: Colors.black,
            hintColor: Colors.black,
          ),
          actions: [
            FormHelper.submitButton("ثبت نام", () {
              if (validateAndSave()) {
                setState(() {
                  isAPIcallProcess = true;
                });

                OtpRequestCodeModel model =
                    OtpRequestCodeModel(code: code, phoneNumber: phoneNumber);

                APIService.otpvrifay(model).then((response) {
                  setState(() {
                    isAPIcallProcess = false;
                  });
                  if (response.data != null) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  } else {}
                });
              }
            }),
          ],
        ),
      );

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
