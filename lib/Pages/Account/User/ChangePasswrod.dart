import 'package:flutter/material.dart';
import 'package:nahvino/Pages/Account/User/ViewProfile.dart';

import '../../../Services/login/ApiService.dart';
import '../../../Utils/Button/TextField.dart';
import '../../../Utils/Widget/Text.dart';
import '../../../App_localizations.dart';
import '../login/CheckQuestionAnswer.dart';
import 'UserSecuritySttingMenus.dart';

class ChangePasswrod extends StatefulWidget {
  const ChangePasswrod({Key? key}) : super(key: key);

  @override
  State<ChangePasswrod> createState() => _ChangePasswrodState();
}

class _ChangePasswrodState extends State<ChangePasswrod> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  late APIService apiService;

  @override
  void initState() {
    super.initState();
    apiService = APIService(context);
  }

  bool isApiCallProgress = true;
  bool lang = false; // en => true / fa => false
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

  Widget body(BuildContext context) => SingleChildScrollView(
    child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    onPressed: (() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UserSecuritySttingMenus()));
                    }),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.task_alt),
                    onPressed: (() {
                      if (currentPassword.text.isEmpty) {
                        apiService.showSnackBar(text: "filed is empty!");
                        return;
                      }

                      if (newPassword.text.isEmpty) {
                        apiService.showSnackBar(text: "filed is empty!");
                        return;
                      }

                      apiService.ChangePasswrod(
                              currentPassword.text, newPassword.text)
                          .then((response) async {
                        setState(() {
                          isApiCallProgress = false;
                        });
                        if (response != false) {
                          apiService.showSnackBar(
                              text: response['message'] ??
                                  "پسورد شما با موفقیت تغییر کرد");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewProfile()),
                            (route) => false,
                          );
                        } else {
                          apiService.showSnackBar(
                              text: response['message'] ?? "sdd");
                        }
                      });
                    }),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textspan(
                  textAlign: TextAlign.center,
                  text: AppLocalizations.of(context)!.translate(
                    'text_ChangePasswrod',
                  )!,
                  color: Colors.black,
                ),
              ],
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextProfile(
                controller: currentPassword,
                hint: AppLocalizations.of(context)!.translate(
                  'textfilde_currentPassword',
                )!,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckQuestionAnswer()));
                },
                child: textspan(
                  color: Colors.blue,
                  textAlign: TextAlign.center,
                  text: AppLocalizations.of(context)!.translate(
                    'SignIn_fpass_text',
                  )!,
                ),
              ),
              TextProfile(
                controller: newPassword,
                hint: AppLocalizations.of(context)!.translate(
                  'textfilde_newPassword',
                )!,
              ),
            ]),
          ],
        ),
  );
}
