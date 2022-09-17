import 'dart:convert';
import 'package:Nahvino/Utils/Widget/dialog_error.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/version/config/version_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ServiceVersion {
  static var client = http.Client();

  static Future getversion() async {
    var url = Uri.parse(MainConfig.baseURL + VersionConfig.version);
    var response = await client.get(
      url,
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return ShowError(title: "خطا در دریافت ورژن",);
    }
  }
}
