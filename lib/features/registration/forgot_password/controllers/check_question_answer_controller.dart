import 'package:Nahvino/features/registration/forgot_password/model/CheckQuModel.dart';
import 'package:Nahvino/features/registration/forgot_password/screen/password_screen.dart';
import 'package:Nahvino/features/registration/forgot_password/service/reset_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckQuestionAnswerController extends GetxController{

  bool isApiCallProcess = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController sqAnswerController = TextEditingController();
  RxString securityQuestionselected = "0".obs;
  late SharedPreferences logindata;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ResetService? resetservice;
  RxString userid = "".obs;
  CheckQuModel? checkQuModel;
  @override
  void onInit() {
    super.onInit();
    resetservice = ResetService();
  }

  start_servisce(BuildContext context){
    if (!formKey.currentState!.validate()) {
    } else {
      resetservice
          ?.checkquestionanswer(
          usernameController.text,
          securityQuestionselected.value,
          sqAnswerController.text)
          .then((response) async {

        if (response != false) {
          Navigator.pop(context, true);
          showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              context: context,
              builder: (context) => PasswordScreen());

          // resetservice?.showSnackBar(
          //     text: response['message']);
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) =>
          //           Password(data: response['data'])),
          //       (route) => false,
          // );
        } else {

       //   Navigator.pop(context, true);

        }
      });
    }
  }
}