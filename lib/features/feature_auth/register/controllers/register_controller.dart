import 'package:Nahvino/features/feature_auth/register/model/register_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/register_service.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late RegisterService? serregister;
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController sqAnswerController = TextEditingController();
  String? securityQuestionselected = null;
  RxnString? Questionselected  = null;
  RxString Questionselectedv = "0".obs;
  late SharedPreferences logindata;
  RxBool chackBoxSelect = false.obs;
  RxBool chackvaule = false.obs;
  RxBool showTextReg = true.obs;
  RxBool showAddIntroduced = false.obs;
  RegisterModel? registerModel;
  @override
  void onInit() {
    super.onInit();
    serregister = RegisterService();
  }

  cleartext() {
    passwordController.clear();
    usernameController.clear();
    sqAnswerController.clear();
  }


  register_btn(){
    if (
        formKey.currentState!
        .validate()) {

      if (this.chackvaule == false) {
        chackBoxSelect.value = true;
      }else{
        print("11111");
        register();
        cleartext();
      }
    } else {
      if (this.chackvaule == false) {
        chackBoxSelect.value = true;
      }else{


      }
    }

  }
  register() async {

    registerModel = await serregister?.Register(usernameController.text, passwordController.text,
        Questionselectedv.value, sqAnswerController.text);
    logindata = await SharedPreferences.getInstance();
    await logindata.setString(
        "token", registerModel!.data!.userToken!.token!);
    await logindata.setString("userId", registerModel!.data!.id!);
    Get.snackbar(
      "خوش امدید",
      '',
      icon: Icon(Icons.notifications, color: Colors.white),
      snackPosition: SnackPosition.TOP,
    );
    showTextReg.value = false;
    showAddIntroduced.value = true;

  }

  //pandect_widget
  RxBool value1 = false.obs;
  RxBool value2 = false.obs;
  pandect_btn(){
    if (this.value1.value == false || this.value2.value == false) {
      print("ok");
      // Get.snackbar(
      //   AppLocalizations.of(context)!.translate(
      //     'Pandect_snackbar_TiTle',
      //   )!,
      //   AppLocalizations.of(context)!.translate(
      //     'Pandect_snackbar',
      //   )!,
      //   icon: Icon(Icons.notifications, color: Colors.white),
      //   snackPosition: SnackPosition.TOP,
      // );
    } else {
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => MyTabs()));
    }
  }
}
