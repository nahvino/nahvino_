import 'dart:convert';
import 'package:Nahvino/Data/Local/view_profial_data.dart';
import 'package:Nahvino/Pages/Account/Login/registration.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/config/user/profile_config.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceProfile {
  static var client = http.Client();
  void showSnackBar({required String text}) {
    Get.snackbar(
      text,
      '',
      icon: Icon(Icons.notifications, color: Colors.white),
      snackPosition: SnackPosition.TOP,
    );
  }

  static Future profileuser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + ProfileConfig.getprofileuser);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": await preferences.getString("userId")}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future editprofileuser(
      String username, String nameAlias, String bio, String imageUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + ProfileConfig.editprofileuser);
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
    var url = Uri.parse(MainConfig.baseURL + ProfileConfig.EditUserAbandon);
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
      Uri.parse(MainConfig.baseURL + ProfileConfig.uploadProfileImage),
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
      print("==================> $response");
      return false;
    }
  }

  static Future getabandon() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + ProfileConfig.GetUserAbandon);
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
    // if (response.statusCode == 200) {
    //   return json.decode(response.body);
    // } else {
    //   return false;
    // }
  }

  static Future GetLastVisit() async {
    ViewProfileController databox = Get.put(ViewProfileController());

    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + ProfileConfig.GetLastVisit);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": await preferences.getString("userId")}),
    );
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      await preferences.clear();
      await DefaultCacheManager().emptyCache();
      databox.clerdata();
      final cacheDir = await getTemporaryDirectory();

      if (cacheDir.existsSync()) {
        cacheDir.deleteSync(recursive: true);
      }
      final appDir = await getApplicationDocumentsDirectory();

      if (appDir.existsSync()) {
        appDir.deleteSync(recursive: true);
      }

      Future.delayed(const Duration(milliseconds: 1000), () {
        Get.offAll(Registration());
      });
    } else {
      return false;
    }
  }
}
