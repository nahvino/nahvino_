import 'dart:convert';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/feature_auth/phone_number/config/otp_config.dart';
import 'package:Nahvino/features/feature_auth/phone_number/model/code_phone_number_model.dart';
import 'package:Nahvino/features/feature_auth/phone_number/model/phone_number_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpService {
  static var client = http.Client();


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
    if (response.statusCode == 200) {
      PhoneModel phoneModel =PhoneModel.fromJson(json.decode(response.body));
      return phoneModel;
    } else {
      return false;
    }
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
    if (response.statusCode == 200) {
      CodePhoneNumberModel codePhoneNumberModel =CodePhoneNumberModel.fromJson(json.decode(response.body));
      return codePhoneNumberModel;
    } else if (response.statusCode == 400){
      CodePhoneNumberModel codePhoneNumberModel =CodePhoneNumberModel.fromJson(json.decode(response.body));
      return codePhoneNumberModel;
    }
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
    if (response.statusCode == 200) {
      PhoneModel phoneModel =PhoneModel.fromJson(json.decode(response.body));
      return phoneModel;
    } else {
      return false;
    }
  }
  
}
