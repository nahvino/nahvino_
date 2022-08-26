import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupController extends GetxController {
  final ImagePicker picker = ImagePicker();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController rulscontroller = TextEditingController();
  TextEditingController gholghrarcontroller = TextEditingController();

  RxString imagePath = "".obs;
  @override
  void onInit() {
    super.onInit();
  }

  apply() {
    print(namecontroller);
    print(rulscontroller);
  }
}
