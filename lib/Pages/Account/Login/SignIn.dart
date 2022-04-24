import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nahvino/Pages/Account/login/SignUp.dart';
import 'package:nahvino/Model/user/login/login_request_model.dart';
import 'package:nahvino/Pages/Account/login/CheckQuestionAnswer.dart';
import 'package:nahvino/Services/login/ApiService.dart';
import 'package:nahvino/Services/login/user/Config.dart';
import 'package:nahvino/Utils/Button/TextField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Widget/Text.dart';
import '../../../App_localizations.dart';
import '../../../tabs.dart';
import '../User/ViewProfile.dart';

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
  String? data;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    right: 20,
                   ),
                child: BackButton(
                  onPressed: (() {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => SignUp()));
                  }),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 20),
                height: 80,
                width: 80 ,
                child: Lottie.asset('assets/anim/login/key-login.json'),
              ),
            ],
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

                  textAlign: TextAlign.center, text:    AppLocalizations.of(context)!.translate(
                  'SignIn_top_text',
                )!, color: Colors.black,

                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15,
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
                top: MediaQuery.of(context).size.height * 0.27,
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
              suffixIcon: IconButton(onPressed: (){
                setState(() {
                  hidePassword=!hidePassword;
                });
              }, icon: Icon(hidePassword?Icons.visibility_off:Icons.visibility)),
              borderFocusColor: Colors.grey,
              prefixIconColor: Colors.black,
              borderColor: Colors.green,
              textColor: Colors.black,
              hintColor: Colors.black,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.37,
                right: 45,
                left: 45),
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckQuestionAnswer()));
              },
              child: textspan(color: Colors.black, textAlign: TextAlign.center, text:  AppLocalizations.of(context)!.translate(
                'SignIn_fpass_text',
              )!,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.44,
                right: 110,
                left: 110),
            child: Buttontest(
                text: AppLocalizations.of(context)!.translate(
                  'Login',
                )!,
                onPressed: () {
                  if (validateAndSave()) {
                    setState(() {
                      isApiCallProcess = true;
                    });

                    LoginRequestModel model = LoginRequestModel(
                        userName: userName!, password: password!);

                    APIService.login(model).then((response) async {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      if (response != false) {
                        logindata = await SharedPreferences.getInstance();
                        await logindata.setString(
                            "token", response['userToken']['token']);
                        await logindata.setString("userId", response['id']);

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => MyTabs()));
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
