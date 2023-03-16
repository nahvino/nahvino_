import 'dart:convert';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/feature_auth/login/config/login_config.dart';
import 'package:Nahvino/features/feature_auth/login/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ServiceLogin {
  static var client = http.Client();

  bool validateResponse(http.Response response) {
    LoginModel loginModel = LoginModel.fromJson(jsonDecode(response.body));
   // var data = json.decode(response.body);
    switch (int.parse(loginModel.data.toString())) {
      case 200:
        return true;
      case 401:
        {
          showSnackBar(text: loginModel.message ?? "Token not send or expired!");
          break;
        }
      case 400:
        {
          showSnackBar(text: loginModel.message ?? "Bad request!");
          break;
        }
      case 403:
        {
          showSnackBar(text: loginModel.message ?? "Access forbidden");
          break;
        }
      case 500:
        {
          showSnackBar(text: loginModel.message ?? "Server error");
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

  Future Login(String userNameController, String passwordController) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(MainConfig.baseURL + LoginConfig.login);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
          {"userName": userNameController, "password": passwordController}),
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      LoginModel loginModel = LoginModel.fromJson(jsonDecode(response.body));
      return loginModel;
    }else if (response.statusCode == 400) {
      LoginModel loginModel = LoginModel.fromJson(jsonDecode(response.body));
      return loginModel;
    }
  //  return false;

  }
}
