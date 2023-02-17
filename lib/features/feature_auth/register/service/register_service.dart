import 'dart:convert';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/feature_auth/register/config/registration_config.dart';
import 'package:Nahvino/features/feature_auth/register/model/register_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterService {
  static var client = http.Client();


  Future Register(
    String usernameController,
    String passwordController,
    String? securityQuestionselected,
    String sqAnswerController,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(MainConfig.baseURL + RegistrationConfig.register);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userName": usernameController,
        "password": passwordController,
        "securityQuestion": securityQuestionselected,
        "sqAnswer": sqAnswerController,
      }),
    );
    if (response.statusCode == 200) {
      RegisterModel registerModel = RegisterModel.fromJson(json.decode(response.body));
      print(registerModel.data!.userToken!.token!);
      return registerModel;
    } else {
      return false;
    }
  }
}
