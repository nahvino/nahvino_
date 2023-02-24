import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/english_text_filde.dart';
import 'package:Nahvino/core/Utils/TextField/question_text_filde.dart';
import 'package:Nahvino/core/Utils/drop_down/dropdownbtn.dart';
import 'package:Nahvino/features/feature_auth/forgot_password/controllers/check_question_answer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckQuestionAnswerScreen extends StatefulWidget {
  CheckQuestionAnswerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckQuestionAnswerScreen> createState() => _CheckQuestionAnswerScreenState();
}

class _CheckQuestionAnswerScreenState extends State<CheckQuestionAnswerScreen> {
  CheckQuestionAnswerController cqaa_controller =
      Get.put(CheckQuestionAnswerController());
  String? securityQuestionselected;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


      return SizedBox(
        height: height * 0.6,
        child: Form(
          key: cqaa_controller.formKey,
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
                  height: 10,
                ),
                Title3(
                    color: Colors.black,
                    textAlign: TextAlign.start,
                    text: AppLocalizations.of(context)!.translate(
                      'SignUp_top_text',
                    )!),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                  ),
                  child: Column(
                    children: [
                      EnglishTextFilde(
                        suffixIcon: null,
                        prefixIcon: null,
                        hint: AppLocalizations.of(context)!.translate(
                          'username',
                        )!,
                        controller: cqaa_controller.usernameController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DrapDoonButton(
                        value: securityQuestionselected,
                        onChanged: (value) {
                          setState(() {
                            securityQuestionselected = value as String;
                            print(securityQuestionselected);
                          });
                          cqaa_controller.securityQuestionselected.value = securityQuestionselected!;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionTextFilde(
                        suffixIcon: null,
                        prefixIcon: null,
                        hint: AppLocalizations.of(context)!.translate(
                          'sqAnswer',
                        )!,
                        controller: cqaa_controller.sqAnswerController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.35,
                  child: Buttonfull(
                      text: AppLocalizations.of(context)!.translate(
                        'OK',
                      )!,
                      onPressed: () {
                        cqaa_controller.start_servisce(context);
                      }),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
