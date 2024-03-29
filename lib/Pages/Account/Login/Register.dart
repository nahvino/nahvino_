import 'package:Nahvino/Pages/Account/Login/login.dart';
import 'package:Nahvino/Pages/Other/privacy_screen.dart';
import 'package:Nahvino/Pages/Other/terms_services_screen.dart';
import 'package:Nahvino/Services/Login/register_service.dart';
import 'package:Nahvino/Utils/Button/Button.dart';
import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:Nahvino/Utils/TextField/question_text_filde.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../App_localizations.dart';
import '../../../Utils/TextField/english_text_filde.dart';
import '../../../Utils/TextField/password_text_filde.dart';
import 'add_introduced.dart';
import 'registration.dart';

class NewRegister extends StatefulWidget {
  const NewRegister({
    Key? key,
  }) : super(key: key);

  @override
  State<NewRegister> createState() => _NewRegisterState();
}

class _NewRegisterState extends State<NewRegister> {

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

  bool isApiCallProcess = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController sqAnswerController = TextEditingController();
  late ServiceRegister seregister;
  bool obscurePasswordVisibility = true;
  String? securityQuestionselected = null;
  late SharedPreferences logindata;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    seregister = ServiceRegister();
  }

  @override
  Widget build(BuildContext context) {
    securityQuestion();

    return Scaffold(
      appBar: AppBar(
        title: Title3(
            color: Colors.black,
            textAlign: TextAlign.start,
            text: AppLocalizations.of(context)!.translate(
              'Signup_topR_text',
            )!),
        elevation: 0,
        backgroundColor: Colors.grey[50],
        leading: BackButton(
          color: Colors.black,
          onPressed: (() {
            cleartext();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Registration()));
          }),
        ),
      ),
      body: isApiCallProcess
          ? Center(
              child: Lottie.asset(
                  'assets/anim/login/submit-application-successfully.json',
                  height: 300,
                  width: 300),
            )
          : SafeArea(
              child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    children: [
                      Center(
                        child: Lottie.asset('assets/anim/login/contract.json',
                            height: 150, width: 150),
                      ),
                      EnglishTextFilde(
                        icon: Icon(Icons.person),
                        suffixIcon: null,
                        prefixIcon: null,
                        hint: AppLocalizations.of(context)!.translate(
                          'username',
                        )!,
                        controller: usernameController,
                      ),
                      TextPassReAndLog(
                        icon: Icon(
                          Icons.lock,
                        ),
                        passwordInVisible: obscurePasswordVisibility,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePasswordVisibility =
                                    !obscurePasswordVisibility;
                              });
                            },
                            icon: Icon(obscurePasswordVisibility == true
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        hint: AppLocalizations.of(context)!.translate(
                          'Password',
                        )!,
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: Row(
                          children: [
                            Icon(Icons.question_answer,
                                size: 28, color: Colors.black45),
                            SizedBox(
                              width: 14,
                            ),
                            DropdownButton(
                                hint: Text(
                                  AppLocalizations.of(context)!.translate(
                                    'sAnswer',
                                  )!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Vazirmatn_Medium'),
                                ),
                                value: securityQuestionselected,
                                items: listDrap,
                                onChanged: (value) {
                                  setState(() {
                                    securityQuestionselected = value as String;
                                  });
                                }),
                          ],
                        ),
                      ),
                      QuestionTextFilde(
                        icon: Icon(Icons.security),
                        suffixIcon: null,
                        prefixIcon: null,
                        hint: AppLocalizations.of(context)!.translate(
                          'sqAnswer',
                        )!,
                        controller: sqAnswerController,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 35,
                          left: 39,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Caption1(
                              color: Colors.black,
                              textAlign: TextAlign.center,
                              text: "قبلا ثبت نام کرده اید؟",
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder:
                                            (context) => /*RegisterPage()*/ NewLogin()));
                              },
                              child: Caption1(
                                color: Colors.cyan,
                                textAlign: TextAlign.center,
                                text: "به صفحه ورود بروید",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(TermsservicesScreen());
                            },
                            child: Caption1(
                              color: Colors.cyan,
                              textAlign: TextAlign.center,
                              text: AppLocalizations.of(context)!.translate(
                                'Termsandservices',
                              )!,
                            ),
                          ),
                          Caption1(
                            color: Colors.black,
                            textAlign: TextAlign.center,
                            text: AppLocalizations.of(context)!.translate(
                              'And',
                            )!,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(PrivacyScreen());
                            },
                            child: Caption1(
                              color: Colors.cyan,
                              textAlign: TextAlign.center,
                              text: AppLocalizations.of(context)!.translate(
                                'Privacy',
                              )!,
                            ),
                          ),
                          Caption1(
                            color: Colors.black,
                            textAlign: TextAlign.center,
                            text: AppLocalizations.of(context)!.translate(
                              'IAccept',
                            )!,
                          ),
                        ],
                      ),
                      Buttontest(
                          text: AppLocalizations.of(context)!.translate(
                            'OK',
                          )!,
                          onPressed: () {
                            /*           if (usernameController.text.isEmpty) {
                                apiService.showSnackBar(
                                  text: AppLocalizations.of(context)!.translate(
                                    'Validusername',
                                  )!,
                                );
                                return;
                              }
                              if (passwordController.text.isEmpty) {
                                apiService.showSnackBar(
                                  text: AppLocalizations.of(context)!.translate(
                                    'ValidPassword',
                                  )!,
                                );
                                return;
                              }
                              if (sqAnswerController.text.isEmpty) {
                                apiService.showSnackBar(
                                  text: AppLocalizations.of(context)!.translate(
                                    'ValidsqAnswer',
                                  )!,
                                );
                                return;
                              }*/
                            if (!_formKey.currentState!.validate()) {
                            } else {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              seregister.Register(
                                      usernameController.text,
                                      passwordController.text,
                                      securityQuestionselected as String,
                                      sqAnswerController.text)
                                  .then((response) async {
                                if (response != false) {
                                  logindata =
                                      await SharedPreferences.getInstance();
                                  await logindata.setString("token",
                                      response['data']['userToken']['token']);
                                  await logindata.setString(
                                      "userId", response['data']['id']);

                                  seregister.showSnackBar(
                                      text: AppLocalizations.of(context)!
                                          .translate(
                                    'Welcome',
                                  )!);

                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddIntroduced()),
                                    (route) => false,
                                  );
                                } else {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  seregister.showSnackBar(
                                      text: response['message']);
                                }
                              });
                              cleartext();
                            }
                          }),
                    ],
                  ),
                ),
              ),
            )),
    );
  }

  cleartext() {
    passwordController.clear();
    usernameController.clear();
    sqAnswerController.clear();
  }
}
