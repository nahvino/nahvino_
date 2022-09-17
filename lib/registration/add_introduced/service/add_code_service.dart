import 'dart:convert';
import 'package:Nahvino/registration/add_introduced/config/add_code_config.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddCodeService {
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
    Get.snackbar(
      text,
      '',
      icon: Icon(Icons.notifications, color: Colors.white),
      snackPosition: SnackPosition.TOP,
    );
  }

  Future addIntroduced(int identifierCode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + AddCodeConfig.AddIntroduced);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
        "identifierCode": identifierCode
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future NotIntroduced() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + AddCodeConfig.NotIntroduced);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    }
    return false;
  }
}
