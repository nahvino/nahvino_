import 'dart:convert';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/feature_settings/user_security/change_phone/config/change_phone_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePhoneService {
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



  //ChangePhoneNumber
  Future ChangePhoneNumber(
      String currentPhoneNumber, String newPhoneNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + ChangePhoneConfig.change_phone_number);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
        "currentPhoneNumber": currentPhoneNumber,
        "newPhoneNumber": newPhoneNumber
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future CheckCodeChangePhoneNumber(
      String currentPhoneNumber, String newPhoneNumber, int code) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(
        MainConfig.baseURL + ChangePhoneConfig.check_code_change_phone_number);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
        "currentPhoneNumber": currentPhoneNumber,
        "newPhoneNumber": newPhoneNumber,
        "code": code
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }
}
