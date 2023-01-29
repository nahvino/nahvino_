import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/password_text_filde.dart';
import 'package:Nahvino/features/feature_auth/forgot_password/controllers/password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordScreen extends StatelessWidget {
  PasswordScreen({
    Key? key,
  }) : super(key: key);

  WightPasswordController passcontroller = Get.put(WightPasswordController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.3,
      child: Form(
        key: passcontroller.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 20,
                    child: Card(
                      elevation: 0,
                      color: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Title3(
                  color: Colors.black,
                  textAlign: TextAlign.start,
                  text: AppLocalizations.of(context)!.translate(
                    'SignUp_top_text',
                  )!),
              SizedBox(
                height: height * 0.02,
              ),
              TextPassReAndLog(
                hint: AppLocalizations.of(context)!.translate(
                  'Password',
                )!,
                controller: passcontroller.passwordController,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: width * 0.35,
                child: Buttonfull(
                    text: AppLocalizations.of(context)!.translate(
                      'OK',
                    )!,
                    onPressed: () => passcontroller.startService(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
