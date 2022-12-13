import 'dart:ui';

import 'package:Nahvino/config/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool switch_theme = false.obs;
  RxString theme = "".obs;
  GetStorage box_theme = GetStorage();
  String? selectedValue;
  var themes;

  @override
  void onInit() {
    super.onInit();
    getSwitchValues();
  }

  getSwitchValues() async {
    switch_theme.value = (await getSwitchState())!;
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);
    print('Switch Value saved $value');
    return prefs.setBool("switchState", value);
  }

  Future<bool?> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("switchState") == null) {
      switch_theme.value = false;
    }
    if (prefs.getBool("switchState") != null) {
      switch_theme.value = prefs.getBool("switchState")!;
    }
    print(switch_theme);

    return switch_theme.value;
  }
}
