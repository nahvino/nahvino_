import 'package:flutter/material.dart';
import 'package:nahvino/Pages/Account/login/sign_up.dart';
import 'package:nahvino/Pages/Account/login/otp_code.dart';
import 'package:nahvino/Utils/Button/Button.dart';
import 'package:nahvino/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../../Model/user/otp/otp_request_model.dart';
import '../../../Services/login/api_service.dart';
import '../../../Utils/Button/Textsall.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isAPIcallProcess = false;
  bool isAPIcoodcallProcess = false;
  String? phoneNumber;
  int? code;
  SharedPreferences? preferences;

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
              textspan(

                textAlign: TextAlign.center,
                 text:  AppLocalizations.of(context)!.translate(
                   'SignIn_top_text',
                 )!, color: Colors.black,
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
            AppLocalizations.of(context)!.translate(
              'phoneNumber',
            )!,
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return  AppLocalizations.of(context)!.translate(
                  'ValidphoneNumber',
                )!;
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
        
        
        /*
        TextFieldNah(
            hinttext: "شماره تلفن",
            empty: "این مقدار نباید خالی باشد",
            keyName: phoneNumber!),
    */
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.33,
          ),
          child: Buttontest(
            text:  AppLocalizations.of(context)!.translate(
              'OK',
            )!,
            onPressed: () {
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
                    //openDialog();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OtpcodePage(phoneNumber: phoneNumber)));
                  } else {}
                });
              }
            },
          ),
          /*
          FormHelper.submitButton("کد ورود", () {
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
                  //openDialog();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => OtpcodePage(phoneNumber: phoneNumber)));
                } else {}
              });
            }
          }),
          */
        ),
      ]),
    );
  }

/*
  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(phoneNumber!),
          content: Column(
            children: [
              FormHelper.inputFieldWidget(
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
              FormHelper.inputFieldWidget(
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
            ],
          ),
          actions: [
            FormHelper.submitButton("ثبت نام", () {
              if (validateAndSave()) {
                setState(() {
                  isAPIcallProcess = true;
                });

                OtpRequestCodeModel model = OtpRequestCodeModel(
                  phoneNumber: phoneNumber,
                  code: code,
                );

                APIService.otpvrifay(model).then((response) {
                  setState(() {
                    isAPIcoodcallProcess = false;
                  });
                  if (response.data != null) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  } else {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      response.message!,
                      "OK",
                      () {
                        Navigator.of(context).pop();
                      },
                    );
                  }
                });
              }
            }),
          ],
        ),
      );
*/
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
