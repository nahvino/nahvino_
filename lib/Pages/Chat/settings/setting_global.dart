import 'package:Nahvino/Pages/Chat/settings/chat_setting.dart';
import 'package:Nahvino/Utils/Button/SttingMenusButton.dart';
import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingGlobal extends StatelessWidget {
  const SettingGlobal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.cyan.shade800,
          title: Body(text: "تنظیمات")),
      body: global_body(context),
    );
  }

  Widget global_body(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 7,
          ),
          SttingMenusButton(
              text: "تنظیمات اعلان",
              onPressed: () => "",
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              )),
          SizedBox(
            height: 7,
          ),
          SttingMenusButton(
              text: "تنظیمات چت",
              onPressed: () => Get.to(ChatSetting()),
              icon: Icon(
                Icons.chat_outlined,
                color: Colors.white,
              )),
        ],
      ),
    ));
  }
}
