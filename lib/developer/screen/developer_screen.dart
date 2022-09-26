import 'package:Nahvino/Utils/Button/Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeveloperScreen extends StatelessWidget {
   DeveloperScreen({Key? key}) : super(key: key);
  String? token;
  String? id;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Buttonfull(
          text: "آیدی",
          color: Colors.white,
          onPressed: ()async {
            SharedPreferences preferences = await SharedPreferences.getInstance();
            Clipboard.setData(ClipboardData(text: await preferences.getString("userId")));
            id = await preferences.getString("userId");
            Get.snackbar("کپی شد", id!);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Buttonfull(
          text: "توکن",
          color: Colors.white,
          onPressed: () async{
            SharedPreferences preferences = await SharedPreferences.getInstance();
            Clipboard.setData(ClipboardData(text: await preferences.getString("token")));
            token = await preferences.getString("token");
            Get.snackbar("کپی شد", token!);


          },
        ),
      ],
    ));
  }
}
