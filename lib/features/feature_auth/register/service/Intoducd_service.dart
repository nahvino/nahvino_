import 'dart:convert';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/feature_auth/register/config/registration_config.dart';
import 'package:Nahvino/features/feature_auth/register/model/Intoducd_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class IntoducdService {
  static var client = http.Client();

  static addIntroduced(int identifierCode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + RegistrationConfig.AddIntroduced);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
        "identifierCode": identifierCode
      }),
    );
    debugPrint(response.body.toString());
    IntoducdModel intoducdModel = IntoducdModel.fromJson(json.decode(response.body));
    if (response.statusCode == 200) {
      return intoducdModel;
    } else {
      return intoducdModel;
    }
  }

  static NotIntroduced() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + RegistrationConfig.NotIntroduced);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
      }),
    );
    IntoducdModel intoducdModel = IntoducdModel.fromJson(json.decode(response.body));
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return intoducdModel;
    }
    return intoducdModel;
  }
}
