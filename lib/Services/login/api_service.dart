import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nahvino/Model/user/login/checkquestionanswer_request_model.dart';
import 'package:nahvino/Model/user/login/checkquestionanswer_response_model.dart';
import 'package:nahvino/Model/user/login/login_request_model.dart';
import 'package:nahvino/Model/user/login/login_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:nahvino/Model/user/login/register_request_model.dart';
import 'package:nahvino/Model/user/login/register_response_model.dart';
import 'package:nahvino/Model/user/otp/otp_response_code_model.dart';
import 'package:nahvino/Services/login/user/shared_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/user/login/resetpassword__request_model.dart';
import '../../Model/user/login/resetpassword_response_model.dart';
import '../../Model/user/otp/otp_request_code_model.dart';
import '../../Model/user/otp/otp_request_model.dart';
import '../../Model/user/otp/otp_response_model.dart';
import '../../Model/user/otp/resendcode_request_model.dart';
import '../../Model/user/otp/resendcode_response_model.dart';
import '../../Model/user/user/edit_profile_user_request_model.dart';
import '../../Model/user/user/edit_profile_user_response_model.dart';

class APIService {
  static var client = http.Client();

  /*login*/
  static Future login(
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

      var data = json.decode(response.body);
      return data['data'];
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
    debugPrint(response.body);
    if (response.statusCode == 200) {
      otpsendphoneResponseJson(
        response.body,
      );

      return true;
    } else {
      return false;
    }
  }
/*
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
*/

  /*otpvrifay*/
  static Future  otpvrifay(
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

    if (response.statusCode == 200) {
        otpResponseJson(
          response.body,
      );

      var data = json.decode(response.body);
      return data['data'];
    } else {
      return false;
    }
  }



  static Future<ResendCodeResponseModel> resendcode(
    ResendCodeRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse("https://api.nahvino.ir/api/v1/Account/ReSendCode");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return ResendCodeResponseJson(
      response.body,
    );
  }

  static Future checkquestionanswer(
    CheckQuestionAnswerRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url =
        Uri.parse("https://api.nahvino.ir/api/v1/Account/CheckQuestionAnswer");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    print(response.body);

    if (response.statusCode == 200) {
      checkquestionanswerresponseJson(
        response.body,
      );

      return json.decode(response.body);
    } else {
      return false;
    }
  }

  static Future<ResetpasswordResponseModel> repassword(
      ResetpasswordRequestModel model,
      ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse("https://api.nahvino.ir/api/v1/Account/ResetPassword");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return resetpasswordresponseJson(
      response.body,
    );
  }

  static Future  editprofileuser(
      EditProfileUserRequestModel model,
      ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization' : "Bearer ${ await preferences.getString("token")}"
    };
    var url =
    Uri.parse("https://api.nahvino.ir/api/v1/Account/EditProfileUser");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId" : await preferences.getString("userId")
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  static Future getprofileuser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization' : "Bearer ${ await preferences.getString("token")}"
    };
    var url =
    Uri.parse("https://api.nahvino.ir/api/v1/Account/GetProfileUser");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId" : await preferences.getString("userId")
      }),
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  static Future GetUserAbandon() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization' : "Bearer ${ await preferences.getString("token")}"
    };
    var url =
    Uri.parse("https://api.nahvino.ir/api/v1/Account/GetUserAbandon");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId" : await preferences.getString("userId")
      }),
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  static Future GetLastVisit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      //'Authorization' : "Bearer ${ await preferences.getString("token")}"
    };
    var url =
    Uri.parse("https://api.nahvino.ir/api/v1/Account/GetLastVisit");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId" : await preferences.getString("userId")
      }),
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

}
