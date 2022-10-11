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
  }
}
