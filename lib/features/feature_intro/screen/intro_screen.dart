import 'package:Nahvino/features/feature_auth/main/screen/registration.dart';
import 'package:Nahvino/features/feature_intro/controllers/into_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);
  IntroController intro_controller = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
          child: Text("بزن بریم"),
          onPressed: (){ intro_controller.saveInSharedPref();
          Get.offAll(Registration());
          }),
    );
  }
}
