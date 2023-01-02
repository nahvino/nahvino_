import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeGroupController extends GetxController {
  final ImagePicker picker = ImagePicker();
  TextEditingController search_controller = TextEditingController();
  RxBool isInSearchMode = false.obs;
  RxBool InSearchMode = true.obs;
  RxString serchtext = "".obs;

  @override
  void onInit() {
    super.onInit();
  // SearchMode_false();

  }
  SearchMode_false(){
   if(search_controller.text == null || search_controller.text == "" && serchtext.value  == null &&serchtext.value  == "" ){
     Timer.periodic(Duration(seconds: 10), (timer) async {
       isInSearchMode.value = false;
     });
   }
  }
}
