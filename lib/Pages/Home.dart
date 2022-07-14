import 'package:Nahvino/Pages/Account/Login/registration.dart';
import 'package:flutter/material.dart';
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
            ElevatedButton(
              child: Text("ثبت"),
              onPressed: () async {
                final preferences = await SharedPreferences.getInstance();
                await preferences.clear();

                Future.delayed(const Duration(milliseconds: 1000), () {
                  // exit(0);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Registration()),
                  //   (route) => false,
                  // );
                  Get.offAll(Registration());
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
