import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nahvino/Pages/Account/login/sign_up.dart';
import 'package:nahvino/Model/user/login/register_request_model.dart';
import 'package:nahvino/Services/login/api_service.dart';
import 'package:nahvino/Services/login/user/config.dart';
import 'package:nahvino/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../../Utils/Button/Button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> listDrap = [];
  void securityQuestion() {
    listDrap = [];
    listDrap.add(new DropdownMenuItem(
        child: Text("نام اولین معلم شما چیست؟"), value: "0"));
    listDrap.add(new DropdownMenuItem(
        child: Text("نام اولین مدرسه شما چیست؟"), value: "1"));
    listDrap.add(new DropdownMenuItem(
        child: Text("نام شهری که در آن متولد شدید چیست؟"), value: "2"));
    listDrap.add(new DropdownMenuItem(
        child: Text("چه مدل ماشینی را میپسندید؟"), value: "3"));
    listDrap.add(new DropdownMenuItem(
        child: Text("نام اولین دوست دوران مدرسه شما چیست؟"), value: "4"));
    listDrap.add(new DropdownMenuItem(
        child: Text("نام یک فیلم خوب را بنویسید؟"), value: "5"));
  }

  String name = "";
  bool hidePassword = true;
  bool isApiCallProcess = false;
  String? userName;
  String? password;
  //int? securityQuestion;
  //int? securityQuestionselected;
  String? securityQuestionselected = null;
  String? sqAnswer;

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
    securityQuestion();
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
            ),
            alignment: Alignment.topCenter,
            child: DropdownButton(
                hint: Text("سوال امنیتی"),
                value: securityQuestionselected,
                items: listDrap,
                onChanged: (value) {
                  setState(() {
                    securityQuestionselected = value as String;
                  });
                }),
          ),

          /*DropdownButton(
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          child: Text(item),
                          value: item,
                        ))
                    .toList(),
                value: index,
                hint: Text("سوال امنیتی"),
                onChanged: (value) {
                  setState(() {
                    this.index == value as int;
                  });
                },
              )),
              */
/*
                FormHelper.inputFieldWidget(
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
                securityQuestionselected = (onSavedVal);
              },
              borderFocusColor: Colors.grey,
              prefixIconColor: Colors.black,
              borderColor: Colors.green,
              textColor: Colors.black,
              hintColor: Colors.black,
            ),
          ),*/
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
            child: Buttontest(text:"ثبت نام", onPressed: () {
              if (validateAndSave()) {
                setState(() {
                  isApiCallProcess = true;
                });

                RegisterRequestModel model = RegisterRequestModel(
                    userName: userName,
                    password: password,
                    securityQuestion: securityQuestionselected as String,
                    sqAnswer: sqAnswer);

                APIService.register(model).then((response) {
                  setState(() {
                    isApiCallProcess = false;
                  });

                  if (response.data != null) {
/*
                    logindata = await SharedPreferences.getInstance();
                    await logindata.setString("token", response['userToken']['token']);
                    */
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      "Registration Successful. Please login to the account",
                      "OK",
                      () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/viewprofile',
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
}
