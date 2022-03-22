import 'dart:convert';
import 'package:nahvino/Model/user/login/login_request_model.dart';
import 'package:nahvino/Model/user/login/login_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:nahvino/Model/user/login/register_request_model.dart';
import 'package:nahvino/Model/user/login/register_response_model.dart';
import 'package:nahvino/Model/user/otp/otp_response_code_model.dart';
import 'package:nahvino/Services/login/user/shared_service.dart';

import '../../Model/user/otp/otp_request_code_model.dart';
import '../../Model/user/otp/otp_request_model.dart';
import '../../Model/user/otp/otp_response_model.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(
    LoginRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("https://api.nahvino.ir/api/v1/Account/SignIn");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
        loginResponseJson(
          response.body,
        ),
      );

      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
    RegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("https://api.nahvino.ir/api/v1/Account/SignUp");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJson(
      response.body,
    );
  }

  static Future<bool> otpphone(
    OtpRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse("https://api.nahvino.ir/api/v1/Account/PhoneNumber");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
        otpsendphoneResponseJson(
          response.body,
        
      );

      return true;
    } else {
      return false;
    }
  }




   static Future<OtpResponseModel> otpvrifay(
    OtpRequestCodeModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse("https://api.nahvino.ir/api/v1/Account/CheckCode");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return otpResponseJson(
      response.body,
    );
  }

  
}
