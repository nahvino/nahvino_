import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MenuController extends GetxController{
  var switch_lang = false;
  String? selectedValue;
  GetStorage box_menu = GetStorage();
  var local;
  @override
  void onInit() {
    super.onInit();
    //switchState();
  //  chaklang();
  }
  @override
  void onClose() {
    super.onClose();
  }
  @override
  void onReady() {
    super.onReady();
  }
  void onSelected(String value) {
    selectedValue = value;
   // print(value);
    update();
    changeLanguage(selectedValue);
  }
  changeLanguage(String? selectedLanguage) {
    switch (selectedLanguage) {
      case 'English':
        var locale = Locale('en', 'US');
        Get.updateLocale(locale);

        break;
      case 'Persian':
        var locale =  Locale('fa', 'IR');
        Get.updateLocale(locale);

        break;
      default: Get.updateLocale(Locale('fa', 'IR'));
        print('Fallback to En');
        break;
    }
  }
  chaklang(){
    if (box_menu.read("lang") != null){
      box_menu.read("lang");
      print(box_menu.read("lang"));
    }else{
      box_menu.write("lang", Locale('fa', 'IR'));
      print(box_menu.read("lang"));
    }
  }

}