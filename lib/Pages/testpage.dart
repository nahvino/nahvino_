import 'package:flutter/material.dart';

import '../Utils/Button/SttingMenusButton.dart';
import '../Utils/Text/TextField.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController test =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
            child:  body(context)),
      ),
    );
  }

  body(BuildContext context) {
    return Column(children: [
      TextPassReAndLog(controller: test, hint: 'تست', icon: Icon(Icons.person), suffixIcon: null, prefixIcon: null, ),
      SttingMenusButton(onPressed: () {  }, icon: Icon(Icons.phone_android,color: Colors.white,), text: 'موبایل'),
      SttingMenusButton(onPressed: () {  }, icon: Icon(Icons.lock,color: Colors.white,), text: 'تغییر رمز عبور'),
      SttingMenusButton(onPressed: () {  }, icon: Icon(Icons.phonelink_setup,color: Colors.white,), text: 'تغییر شماره تلفن'),
    ],);
  }
}
