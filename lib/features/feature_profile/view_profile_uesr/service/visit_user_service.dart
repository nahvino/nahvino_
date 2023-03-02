import 'dart:convert';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/config/visit_user_config.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/model/Other_user_get_abandon_model.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/model/User_profile_model.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/model/other_last_visit_model.dart';
import 'package:http/http.dart' as http;

import 'package:Nahvino/config/main_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisetUserService {
  static var client = http.Client();

  static Future getprofileotheruser(
    String id,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url =
        Uri.parse(MainConfig.baseURL + VisitUserConfig.GetProfileOtherUser);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": id}),
    );
    if (response.statusCode == 200) {
      UserProfileModel userProfileModel =
          UserProfileModel.fromJson(json.decode(response.body));
      return userProfileModel;
    } else {
      return false;
    }
  }

  static Future GetLastOtherVisit(
    String GetLastOtherVisit,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + VisitUserConfig.GetLastOtherVisit);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": GetLastOtherVisit}),
    );
    //  debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      OtherLastVisitModel otherLastVisitModel = OtherLastVisitModel.fromJson(json.decode(response.body));
      return otherLastVisitModel;
    } else {
      return false;
    }
  }

  static Future getuserotherabandon(
    String getuserabandonViewProfileUesr,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url =
        Uri.parse(MainConfig.baseURL + VisitUserConfig.GetUserOtherAbandon);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": getuserabandonViewProfileUesr}),
    );
    if (response.statusCode == 200) {
      OtherUserGetAbandonModel otherUserGetAbandonModel = OtherUserGetAbandonModel.fromJson(json.decode(response.body));
      return otherUserGetAbandonModel;
    } else {
      return false;
    }
  }

  ///flag
  static Future flag(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + VisitUserConfig.flag);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": id}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }
}
