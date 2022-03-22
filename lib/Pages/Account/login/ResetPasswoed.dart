import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../../Login/sign_up.dart';

class ResetPasswoedPage extends StatefulWidget {
  const ResetPasswoedPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswoedPage> createState() => _SignInState();
}

class _SignInState extends State<ResetPasswoedPage> {
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String name = "";
  bool hidePassword = true;
  bool isApiCallProcess = false;
  String? userName;
  int? securityQuestion;
  String? password;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _passwordUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  @override
  Widget _passwordUI(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
              right: 10,
              left: 10),
          child: BackButton(
            onPressed: (() {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            }),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.2,
              right: 35,
              left: 35),
          child: FormHelper.inputFieldWidget(
            context,
            "username",
            "نام کاربری",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Username con\ ' t be empty.";
              }
              return null;
            },
            (onSavedVal) {
              userName = onSavedVal;
            },
            borderFocusColor: Colors.grey,
            prefixIconColor: Colors.black,
            borderColor: Colors.green,
            textColor: Colors.black,
            hintColor: Colors.black,
          ),
        ),
        /*
        Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.4,
              right: 35,
              left: 35),
              
          child: 

          ),*/
      ]),
    );
  }
}
