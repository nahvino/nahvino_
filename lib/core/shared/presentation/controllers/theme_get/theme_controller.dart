import 'dart:ui';

import 'package:Nahvino/config/custom_theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  RxBool switch_theme = false.obs;
  GetStorage box_theme = GetStorage();
  String? selectedValue;
  @override
  void onInit() {
    super.onInit();
    check_theme();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  // void onSelected(String value) {
  //   selectedValue = value;
  //   update();
  //   change_theme(selectedValue);
  // }
  // change_theme(String? selectedLanguage) {
  //   switch (selectedLanguage) {
  //     case 'Dark':
  //       box_theme.write("theme", CustomTheme.darkTheme);
  //       break;
  //     case 'Light':
  //       box_theme.write("theme", CustomTheme.lightTheme);
  //       break;
  //     default:
  //       box_theme.write("theme", CustomTheme.lightTheme);
  //       break;
  //   }
  // }
  change_theme() {
    if (switch_theme.value == false) {
      box_theme.write("theme", CustomTheme.lightTheme);
      switch_theme.value = true;
      print('light');
    } else {
      box_theme.write("theme", CustomTheme.darkTheme);
      switch_theme.value = false;
      print('dark');
    }
    update();
  }

  check_theme() {
    if (box_theme.read("theme") == null) {
      box_theme.write("theme", CustomTheme.lightTheme);
    } else {
      box_theme.read("theme");
    }
    update();
  }
}
