import 'package:Nahvino/core/shared/presentation/controllers/theme_get/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSwitcher extends StatelessWidget {
  ThemeSwitcher({Key? key}) : super(key: key);
  ThemeController theme_controller = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FloatingActionButton(
        onPressed: () => theme_controller.change_theme(),
        child: theme_controller.switch_theme.value
            ? Icon(
                Icons.mode_night,
                color: Colors.white,
              )
            : Icon(Icons.sunny, color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      );
    });
  }
}
