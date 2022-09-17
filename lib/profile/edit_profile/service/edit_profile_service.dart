import 'dart:convert';
import 'package:Nahvino/profile/edit_profile/config/edit_profile_config.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileService {
  static var client = http.Client();
  void showSnackBar({required String text}) {
    Get.snackbar(
      text,
      '',
      icon: Icon(Icons.notifications, color: Colors.white),
      snackPosition: SnackPosition.TOP,
    );
  }



  Future editprofileuser(
      String username, String nameAlias, String bio, String imageUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + EditProfileConfig.editprofileuser);
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
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future AddOrEditUserAbandon(String date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + EditProfileConfig.EditUserAbandon);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
          {"userId": await preferences.getString("userId"), "dateTime": date}),
    );

    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future uploadProfileImage(String imagePath) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(MainConfig.baseURL + EditProfileConfig.uploadProfileImage),
    );
    var multipartFile =
        await http.MultipartFile.fromPath('ImageFile', imagePath);
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    if (response.statusCode == 200) {
      print(response);
      return respStr;
    } else {
      return false;
    }
  }



}
