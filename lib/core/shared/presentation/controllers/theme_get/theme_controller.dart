import 'dart:ui';

import 'package:Nahvino/config/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  RxBool switch_theme = false.obs;
  RxString theme = "".obs;
  GetStorage box_theme = GetStorage();
  String? selectedValue;
  @override
  void onInit() {
    super.onInit();
    check_theme();
    print(box_theme.read('theme'));

  }

  check_theme() {
    if (box_theme.read("theme") == null) {
      box_theme.write("theme", CustomTheme.lightTheme);
    } else {
      box_theme.read("theme");
    }
    update();
  }
  change_theme() {
   // Get.changeThemeMode(switch_theme.value ? ThemeMode.light : ThemeMode.dark);
    if (switch_theme.value == false) {
    //  box_theme.write("theme", CustomTheme.lightTheme);
      box_theme.writeInMemory("theme", CustomTheme.lightTheme);
      switch_theme.value = true;
      print('light');
    } else {
    //  box_theme.write("theme", CustomTheme.darkTheme);
      box_theme.writeInMemory("theme", CustomTheme.darkTheme);

      box_theme.write("value", true);
      switch_theme.value = false;
      print('dark');
    }
    update();
  }


}
