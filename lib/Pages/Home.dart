import 'package:firebase_core/firebase_core.dart';
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
import 'Account/login/WelcomeUser.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({Key? key}) : super(key: key);

  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  var resultResponsee;
  bool isApiCallProgress = true;
  String messageTitle = "Empty";
  String notificationAlert = "alert";
 // late final FirebaseMessaging _messaging;
//  late int _totalNotifications;



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
          Text(
            notificationAlert,
          ),
          Text(
            messageTitle,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
