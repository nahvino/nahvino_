import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../App_localizations.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/TextField.dart';
import '../../../Utils/Text/Text.dart';
import 'Password.dart';
import 'SignUp.dart';

class NewCheckQuestionAnswer extends StatefulWidget {
  const NewCheckQuestionAnswer({Key? key, }) : super(key: key);


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
  late APIService apiService;
  String? securityQuestionselected = null;
  late SharedPreferences logindata;


  @override
  void initState() {
    super.initState();
    apiService = APIService(context);
  }

  @override
  Widget build(BuildContext context) {
    securityQuestion();

    return Scaffold(
      appBar: AppBar(
        title:Title3(color: Colors.black, textAlign: TextAlign.start, text: AppLocalizations.of(context)!.translate(
          'SignUp_top_text',
        )!),
        elevation: 0,
        backgroundColor: Colors.grey[50],
        leading: BackButton(
          color: Colors.black,
          onPressed: (() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          }),
        ),
      ),
      body: isApiCallProcess
          ? Center(
        child: Lottie.asset('assets/anim/login/submit-check.json',
            height: 300, width: 300),
      )
          : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Lottie.asset('assets/anim/login/contract.json',
                    height: 150, width: 150),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 25),
                child: Column(
                  children: [
                    TextAll(
                      icon: Icon(Icons.person),
                      suffixIcon: null,
                      prefixIcon: null,
                      hint: AppLocalizations.of(context)!.translate(
                        'username',
                      )!,
                      controller: usernameController,
                    ),
                    SizedBox(height: 20,),
                    DropdownButton(
                        hint: Text(
                          AppLocalizations.of(context)!.translate(
                            'sAnswer',
                          )!,
                        ),
                        value: securityQuestionselected,
                        items: listDrap,
                        onChanged: (value) {
                          setState(() {
                            securityQuestionselected = value as String;
                          });
                        }),
                    SizedBox(height: 10,),
                    TextAll(
                      icon: Icon(Icons.security),
                      suffixIcon: null,
                      prefixIcon: null,
                      hint: AppLocalizations.of(context)!.translate(
                        'sqAnswer',
                      )!,
                      controller: sqAnswerController,
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),

              Buttontest(
                  text: AppLocalizations.of(context)!.translate(
                    'OK',
                  )!,
                  onPressed: () {
                    if (usernameController.text.isEmpty) {
                      apiService.showSnackBar(text:AppLocalizations.of(context)!.translate(
                        'Validusername',
                      )!,);
                      return;
                    }
                    setState(() {
                      isApiCallProcess = true;
                    });
                    apiService
                        .NewCheckQuestionAnswer(
                        usernameController.text,securityQuestionselected as String,sqAnswerController.text)
                        .then((response) async {

                      if (response != false) {
                        apiService.showSnackBar(
                            text: response['message'] ??
                                "جواب سوال درست بود");
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>NewPassword(data: response['data'])),
                              (route) => false,
                        );
                      } else {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        apiService.showSnackBar(
                            text: response['message'] ?? "sdd");
                      }
                    });


                  }),
            ],
          ),
        ),
      ),
    );
  }
}
