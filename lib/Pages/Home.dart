import 'package:flutter/material.dart';
import 'package:Nahvino/Pages/testpage.dart';

import '../Services/login/ApiService.dart';
import '../Utils/Button/Button.dart';
import 'Account/User/ChangePasswrod.dart';
import 'Account/User/ChangePhoneNumber.dart';
import 'Account/User/CheckCodeChangePhoneNumber.dart';
import 'Account/User/CheckCodeSetPhoneNumber.dart';
import 'Account/User/SetPhoneNumber.dart';
import 'Account/login/AddIntroduced.dart';
import 'Account/login/Pandect.dart';
import 'Account/login/Resetpassword.dart';
import 'Account/login/WelcomeUser.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({Key? key}) : super(key: key);

  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  var resultResponsee;
  bool isApiCallProgress = true;

  @override
  void initState() {
    super.initState();
    APIService.GetLastVisit().then((response) {
      setState(() {
        isApiCallProgress = false;
        resultResponsee = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Buttontest(
            text: "خوش آمدید",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomeUser()));
            },
          ),
          Buttontest(
            text: "کد معرف",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddIntroduced()));
            },
          ),
          Buttontest(
            text: "قوانین",
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Pandect()));
            },
          ),
          Buttontest(
            text: " شماره",
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChangePhoneNumber()));
            },
          ), Buttontest(
            text: " ثبت موبایل",
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SetPhoneNumber()));
            },
          ),Buttontest(
            text: " کد موبایل",
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CheckCodeSetPhoneNumber(setPhoneNumber: '',)));
            },
          ),Buttontest(
            text: " ریست رمز",
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChangePasswrod()));
            },
          ),Buttontest(
            text: "چک کد",
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CheckCodeChangePhoneNumber(currentPhoneNumber: '', newPhoneNumber: '',)));
            },
          ),Buttontest(
            text: "تست",
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TestPage()));
            },
          ),
        ],
      ),
    );
  }
}
