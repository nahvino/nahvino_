import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/Login/ApiService.dart';

class EditProfileController extends GetxController {
  RxBool obscurePasswordVisibility = true.obs;
  RxBool isApiCallProcess = false.obs;
  late APIService apiService;
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameAliasController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController tarikhController = TextEditingController();

  validatoreditprofile() {
    GetUtils.isUsername(userNameController.text) ? print("صحبح نیست"):print("صحبح ");
    GetUtils.isLengthGreaterThan(userNameController.text, 6);
  }
}
