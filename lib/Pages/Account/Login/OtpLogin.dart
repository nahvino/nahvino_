import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:Nahvino/Pages/Account/login/SignUp.dart';
import 'package:Nahvino/Pages/Account/login/OtpCode.dart';
import 'package:Nahvino/Utils/Button/Button.dart';
import 'package:Nahvino/App_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../../Model/user/otp/otp_request_model.dart';
import '../../../Services/login/ApiService.dart';
import '../../../Utils/Text/Text.dart';

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
        body: isAPIcallProcess ?
            CircularProgressIndicator():
            _loginUI(context)
      ),
    );
  }

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
                text: AppLocalizations.of(context)!.translate(
                  'Signup_phone_btn',
                )!,
                color: Colors.black,
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
                return AppLocalizations.of(context)!.translate(
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
            text: AppLocalizations.of(context)!.translate(
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                  height: 100,
                  width: 100,
                  child: Lottie.asset('assets/anim/login/send-massage.json'),
                ),
          ],
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
