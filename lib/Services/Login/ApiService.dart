import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:Nahvino/Model/user/user/viewprofile_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';

class APIService {
  static var client = http.Client();

  BuildContext context;

  APIService(this.context);

  bool validateResponse(http.Response response) {
    var data = json.decode(response.body);
    switch (data['statusCode']) {
      case 200:
        return true;
      //  {
      //    showSnackBar(text: data['message'] ?? "Token not send or expired!");
      //     break;
      //  }

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
    //ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text(text)));
    Get.snackbar(
      text,
      '',
      icon: Icon(Icons.notifications, color: Colors.white),
      snackPosition: SnackPosition.TOP,
    );
  }

  Future editprofileuser(GetProfileUserResponseModel model) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.editprofileuser);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
        "userName": model.userName,
        "nameAlias": model.nameAlias,
        "bio": model.bio,
        "imageUrl": model.imageUrl
      }),
    );
    if (validateResponse(response)) {
      print(response.body);
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  static Future getprofileuser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.getprofileuser);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": await preferences.getString("userId")}),
    );
    var body = json.decode(response.body);
    debugPrint(body.toString());
    if (response.statusCode == 200) {
      return GetProfileUserResponseModel.fromJson(body);
    } else {
      return false;
    }
  }

  static Future getuserabandon() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.GetUserAbandon);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": await preferences.getString("userId")}),
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
    var url = Uri.parse(configss.baseURL + configss.GetLastVisit);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": await preferences.getString("userId")}),
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
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.UserSecuritySttingMenus);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": await preferences.getString("userId")}),
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  static Future profilleall() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.getprofileuser);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": await preferences.getString("userId")}),
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
    var url = Uri.parse(configss.baseURL + configss.AddIntroduced);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
        "identifierCode": identifierCode
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future ChangePasswrod(String currentPassword, String newPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.ChangePasswrod);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
        "currentPassword": currentPassword,
        "newPassword": newPassword
      }),
    );
    debugPrint(response.body.toString());
    // if (validateResponse(response)) {
    //   var data = json.decode(response.body);
    //   return data['data'];
    // }
    // return false;
    if (validateResponse(response)) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future NotIntroduced() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.NotIntroduced);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    }
    return false;
  }

  Future uploadProfileImage(String imagePath) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(configss.baseURL + configss.uploadProfileImage),
    );

    var multipartFile =
        await http.MultipartFile.fromPath('ImageFile', imagePath);
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
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.SetPhoneNumber);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
        "setPhoneNumber": setPhoneNumber,
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      /*var data = json.decode(response.body);
      return data['data'];*/
      return json.decode(response.body);
    }
    return false;
  }

  Future checkcodesetPhoneNumber(String setPhoneNumber, int code) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.CheckCodeSetPhoneNumber);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
        "setPhoneNumber": setPhoneNumber,
        "code": code
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future ChangePhoneNumber(
      String currentPhoneNumber, String newPhoneNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.ChangePhoneNumber);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
        "currentPhoneNumber": currentPhoneNumber,
        "newPhoneNumber": newPhoneNumber
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future CheckCodeChangePhoneNumber(
      String currentPhoneNumber, String newPhoneNumber, int code) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.CheckCodeChangePhoneNumber);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
        "currentPhoneNumber": currentPhoneNumber,
        "newPhoneNumber": newPhoneNumber,
        "code": code
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future OtpPhone(String OtpPhoneController) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'accept': '*/*',
      'Access-Control_Allow_Origin': '*'
    };
    var url = Uri.parse(configss.baseURL + configss.otpphone);
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
    var url = Uri.parse(configss.baseURL + configss.otpvrifay);
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

  Future NewRegister(
    String usernameController,
    String passwordController,
    String securityQuestionselected,
    String sqAnswerController,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(configss.baseURL + configss.register);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userName": usernameController,
        "password": passwordController,
        "securityQuestion": securityQuestionselected,
        "sqAnswer": sqAnswerController,
      }),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    }
    return false;
  }

  Future NewLogin(String userNameController, String passwordController) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(configss.baseURL + configss.login);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
          {"userName": userNameController, "password": passwordController}),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    }
    return false;
  }

  Future NewCheckQuestionAnswer(
    String usernameController,
    String securityQuestionselected,
    String sqAnswerController,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(configss.baseURL + configss.checkquestionanswer);
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
      return json.decode(response.body);
    }
    return false;
  }

  Future NewResetPassword(String data, String passwordController) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(configss.baseURL + configss.repassword);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
          {"id": data.toString(), "newPassword": passwordController}),
    );
    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future NewReSendCode(String OtpPhoneController) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(configss.baseURL + configss.resendcode);
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

  Future AddOrEditUserAbandon(String date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.EditUserAbandon);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
          {"userId": await preferences.getString("userId"), "dateTime": date}),
    );

    debugPrint(response.body.toString());
    if (validateResponse(response)) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  static Future GetProfileOtherUser(
    String GetProfileOtherUser,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.GetProfileOtherUser);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": GetProfileOtherUser}),
    );
    //  debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  static Future GetLastOtherVisit(
    String GetLastOtherVisit,
  ) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      //'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.GetLastOtherVisit);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": GetLastOtherVisit}),
    );
    //  debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  static Future getuserabandonViewProfileUesr(
    String getuserabandonViewProfileUesr,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.GetUserAbandon);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": getuserabandonViewProfileUesr}),
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  static Future notificationaApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      //'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.notification);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userId": await preferences.getString("userId"),
        "token": await preferences.getString("firebasetoken")
      }),
    );
    //  debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  static Future deletetokenapi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      //'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(configss.baseURL + configss.deletetokenapi);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": await preferences.getString("userId")}),
    );
    //  debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }
}
