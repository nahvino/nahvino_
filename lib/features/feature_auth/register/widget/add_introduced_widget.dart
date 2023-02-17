import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/public_text_filde.dart';
import 'package:Nahvino/features/feature_auth/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddIntroducedWidget extends StatelessWidget {
  AddIntroducedWidget({Key? key}) : super(key: key);
  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return (registerController.profileUserModelResponse == null)
        ? Container(child: CircularProgressIndicator())
        : Column(children: [
      GetBuilder<RegisterController>(builder: (logic) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    right: MediaQuery
                        .of(context)
                        .size
                        .height * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Subhead(
                      textAlign: TextAlign.right,
                      text: registerController.profileUserModelResponse!
                          .userName,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 03,
                    ),
                    Callout(
                      textAlign: TextAlign.right,
                      text: AppLocalizations.of(context)!.translate(
                        'nahvinoismaslk',
                      )!,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PublicTextFilde(
                    hint: AppLocalizations.of(context)!.translate(
                      'AddIntroducedhint',
                    )!,
                    controller: registerController.identifierCodeController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: Buttonfull(
                      text: AppLocalizations.of(context)!.translate(
                        'OK',
                      )!,
                      onPressed: () =>
                          registerController.addIntroduced(context),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    child: Buttonfull(
                      text: AppLocalizations.of(context)!.translate(
                        'NotIntroduced',
                      )!,
                      onPressed: () =>
                          registerController.addNotIntroduced(context),
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }


}
