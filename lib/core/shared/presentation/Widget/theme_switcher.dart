import 'package:Nahvino/core/shared/presentation/controllers/theme_get/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ThemeSwitcher extends StatelessWidget {
  ThemeSwitcher({Key? key}) : super(key: key);
  ThemeController theme_controller = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return  Row(
        children: [


          Switch(
              value: theme_controller.switch_theme.value,
              onChanged: (bool values) {

                  if (theme_controller.switch_theme.value = values) {
                    theme_controller.switch_theme.value = values;
                    theme_controller.saveSwitchState(values);
                  } else {
                    values = false;
                    theme_controller.saveSwitchState(values);
                  }
              }),
          Icon(
            theme_controller.switch_theme.value? Iconsax.sun : Iconsax.moon,
            color:theme_controller.switch_theme.value? Colors.cyan : Colors.black,
          ),
        ],
      );
    });
  }
}
