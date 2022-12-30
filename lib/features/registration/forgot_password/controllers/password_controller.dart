import 'package:Nahvino/features/registration/forgot_password/model/CheckQuModel.dart';
import 'package:Nahvino/features/registration/forgot_password/service/reset_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WightPasswordController extends GetxController{

  bool isApiCallProcess = false;
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ResetService? resetservice;
  SharedPreferences? preferences;
  GetStorage box = GetStorage();
  RxString userId= "".obs;


  @override
  void onInit() {
    super.onInit();
    resetservice = ResetService();
    userId.value = box.read("data");
  }

  startService(BuildContext context)async{
    if (!formKey.currentState!.validate()) {} else {

      resetservice!
          .resetpassword(userId.value,
      passwordController.text)
          .then((response) async {
        if (response != false) {
          resetservice!.showSnackBar(
              text: response['message']);

          Navigator.pop(context, true);

        } else {
          isApiCallProcess = false;

          resetservice!.showSnackBar(
              text: response['message']);
        }
      });
      box.remove("data");
    }
  }
}