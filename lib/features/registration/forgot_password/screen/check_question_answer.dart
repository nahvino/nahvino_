import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/english_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/question_text_filde.dart';
import 'package:Nahvino/features/registration/forgot_password/screen/Password.dart';
import 'package:Nahvino/features/registration/forgot_password/service/reset_service.dart';
import 'package:Nahvino/features/registration/main/screen/registration.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckQuestionAnswer extends StatefulWidget {
  const CheckQuestionAnswer({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckQuestionAnswer> createState() => _CheckQuestionAnswerState();
}

class _CheckQuestionAnswerState extends State<CheckQuestionAnswer> {
  List<DropdownMenuItem<String>> listDrap = [];
  void securityQuestion() {
    listDrap = [];
    listDrap.add(new DropdownMenuItem(
        child: Text(AppLocalizations.of(context)!.translate(
          'first_teacher',
        )!,), value: "0"));
    listDrap.add(new DropdownMenuItem(
        child: Text(AppLocalizations.of(context)!.translate(
          'your_first_school',
        )!,), value: "1"));
    listDrap.add(new DropdownMenuItem(
        child: Text(AppLocalizations.of(context)!.translate(
          'city_where_you_were_born',
        )!,), value: "2"));
    listDrap.add(new DropdownMenuItem(
        child: Text(AppLocalizations.of(context)!.translate(
          'model_do_you_like',
        )!,), value: "3"));
    listDrap.add(new DropdownMenuItem(
        child: Text(AppLocalizations.of(context)!.translate(
          'school_friend',
        )!,), value: "4"));
    listDrap.add(new DropdownMenuItem(
        child: Text(AppLocalizations.of(context)!.translate(
          'good_movie',
        )!,), value: "5"));
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
                    Buttonfull(
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
                                    text: response['message']);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Password(data: response['data'])),
                                  (route) => false,
                                );
                              } else {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                resetservice.showSnackBar(
                                    text: response['message']);
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
