import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../add_introduced/screen/add_introduced.dart';
import '../service/register_service.dart';

class RegisterController extends GetxController {
  RxBool obscurePasswordVisibility = true.obs;
  late RegisterService? serregister;
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController sqAnswerController = TextEditingController();
  String? securityQuestionselected = null;

  late SharedPreferences logindata;

  @override
  void onInit() {
    super.onInit();
    serregister = RegisterService();
  }

  cleartext() {
    passwordController.clear();
    usernameController.clear();
    sqAnswerController.clear();
  }

  register() async {
    serregister?.Register(usernameController.text, passwordController.text,
            securityQuestionselected as String, sqAnswerController.text)
        .then((response) async {
      if (response != false) {
        logindata = await SharedPreferences.getInstance();
        await logindata.setString(
            "token", response['data']['userToken']['token']);
        await logindata.setString("userId", response['data']['id']);

        Get.snackbar(
          "خوش امدید",
          '',
          icon: Icon(Icons.notifications, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );

        Get.offAll(AddIntroduced());
      } else {
        Get.snackbar(
          response['message'].toString(),
          '',
          icon: Icon(Icons.notifications, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }
}
