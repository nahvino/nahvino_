import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nahvino/Services/Login/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewLoginController extends GetxController{


  RxBool obscurePasswordVisibility = true.obs;

  RxBool isApiCallProcess = false.obs;


  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late APIService apiService;
  late SharedPreferences logindata;

  String? userToken;
  String? token;

  cleartext(){
    passwordController.clear();
    usernameController.clear();
  }
}