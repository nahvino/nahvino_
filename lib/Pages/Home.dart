import 'package:Nahvino/Pages/Account/Login/registration.dart';
import 'package:Nahvino/Utils/Button/Button.dart';
import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
                shape: BoxShape.rectangle,
                color: Colors.grey.shade300,
              ),
              child: Row(
                children: [
                  Icon(Icons.exit_to_app),
                  Footnate(text: "برای خارج شدن دوبار بزنید")
                ],
              ),
            ),
            ElevatedButton(
              child: Text("ثبت"),
              onPressed: () {
                /*
                Get.defaultDialog(
                  title: "قابلیت های جدید نحوینو",
                  titleStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Vazirmatn_Light'),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Caption1(
                        text: "- با کشیدن پیام به سمت چپ ریپلای زده میشه ",
                      ),
                      Caption1(
                        text: "- با کشیدن پیام به سمت راست ، متن پیام کپی میشه",
                      ),
                      Caption1(
                        text: "- بالا رفتن سرعت ارسال پیام ",
                      ),
                      Caption1(
                        text:
                            "- اضافه شدن قابلیت ریپورت پیام ها جهت حفظ حرمت در گروه ها",
                      ),
                      Caption1(
                        text: "- اضافه شدن قابلیت اپدیت",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Buttonfull(
                        text: "بزن بریم",
                        color: Colors.white,
                        onPressed: (() {
                          Navigator.of(context, rootNavigator: true).pop();
                        }),
                      )
                    ],
                  ),
                );
              */
              },
            )
          ],
        ),
      ),
    );
  }
}
