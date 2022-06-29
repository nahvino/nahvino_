import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Nahvino/Services/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceProfile {
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

  /*AppLocalizations.of(_context)!.translate(
        'Pandect_snackbar_TiTle',
      )! */
  void showSnackBar({required String text}) {
    Get.snackbar(
      text,
      '',
      icon: Icon(Icons.notifications, color: Colors.white),
      snackPosition: SnackPosition.TOP,
    );
  }

  Future editprofileuser(String username, String nameAlias, String bio , String imageUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(Configss.baseURL + Configss.editprofileuser);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
        "userName": username,
        "nameAlias": nameAlias,
        "bio": bio,
        "imageUrl": imageUrl
      }),
    );
    if (validateResponse(response)) {
      print(response.body);
      return json.decode(response.body);
    } else {
      return false;
    }
  }
}
