import 'dart:convert';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/registration/register/config/registration_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterService {
  static var client = http.Client();
  bool validateResponse(http.Response response) {
    var data = json.decode(response.body);
    switch (data['statusCode']) {
      case 200:
        return true;
      case 401:
        {
          showSnackBar(text: data['message'] ?? "Token not send or expired!");
          break;
        }
      case 400:
        {
          showSnackBar(text: data['message'] ?? "Bad request!");
          break;
        }
      case 403:
        {
          showSnackBar(text: data['message'] ?? "Access forbidden");
          break;
        }
      case 500:
        {
          showSnackBar(text: data['message'] ?? "Server error");
          break;
        }
    }
    return false;
  }

  void showSnackBar({required String text}) {
    //ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text(text)));
    Get.snackbar(
      text,
      '',
      icon: Icon(Icons.notifications, color: Colors.white),
      snackPosition: SnackPosition.TOP,
    );
  }

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
      return json.decode(response.body);
    } else {
      return false;
    }
  }
}
