import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nahvino/Model/user/otp/otp_response_code_model.dart';

class APIService {
  static var client = http.Client();

  static Future<OtpResponseModel> otpLogin(String phoneNumber) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    //var url = Uri.http(Config.apiURL, Config.otpLoginAPI);
    var url = Uri.parse("https://api.nahvino.ir/api/v1/Account/PhoneNumber");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"phoneNumber": phoneNumber}),
    );

    return otpResponseJson(response.body);
  }

  static Future<OtpResponseModel> verifyOtp(
    String? phoneNumber,
    String? code,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    //var url = Uri.http(Config.apiURL, Config.verifyOTPAPI);
    var url = Uri.parse("https://api.nahvino.ir/api/v1/Account/CheckCode");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"phoneNumber": phoneNumber, "code": code}),
    );

    return otpResponseJson(response.body);
  }
}
