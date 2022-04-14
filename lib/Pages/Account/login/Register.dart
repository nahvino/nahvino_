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
import '../../../Utils/Button/Textsall.dart';
import 'AddIntroduced.dart';

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
  String? userToken;
  String? token;

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
                textspan(
                  color: Colors.black,
                  textAlign: TextAlign.center,
                  text: AppLocalizations.of(context)!.translate(
                    'SignIn_top_text',
                  )!,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.17,
                right: 35,
                left: 35),
            child: FormHelper.inputFieldWidget(
              context,
              "username",
              AppLocalizations.of(context)!.translate(
                'username',
              )!,
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return  AppLocalizations.of(context)!.translate(
                    'Validusername',
                  )!;
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
                top: MediaQuery.of(context).size.height * 0.29,
                right: 35,
                left: 35),
            child: FormHelper.inputFieldWidget(
              context,
              "password",
              AppLocalizations.of(context)!.translate(
                'Password',
              )!,
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return  AppLocalizations.of(context)!.translate(
                    'ValidPassword',
                  )!;
                }
                return null;
              },
              (onSavedVal) {
                password = onSavedVal;
              },
              initialValue: "",
              obscureText: hidePassword,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility)),
              borderFocusColor: Colors.grey,
              prefixIconColor: Colors.black,
              borderColor: Colors.green,
              textColor: Colors.black,
              hintColor: Colors.black,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.39,
            ),
            alignment: Alignment.topCenter,
            child: DropdownButton(
                hint: Text(AppLocalizations.of(context)!.translate(
                  'sAnswer',
                )!,),
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
                top: MediaQuery.of(context).size.height * 0.46,
                right: 35,
                left: 35),
            child: FormHelper.inputFieldWidget(
              context,
              "sqAnswer",
              AppLocalizations.of(context)!.translate(
                'sqAnswer',
              )!,
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return  AppLocalizations.of(context)!.translate(
                    'ValidsqAnswer',
                  )!;
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
                top: MediaQuery.of(context).size.height * 0.58,
                right: 110,
                left: 110),
            child: Buttontest(
                text: AppLocalizations.of(context)!.translate(
                  'register',
                )!,
                onPressed: () {
                  if (validateAndSave()) {
                    setState(() {
                      isApiCallProcess = true;
                    });

                    RegisterRequestModel model = RegisterRequestModel(
                        userName: userName,
                        password: password,
                        securityQuestion: securityQuestionselected as String,
                        sqAnswer: sqAnswer);

                    APIService.register(model).then((response) async {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      //if (response.data != null) {
                      if (response != false) {
                        logindata = await SharedPreferences.getInstance();
                        await logindata.setString(
                            "token", response['userToken']['token']);
                        await logindata.setString("userId", response['id']);

                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          AppLocalizations.of(context)!.translate(
                            'Successful',
                          )!,
                          //"Registration Successful.",
                          //"OK"
                          AppLocalizations.of(context)!.translate(
                            'OK',
                          )!,
                          () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddIntroduced()));
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
