import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_auth/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PandectWidget extends StatelessWidget {
  PandectWidget({Key? key}) : super(key: key);
  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Obx(() {
      return Column(children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Caption1(
                  textAlign: TextAlign.center,
                  text: AppLocalizations.of(context)!.translate(
                    'Pandect',
                  )!,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 1,
                ),
                Caption1(
                  textAlign: TextAlign.center,
                  text: AppLocalizations.of(context)!.translate(
                    'PandectPagetop',
                  )!,
                  color: Colors.green,
                ),
              ],
            ),
            SizedBox(height: height * 0.02,),
            Padding(
              padding:  EdgeInsets.only(right: width*0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    value: this.registerController.value1.value,
                    onChanged: (value) {
                      this.registerController.value1.value = value!;
                    },
                  ),
                  Flexible(
                    child: Footnate( 
                      textAlign: TextAlign.right,
                      text: AppLocalizations.of(context)!.translate(
                        'Pandecttext1',
                      )!,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(right: width*0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    value:  this.registerController.value2.value,
                    onChanged: (value) {
                      this.registerController.value2.value = value!;

                    },
                  ),
                  Row(
                    children: [
                      Footnate(
                        textAlign: TextAlign.right,
                        text: AppLocalizations.of(context)!.translate(
                          'Pandecttext2',
                        )!,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      InkWell(
                        onTap: () {
                          /*
                          showDialog<void>(context: context, builder: (context) => RulesDialog());*/
                        },
                        child: Footnate(
                          textAlign: TextAlign.right,
                          text: AppLocalizations.of(context)!.translate(
                            'Pandecttext3',
                          )!,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Footnate(
                        textAlign: TextAlign.right,
                        text: AppLocalizations.of(context)!.translate(
                          'Pandecttext4',
                        )!,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: Get.width,
              child: Buttonfull(
                onPressed: () => registerController.pandect_btn(),
                color: Colors.white,
                text: AppLocalizations.of(context)!.translate(
                  'OK',
                )!,
              ),
            )
          ],
        ),
      ]);
    });;
  }
}
