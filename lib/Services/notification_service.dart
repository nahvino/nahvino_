import 'dart:convert';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/config/notification/notifi_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceNotification {
  static var client = http.Client();

  static Future notificationaApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + NotificationConfig.notification);
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

  static Future deletetokennotificationapi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(
        MainConfig.baseURL + NotificationConfig.delete_notification_token_api);
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
