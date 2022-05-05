import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../App_localizations.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Button/TextField.dart';
import '../../../Utils/Widget/Text.dart';
import '../../../controllers/getx/NewRegisterController.dart';
import '../User/ViewProfile.dart';
import 'AddIntroduced.dart';
import 'CodeOtpPhoneNew.dart';
import 'SignUp.dart';

class NewRegister extends StatefulWidget {
  const NewRegister({Key? key, }) : super(key: key);


  @override
  State<NewRegister> createState() => _NewRegisterState();
}

class _NewRegisterState extends State<NewRegister> {

  NewRegisterController newRegisterController = Get.put(NewRegisterController());


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
  TextEditingController passwordController = TextEditingController();
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
      body:Obx(() =>
      isApiCallProcess
          ? Center(
        child: Lottie.asset('assets/anim/login/submit-application-successfully.json',
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
              TextAll(
                icon: Icon(Icons.person),
                suffixIcon: null,
                prefixIcon: null,
                hint: AppLocalizations.of(context)!.translate(
                  'username',
                )!,
                controller: usernameController,
              ),
              TextPassReAndLog(
                icon: Icon(Icons.lock),
                passwordInVisible: newRegisterController.obscurePasswordVisibility.value,
                suffix: IconButton(onPressed: () {
                  newRegisterController.obscurePasswordVisibility.value =
                  !newRegisterController.obscurePasswordVisibility.value;
                },
                    icon: Icon(
                        newRegisterController.obscurePasswordVisibility == true
                            ? Icons.visibility_off
                            : Icons.visibility)),
                hint: AppLocalizations.of(context)!.translate(
                  'Password',
                )!,
                controller: passwordController,
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(right: 20,left: 0),
                child: DropdownButton(
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
              ),
              SizedBox(height: 5,),
              TextAll(
                icon: Icon(Icons.security),
                suffixIcon: null,
                prefixIcon: null,
                hint: AppLocalizations.of(context)!.translate(
                  'sqAnswer',
                )!,
                controller: sqAnswerController,
              ),
              SizedBox(height: 15,),
              Buttontest(
                  text: AppLocalizations.of(context)!.translate(
                    'OK',
                  )!,
                  onPressed: () {
                    if (usernameController.text.isEmpty) {
                      apiService.showSnackBar(text: "filed is empty!");
                      return;
                    }

                    setState(() {
                      isApiCallProcess = true;
                    });

                    apiService
                        .NewRegister(
                        usernameController.text,passwordController.text,securityQuestionselected as String,sqAnswerController.text)
                        .then((response) async {
                      if (response != false) {
                        logindata = await SharedPreferences.getInstance();
                        await logindata.setString(
                            "token", response['data']['userToken']['token']);
                        await logindata.setString("userId", response['data']['id']);

                        apiService.showSnackBar(
                            text: AppLocalizations.of(context)!
                                .translate(
                              'Welcome',
                            )!);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>AddIntroduced()),
                              (route) => false,
                        );
                      } else {
                        apiService.showSnackBar(
                            text: response['message'] ?? "sdd");
                      }
                    });


                  }),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
