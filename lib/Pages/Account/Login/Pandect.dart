import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/Text.dart';
import '../../../App_localizations.dart';
import '../../../tabs.dart';

class Pandect extends StatefulWidget {
  const Pandect({Key? key}) : super(key: key);

  @override
  State<Pandect> createState() => _PandectState();
}

class _PandectState extends State<Pandect> {
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProgress = true;
  bool value1 = false;
  bool value2 = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(child: body(context)),
      ),
    );
  }

  Widget body(BuildContext context) => Column(children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
              ),
              child: Row(
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
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    value: this.value1,
                    onChanged: (value) {
                      setState(() {
                        this.value1 = value!;
                      });
                    },
                  ),
                  Footnate(
                    textAlign: TextAlign.right,
                    text: AppLocalizations.of(context)!.translate(
                      'Pandecttext1',
                    )!,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    value: this.value2,
                    onChanged: (value) {
                      setState(() {
                        this.value2 = value!;
                      });
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
                      SizedBox(width: 3,),
                      InkWell(
                        onTap: (){
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
                      SizedBox(width: 1,),
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
                onPressed: () {
                  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("dsf")));

                  if (this.value1 == false || this.value2 == false) {
                    Get.snackbar(
                      AppLocalizations.of(context)!.translate(
                        'Pandect_snackbar_TiTle',
                      )!,
                      AppLocalizations.of(context)!.translate(
                        'Pandect_snackbar',
                      )!,
                      icon: Icon(Icons.notifications, color: Colors.white),
                      snackPosition: SnackPosition.TOP,
                    );
                  } else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyTabs()));
                  }
                },
                color: Colors.white,
                text: AppLocalizations.of(context)!.translate(
                  'OK',
                )!,
              ),
            )
          ],
        ),
      ]);
}
