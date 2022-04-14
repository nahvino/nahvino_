import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Button/Textsall.dart';
import '../../../app_localizations.dart';
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
  bool value = false;


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
            child:
                 body(context)),
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
                  textspan(
                    textAlign: TextAlign.center,
                    text: AppLocalizations.of(context)!.translate(
                      'Pandect',
                    )!,
                    color: Colors.black,
                  ),
                  SizedBox(width: 1,),
                  textspan(
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
                children: <Widget> [
                  Checkbox(
                    value: this.value,
                    onChanged: ( value) {
                      setState(() {
                        this.value = value!;
                      });
                    },
                  ),

                  textspan(
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
                children: <Widget> [
                  Checkbox(
                    value: this.value,
                    onChanged: ( value) {
                      setState(() {
                        this.value = value!;
                      });
                    },
                  ),
                  textspan(
                    textAlign: TextAlign.right,
                    text: AppLocalizations.of(context)!.translate(
                      'Pandecttext2',
                    )!,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 50,
              child: Buttonfull(onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyTabs()));
              }
              , color: Colors.white, text: AppLocalizations.of(context)!.translate(
                'OK',
              )!,),
            )
          ],
        ),
      ]);
}
