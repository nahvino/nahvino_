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
import 'package:nahvino/Model/user/user/viewprofile_response_model.dart';
import 'package:nahvino/Services/login/user/config.dart';
import 'package:nahvino/Services/login/user/shared_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/user/login/resetpassword__request_model.dart';
import '../../Model/user/login/resetpassword_response_model.dart';
import '../../Model/user/otp/otp_request_code_model.dart';
import '../../Model/user/otp/otp_request_model.dart';
import '../../Model/user/otp/otp_response_model.dart';
import '../../Model/user/otp/resendcode_request_model.dart';
import '../../Model/user/otp/resendcode_response_model.dart';

class APIService {
  static var client = http.Client();

  BuildContext _context;
  APIService(this._context);

  bool validateResponse(http.Response response){

    var data = json.decode(response.body);
    switch(data['statusCode']){
      case 200:
        return true;
      case 401:{
        showSnackBar(text: data['message'] ?? "Token not send or expired!");
        break;
      }
      case 400:{
        showSnackBar(text: data['message'] ?? "Bad request!");
        break;
      }
      case 403:{
        showSnackBar(text: data['message'] ?? "Access forbidden");
        break;
      }
      case 500:{
        showSnackBar(text: data['message'] ?? "Server error");
        break;
      }
    }
    return false;
  }

  void showSnackBar({required String text}){
    ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text(text)));

  }

  /*login*/
  static Future login(
    LoginRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url =  Config.apiURL + login();
    //Uri.parse("https://api.nahvino.ir/api/v1/Account/SignIn");

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

/*
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
*/
  /////////

  static Future register(
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

    if (response.statusCode == 200) {
        registerResponseJson(
          response.body,
      );
  print(response);
      var data = json.decode(response.body);
      return data['data'];
    } else {
      return false;
    }
  }
  ////////
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
  /////////
  static Future otpvrifay(
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
  ////////
  /*
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
  }*/



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

  Future editprofileuser(GetProfileUserResponseModel model) async {
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
        "userId" : await preferences.getString("userId"),
        "userName": model.userName,
        "nameAlias": model.nameAlias,
        "bio": model.bio,
        "imageUrl" : model.imageUrl
      }),
    );
    if(validateResponse(response)){
      return json.decode(response.body);
    }else{
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
    var body = json.decode(response.body);
    debugPrint(body.toString());
    if (response.statusCode == 200) {
      return GetProfileUserResponseModel.fromJson(body);
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

  static Future UserSecuritySttingMenus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization' : "Bearer ${ await preferences.getString("token")}"
    };
    var url =
    Uri.parse("https://api.nahvino.ir/api/v1/Account/UserSecuritySttingMenus");
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

  Future AddIntroduced(String identifierCode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url =
    Uri.parse("https://api.nahvino.ir/api/v1/Account/AddIntroduced");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId" : await preferences.getString("userId"),
        "identifierCode" : identifierCode
      }),
    );
    debugPrint(response.body.toString());
    if(validateResponse(response)){

       return true;
    }

    return false;
  }

  Future ChangePasswrod(String currentPassword ,String newPassword ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization' : "Bearer ${ await preferences.getString("token")}"
    };
    var url =
    Uri.parse("https://api.nahvino.ir/api/v1/Account/ChangePasswrod");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId" : await preferences.getString("userId"),
        "currentPassword" : currentPassword,
        "newPassword" : newPassword
      }),
    );
    debugPrint(response.body.toString());
    if(validateResponse(response)){

      var data = json.decode(response.body);
      return data['data'];
    }

    return false;
  }

  Future NotIntroduced() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url =
    Uri.parse("https://api.nahvino.ir/api/v1/Account/NotIntroduced");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId" : await preferences.getString("userId")
      }),
    );
    debugPrint(response.body.toString());

    if(validateResponse(response)){
      /*var data = json.decode(response.body);
      return data['data'];*/
    }
    return false;
  }

  Future uploadProfileImage(String imagePath) async {

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("https://api.nahvino.ir/api/v1/Account/UploadProfileUser"),
    );

    var multipartFile = await http.MultipartFile.fromPath(
        'ImageFile', imagePath);
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    if (response.statusCode == 200) {
      return respStr;
    } else {
      // error
      return false;
    }

  }

  Future SetPhoneNumber(String setPhoneNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization' : "Bearer ${ await preferences.getString("token")}"
    };
    var url =
    Uri.parse("https://api.nahvino.ir/api/v1/Account/SetPhoneNumber");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId" : await preferences.getString("userId"),
        "setPhoneNumber" : setPhoneNumber
      }),
    );
    debugPrint(response.body.toString());
    if(validateResponse(response)){

      /*var data = json.decode(response.body);
      return data['data'];*/
    }
    return false;
      }
/*
  Future CheckCodeSetPhoneNumber(String setPhoneNumber ,int code) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url =
    Uri.parse("https://api.nahvino.ir/api/v1/Account/CheckCodeSetPhoneNumber");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId" : await preferences.getString("userId"),
        "setPhoneNumber" : setPhoneNumber
        "code" : code
      }),
    );
    debugPrint(response.body.toString());
    if(validateResponse(response)){

      var data = json.decode(response.body);
      return data['data'];
    }
    return false;

  }
*/
}
