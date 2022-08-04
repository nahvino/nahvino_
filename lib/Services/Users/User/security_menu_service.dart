import 'dart:convert';
import 'package:Nahvino/config/user/menu_config.dart';
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
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  

}
