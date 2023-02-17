import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_auth/phone_number/model/phone_number_model.dart';
import 'package:Nahvino/features/feature_auth/phone_number/screen/code_otp_phone.dart';
import 'package:Nahvino/features/feature_auth/phone_number/service/otp_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpPhoneController extends GetxController {
  TextEditingController phone_text_controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late OtpService otpService;
  PhoneModel? phoneModel;
  @override
  void onInit() {
    super.onInit();
    otpService = OtpService();
  }
  start(BuildContext context) async{
    if (!formKey.currentState!.validate()) {
    } else {
      phoneModel = await otpService.otpphone(phone_text_controller.text);
      if (phoneModel!.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Caption1(
            color: Colors.white,
            textAlign: TextAlign.center,
            text: phoneModel!.message!,
          ),
          backgroundColor: Colors.green,
        ));
        Get.to(() =>CodeOtpPhone());

      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Caption1(
            color: Colors.white,
            textAlign: TextAlign.center,
            text: phoneModel!.message!,
          ),
          backgroundColor: Colors.red.shade700,
        ));
      }

    }
  }
}
