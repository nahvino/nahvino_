import 'package:flutter/material.dart';
import 'package:nahvino/Login/sign_up.dart';
import 'package:nahvino/Model/user/login/register_request_model.dart';
import 'package:nahvino/Services/login/api_service.dart';
import 'package:nahvino/Services/login/user/config.dart';
import 'package:nahvino/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String name = "";
  bool hidePassword = true;
  bool isApiCallProcess = false;
  String? userName;
  String? password;
  int? securityQuestion;
  String? sqAnswer;

  late SharedPreferences registerdata;
  @override
  void initState() {
    check_if_aleedy_register();
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
            child: _registerUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  @override
  Widget _registerUI(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
              "username",
              "username",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Username con\ ' t be empty.";
                }
                return null;
              },
              (onSavedVal) {
                userName = onSavedVal;
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
                top: MediaQuery.of(context).size.height * 0.28,
                right: 35,
                left: 35),
            child: FormHelper.inputFieldWidget(
              context,
              "password",
              "password",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Username con\ ' t be empty.";
                }
                return null;
              },
              (onSavedVal) {
                password = onSavedVal;
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
                top: MediaQuery.of(context).size.height * 0.36,
                right: 35,
                left: 35),
            child: FormHelper.inputFieldWidget(
              context,
              "securityQuestion",
              "securityQuestion",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Username con\ ' t be empty.";
                }
                return null;
              },
              (onSavedVal) {
                securityQuestion = int.parse(onSavedVal) ;
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
                top: MediaQuery.of(context).size.height * 0.44,
                right: 35,
                left: 35),
            child: FormHelper.inputFieldWidget(
              context,
              "sqAnswer",
              "sqAnswer",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Username con\ ' t be empty.";
                }
                return null;
              },
              (onSavedVal) {
                sqAnswer = onSavedVal;
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
                top: MediaQuery.of(context).size.height * 0.53,
                right: 110,
                left: 110),
            child: FormHelper.submitButton("ثبت نام", () {
              if (validateAndSave()) {
                setState(() {
                  isApiCallProcess = true;
                });

                RegisterRequestModel model = RegisterRequestModel(
                    userName: userName,
                    password: password,
                    securityQuestion: securityQuestion!,
                    sqAnswer: sqAnswer);

                APIService.register(model).then((response) {
                  setState(() {
                    isApiCallProcess = false;
                  });

                  if (response.data != null) {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      "Registration Successful. Please login to the account",
                      "OK",
                      () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      },
                    );
                  } else {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      response.message,
                      "OK",
                      () {
                        Navigator.of(context).pop();
                      },
                    );
                  }
                });
              }
            }),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> check_if_aleedy_register() async {
    registerdata = await SharedPreferences.getInstance();
    var newuser = (registerdata.getBool('register') ?? true);

    print(newuser);
    if (newuser == false) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
      );
    }
  }
}
