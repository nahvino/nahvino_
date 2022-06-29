import 'package:Nahvino/controllers/getx/user/viewprofial_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/Login/ApiService.dart';
import '../../../Utils/Validator/validator.dart';

class EditProfileController extends GetxController {
  //import
  Validator vlid = Get.put(Validator());
  ViewProfileController databox = Get.put(ViewProfileController());
  //Variable
  RxBool isApiCallProcess = false.obs;
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameAliasController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController tarikhController = TextEditingController();
  String? error;

  // controller

  @override
  void onInit() {
    super.onInit();
    userNameController = TextEditingController(text: databox.username.value);
    nameAliasController = TextEditingController(text: databox.namealias.value);
    bioController = TextEditingController(text: databox.bio.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  validatoreditprofile() {
    GetUtils.isUsername(userNameController.text)
        ? print("صحبح نیست")
        : print("صحبح ");
    GetUtils.isLengthGreaterThan(userNameController.text, 6);
  }

  upimg() {}
}
