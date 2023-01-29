import 'dart:convert';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/feature_auth/forgot_password/config/reset_config.dart';
import 'package:Nahvino/features/feature_auth/forgot_password/model/CheckQuModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResetService {
  GetStorage box = GetStorage();

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

  Future checkquestionanswer(
    String usernameController,
    String securityQuestionselected,
    String sqAnswerController,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(MainConfig.baseURL + ResetConfig.checkquestionanswer);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userName": usernameController,
        "securityQuestion": securityQuestionselected,
        "answer": sqAnswerController,
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      CheckQuModel resatmodel =
      CheckQuModel.fromJson(json.decode(response.body));
      box.write("data", resatmodel.data);
      print(box.read("data"));
      return resatmodel;
    }
    return false;
  }

  Future resetpassword( String userid,String passwordController) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(MainConfig.baseURL + ResetConfig.repassword);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
          {"id": userid, "newPassword": passwordController}),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }
}
