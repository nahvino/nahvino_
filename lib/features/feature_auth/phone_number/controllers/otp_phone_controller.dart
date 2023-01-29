import 'package:Nahvino/features/feature_auth/phone_number/screen/code_otp_phone.dart';
import 'package:Nahvino/features/feature_auth/phone_number/service/otp_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpPhoneController extends GetxController {
  TextEditingController phone_text_controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late OtpService otpService;

  @override
  void onInit() {
    super.onInit();
    otpService = OtpService();
  }
  start() {
    if (!formKey.currentState!.validate()) {
    } else {
      otpService.otpphone(phone_text_controller.text).then((response) async {
        if (response != false) {
          otpService.showSnackBar(text: response['message']);
          Get.to(CodeOtpPhone(
          ));
        } else {
          otpService.showSnackBar(text: response['message'] ?? "sdd");
        }
      });
    }
  }
}
