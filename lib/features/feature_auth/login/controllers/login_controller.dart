import 'package:Nahvino/features/feature_profile/view_profile/data/view_profial_data.dart';
import 'package:Nahvino/features/feature_auth/login/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/login_service.dart';

class LoginController extends GetxController {
  ViewProfileController databox = Get.put(ViewProfileController());

  RxBool obscurePasswordVisibility = true.obs;

  RxBool isApiCallProcess = false.obs;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences logindata;
  late ServiceLogin? serlogin;
  late Map<String, dynamic> resultResponsee;
  LoginModel? loginModel;
  RxString tokens = "".obs;

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
    loginModel = await serlogin?.Login(usernameController.text, passwordController.text);
    logindata = await SharedPreferences.getInstance();
    await logindata.setString(
        "token", loginModel!.data!.userToken!.token! );
    await logindata.setString("userId", loginModel!.data!.id!);
    Get.snackbar(
      'خوش آمدید',
      '',
      icon: Icon(Icons.notifications, color: Colors.white),
      snackPosition: SnackPosition.TOP,
    );
    databox.check();

    /*
        .then((response) async {
      if (response != false) {
        logindata = await SharedPreferences.getInstance();
        // await logindata.setString(
        //     "token", response['data']['userToken']['token']);
        // await logindata.setString("userId", response['data']['id']);
      //  isApiCallProcess.value = true;
      //  tokens.value = loginModel!.data!.userToken!.token!;
        await logindata.setString(
            "token", loginModel!.data!.userToken!.token! );
        await logindata.setString("userId", loginModel!.data!.id!);
        Get.snackbar(
          'خوش آمدید',
          '',
          icon: Icon(Icons.notifications, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
        //  await Future.delayed(Duration(seconds: 2));
       databox.check();
      } else {
        isApiCallProcess.value = false;

        // serlogin!.showSnackBar(text: response['message']);
      }
    });*/
  }
}
