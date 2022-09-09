import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditGroupController extends GetxController {
  final ImagePicker picker = ImagePicker();
  TextEditingController rulscontroller = TextEditingController();
  TextEditingController gholghrarcontroller = TextEditingController();
  RxString serchtext = "".obs;
  RxBool serach_mood = false.obs;
  RxString imagePath = "".obs;
  @override
  void onInit() {
    super.onInit();

    rulscontroller = TextEditingController(text: "asd");
  }

  apply() {
    print(rulscontroller);
  }
}
