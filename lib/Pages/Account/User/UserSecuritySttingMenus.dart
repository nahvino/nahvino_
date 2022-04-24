import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../Model/User/user/viewprofile_response_model.dart';
import '../../../Services/Login/User/Config.dart';
import '../../../Services/login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Button/SttingMenusButton.dart';
import 'ChangePhoneNumber.dart';
import 'ChangePasswrod.dart';
import 'SetPhoneNumber.dart';

class UserSecuritySttingMenus extends StatefulWidget {
  const UserSecuritySttingMenus({Key? key}) : super(key: key);

  @override
  State<UserSecuritySttingMenus> createState() =>
      _UserSecuritySttingMenusState();
}

class _UserSecuritySttingMenusState extends State<UserSecuritySttingMenus> {
  bool isApiCallProgress = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  var resultResponse;

  late bool phoneNumber;
  late bool password;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      APIService.UserSecuritySttingMenus().then((response) {
        print("APIService.UserSecuritySttingMenus => $response");
        setState(() {
          isApiCallProgress = false;
          resultResponse = response;
        });
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  bool lang = false; // en => true / fa => false
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
            child: isApiCallProgress
                ? Center(
                    child: Lottie.asset('assets/anim/data.json',
                        height: 300, width: 300),
                  )
                : body(context)),
      ),
    );
  }

  Widget body(BuildContext context) => Column(
        children: [
          Column(
            children: [

              Visibility(
                visible: resultResponse['password'],
                child: SttingMenusButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePasswrod()));
                    },
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    text: 'تغییر رمز عبور'),
              ),
              SizedBox(height: 5,),
              Visibility(
                visible: resultResponse['password'],
                child: SttingMenusButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetPhoneNumber()));
                    },
                    icon: Icon(
                      Icons.phone_android,
                      color: Colors.white,
                    ),
                    text: 'موبایل'),
              ),
              SizedBox(height: 5,),
              Visibility(
                visible: resultResponse['phoneNumber'],
                child: SttingMenusButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePhoneNumber()));
                    },
                    icon: Icon(
                      Icons.phonelink_setup,
                      color: Colors.white,
                    ),
                    text: 'تغییر شماره تلفن'),
              ),
            ],
          )
        ],
      );
}
