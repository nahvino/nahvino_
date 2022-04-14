import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../Services/login/api_service.dart';

class UserSecuritySttingMenus extends StatefulWidget {
  const UserSecuritySttingMenus({Key? key}) : super(key: key);

  @override
  State<UserSecuritySttingMenus> createState() => _UserSecuritySttingMenusState();
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
      Text(resultResponse!.phoneNumber ?? "Guest",),
      Text(resultResponse!.password ?? "Guest",)
    ],
  );

}
