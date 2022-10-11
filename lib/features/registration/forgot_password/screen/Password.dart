import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/password_text_filde.dart';
import 'package:Nahvino/core/shared/presentation/controllers/getx/Utils/password_controller.dart';
import 'package:Nahvino/features/registration/forgot_password/service/reset_service.dart';
import 'package:Nahvino/features/registration/login/screen/Login.dart';
import 'package:Nahvino/features/registration/main/screen/registration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Password extends StatefulWidget {
  const Password({
    Key? key,
    required this.data,
  }) : super(key: key);
  final data;

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  PasswordController passwordcontroller = Get.put(PasswordController());
  bool isApiCallProcess = false;
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ResetService resetservice;

  @override
  void initState() {
    super.initState();
    resetservice = ResetService();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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

                      /* Callout(
                textAlign: TextAlign.right,
                text: widget.data.toString(),
                color: Colors.black,
              ),*/
                      /*   TextPassReAndLog(
                icon: Icon(Icons.lock),
                suffixIcon: null,
                prefixIcon: null,
                hint: AppLocalizations.of(context)!.translate(
                  'Password',
                )!,
                controller: passwordController,
              ),*/
                      TextPassReAndLog(
                        icon: Icon(Icons.lock),
                        passwordInVisible:
                            passwordcontroller.obscurePasswordVisibility.value,
                        suffix: IconButton(
                            onPressed: () {
                              passwordcontroller
                                      .obscurePasswordVisibility.value =
                                  !passwordcontroller
                                      .obscurePasswordVisibility.value;
                            },
                            icon: Icon(
                                passwordcontroller.obscurePasswordVisibility ==
                                        true
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                        hint: AppLocalizations.of(context)!.translate(
                          'Password',
                        )!,
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Buttonfull(
                          text: AppLocalizations.of(context)!.translate(
                            'OK',
                          )!,
                          onPressed: () {
                            /*    if (passwordController.text.isEmpty) {
                        apiService.showSnackBar(text: AppLocalizations.of(context)!.translate(
                          'ValidPassword',
                        )!,);
                        return;
                      }*/
                            if (!_formKey.currentState!.validate()) {
                            } else {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              resetservice
                                  .resetpassword(widget.data.toString(),
                                      passwordController.text)
                                  .then((response) async {
                                if (response != false) {
                                  resetservice.showSnackBar(
                                      text: response['message']);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
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
    });
  }
}
