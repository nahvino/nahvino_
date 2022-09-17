import 'dart:convert';
import 'package:Nahvino/registration/otp/config/otp_config.dart';
import 'package:Nahvino/registration/register/config/registration_config.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpService {
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

 Future otpphone(String OtpPhoneController) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'accept': '*/*',
      'Access-Control_Allow_Origin': '*'
    };
    var url = Uri.parse(MainConfig.baseURL + OtpConfig.otpphone);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "phoneNumber": OtpPhoneController,
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    }
    return false;
  }

   Future OtpCodePhone(String OtpPhoneController, int OtpCodeController) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(MainConfig.baseURL + OtpConfig.otpvrifay);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
          {"phoneNumber": OtpPhoneController, "code": OtpCodeController}),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    }
    return false;
  }

  Future ReSendCode(String OtpPhoneController) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(MainConfig.baseURL + OtpConfig.resendcode);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "phoneNumber": OtpPhoneController,
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    }
    return false;
  }
  
}
