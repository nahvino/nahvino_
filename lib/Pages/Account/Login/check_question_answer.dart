import 'package:Nahvino/Services/Login/reset_service.dart';
import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:Nahvino/Utils/TextField/question_text_filde.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../App_localizations.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/TextField/english_text_filde.dart';
import 'password.dart';
import 'registration.dart';

class NewCheckQuestionAnswer extends StatefulWidget {
  const NewCheckQuestionAnswer({
    Key? key,
  }) : super(key: key);

  @override
  State<NewCheckQuestionAnswer> createState() => _NewCheckQuestionAnswerState();
}

class _NewCheckQuestionAnswerState extends State<NewCheckQuestionAnswer> {
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
  TextEditingController usernameController = TextEditingController();
  TextEditingController sqAnswerController = TextEditingController();
  late ResetService resetservice;
  String? securityQuestionselected = null;
  late SharedPreferences logindata;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    resetservice = ResetService();
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
              'SignUp_top_text',
            )!),
        elevation: 0,
        backgroundColor: Colors.grey[50],
        leading: BackButton(
          color: Colors.black,
          onPressed: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Registration()));
          }),
        ),
      ),
      body: isApiCallProcess
          ? Center(
              child: Lottie.asset('assets/anim/login/submit-check.json',
                  height: 300, width: 300),
            )
          : SafeArea(
              child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Lottie.asset('assets/anim/login/contract.json',
                          height: 150, width: 150),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8,
                      ),
                      child: Column(
                        children: [
                          EnglishTextFilde(
                            icon: Icon(Icons.person),
                            suffixIcon: null,
                            prefixIcon: null,
                            hint: AppLocalizations.of(context)!.translate(
                              'username',
                            )!,
                            controller: usernameController,
                          ),
                          SizedBox(
                            height: 20,
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
                                        securityQuestionselected =
                                            value as String;
                                      });
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Buttontest(
                        text: AppLocalizations.of(context)!.translate(
                          'OK',
                        )!,
                        onPressed: () {
                          /*   if (usernameController.text.isEmpty) {
                            apiService.showSnackBar(
                              text: AppLocalizations.of(context)!.translate(
                                'Validusername',
                              )!,
                            );
                            return;
                          }*/
                          if (!_formKey.currentState!.validate()) {
                          } else {
                            setState(() {
                              isApiCallProcess = true;
                            });
                            resetservice
                                .checkquestionanswer(
                                    usernameController.text,
                                    securityQuestionselected as String,
                                    sqAnswerController.text)
                                .then((response) async {
                              if (response != false) {
                                resetservice.showSnackBar(
                                    text: response['message'] ??
                                        "جواب سوال درست بود");
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewPassword(data: response['data'])),
                                  (route) => false,
                                );
                              } else {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                resetservice.showSnackBar(
                                    text: response['message'] ?? "sdd");
                              }
                            });
                          }
                        }),
                  ],
                ),
              ),
            )),
    );
  }
}
