import 'package:Nahvino/Data/Local/view_profial_data.dart';
import 'package:Nahvino/Pages/Account/Login/add_introduced.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Services/Login/service_login.dart';
import '../../../../tabs.dart';

class LoginController extends GetxController {
  ViewProfileController databox = Get.put(ViewProfileController());

  RxBool obscurePasswordVisibility = true.obs;

  RxBool isApiCallProcess = false.obs;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences logindata;
  late ServiceLogin? serlogin;
  late Map<String, dynamic> resultResponsee;

  String? userToken;
  String? token;
  @override
  void onInit() {
    super.onInit();
    serlogin = ServiceLogin();
  }

  cleartext() {
    passwordController.clear();
    usernameController.clear();
  }

  login() async {
    isApiCallProcess.value = true;

    serlogin?.Login(usernameController.text, passwordController.text)
        .then((response) async {
      isApiCallProcess.value = false;

      if (response != false) {
        logindata = await SharedPreferences.getInstance();
        await logindata.setString(
            "token", response['data']['userToken']['token']);
        await logindata.setString("userId", response['data']['id']);
        Get.snackbar(
          'خوش آمدید',
          '',
          icon: Icon(Icons.notifications, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
        //  await Future.delayed(Duration(seconds: 2));
        databox.check();
      } else {
        // serlogin!.showSnackBar(text: response['message']);
      }
    });
  }
}
