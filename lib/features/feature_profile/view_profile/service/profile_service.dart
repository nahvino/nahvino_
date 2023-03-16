import 'dart:convert';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/core/shared/presentation/controllers/public/public_controller.dart';
import 'package:Nahvino/features/feature_profile/view_profile/config/profile_config.dart';
import 'package:Nahvino/features/feature_profile/view_profile/data/view_profial_data.dart';
import 'package:Nahvino/features/feature_profile/view_profile/model/Last_visit_model.dart';
import 'package:Nahvino/features/feature_profile/view_profile/model/Profile_user_model_response.dart';
import 'package:Nahvino/features/feature_profile/view_profile/model/get_user_abandon_model.dart';
import 'package:Nahvino/features/feature_auth/main/screen/registration.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
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

  static Future userprofile() async {
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
      print(json.decode(response.body));
      ProfileUserModelResponse profileUserModelResponse =
          ProfileUserModelResponse.fromJson(json.decode(response.body));
      return profileUserModelResponse;
    } else if (response.statusCode == 400) {
      print(json.decode(response.body));
      ProfileUserModelResponse profileUserModelResponse =
          ProfileUserModelResponse.fromJson(json.decode(response.body));
      return profileUserModelResponse;
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
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      GetUserAbandonModel getUserAbandonModel =
          GetUserAbandonModel.fromJson(jsonDecode(response.body));
      return getUserAbandonModel;
    } else {
      return false;
    }

    /*
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
    */
  }

  static Future GetLastVisit() async {
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
      LastVisitModel lastVisitModel =
          LastVisitModel.fromJson(json.decode(response.body));
      return lastVisitModel;
    } else if (response.statusCode == 401) {
      await preferences.clear();
      await DefaultCacheManager().emptyCache();
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

  ///flag
  static Future flag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + ProfileConfig.flag);
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
}
