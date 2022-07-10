import 'dart:convert';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/config/version_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';



class ServiceVersion {
  static var client = http.Client();

  static Future getversion(String getversion) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(MainConfig.baseURL + VersionConfig.version);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"version": getversion}),
    );

    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }
}
