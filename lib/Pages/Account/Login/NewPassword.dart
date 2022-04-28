import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../App_localizations.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Button/TextField.dart';
import '../../../Utils/Widget/Text.dart';
import '../User/ViewProfile.dart';
import 'AddIntroduced.dart';
import 'CodeOtpPhoneNew.dart';
import 'NewLogin.dart';
import 'SignUp.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key, required this.data, }) : super(key: key);
  final data;

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {


  bool isApiCallProcess = false;
  TextEditingController passwordController = TextEditingController();
  late APIService apiService;



  @override
  void initState() {
    super.initState();
    apiService = APIService(context);
  }

  @override
  Widget build(BuildContext context) {
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

              textspan(
                textAlign: TextAlign.right,
                text: widget.data.toString(),
                color: Colors.black,
              ),
              TextOtpPhone(
                icon: Icon(Icons.lock),
                suffixIcon: null,
                prefixIcon: null,
                hint: AppLocalizations.of(context)!.translate(
                  'Password',
                )!,
                controller: passwordController,
              ),

              Buttontest(
                  text: AppLocalizations.of(context)!.translate(
                    'OK',
                  )!,
                  onPressed: () {
                    if (passwordController.text.isEmpty) {
                      apiService.showSnackBar(text: "filed is empty!");
                      return;
                    }
                    setState(() {
                      isApiCallProcess = true;
                    });
                    apiService
                        .NewResetPassword(
                        widget.data.toString(),passwordController.text)
                        .then((response) async {

                      if (response != false) {
                        apiService.showSnackBar(
                            text: response['message'] ??
                                "جواب سوال درست بود");
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>NewLogin()),
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
    );
  }
}
