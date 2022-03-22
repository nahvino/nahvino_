import 'package:flutter/material.dart';
import 'package:nahvino/Login/sign_up.dart';
import 'package:nahvino/Model/user/login/login_request_model.dart';
import 'package:nahvino/Pages/Account/login/ResetPasswoed.dart';
import 'package:nahvino/Services/login/api_service.dart';
import 'package:nahvino/Services/login/user/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../../app_localizations.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String name = "";
  bool hidePassword = true;
  bool isApiCallProcess = false;
  String? userName;
  String? password;
  late SharedPreferences logindata;
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
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  @override
  Widget _loginUI(BuildContext context) {
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
                top: MediaQuery.of(context).size.height * 0.35,
                right: 45,
                left: 45),
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPasswoedPage()));
              },
              child: Text(
                AppLocalizations.of(context)!.translate(
                  'SignIn_btn_text',
                )!,
                style: TextStyle(fontSize: 14, fontFamily: 'byekan'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.42,
                right: 110,
                left: 110),
            child: FormHelper.submitButton("Login", () {
              if (validateAndSave()) {
                setState(() {
                  isApiCallProcess = true;
                });

                LoginRequestModel model =
                    LoginRequestModel(userName: userName!, password: password!);

                APIService.login(model).then((response) {
                  setState(() {
                    isApiCallProcess = false;
                  });
                  if (response) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  } else {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      "Invalid Username/Password !!",
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

  Future<void> check_if_aleedy_login() async {
    logindata = await SharedPreferences.getInstance();
    var newuser = (logindata.getBool('login') ?? true);

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
