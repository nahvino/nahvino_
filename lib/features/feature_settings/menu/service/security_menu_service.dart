import 'dart:convert';
import 'package:Nahvino/features/feature_settings/menu/config/menu_config.dart';
import 'package:Nahvino/features/feature_settings/menu/model/User_securtiy_menu_model.dart';
import 'package:http/http.dart' as http;

import 'package:Nahvino/config/main_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuService {
  static var client = http.Client();

  static Future UserSecuritySttingMenus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url =
        Uri.parse(MainConfig.baseURL + MenuConfig.UserSecuritySttingMenus);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"userId": await preferences.getString("userId")}),
    );
    print("----------------->${json.decode(response.body)}");
    if (response.statusCode == 200) {
      UserSecurtiyMenuModel userSecurtiyMenuModel = UserSecurtiyMenuModel.fromJson( json.decode(response.body));
      return userSecurtiyMenuModel;
    } else {
      return false;
    }
  }

  

}
