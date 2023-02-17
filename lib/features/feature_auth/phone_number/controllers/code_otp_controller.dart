import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_auth/phone_number/model/code_phone_number_model.dart';
import 'package:Nahvino/features/feature_auth/register/controllers/register_controller.dart';
import 'package:Nahvino/features/feature_auth/register/screen/register_screen.dart';
import 'package:Nahvino/features/feature_my_tabs/main/screen/tabs.dart';
import 'package:Nahvino/features/feature_profile/view_profile/model/Profile_user_model_response.dart';
import 'package:Nahvino/features/feature_profile/view_profile/service/profile_service.dart';
import 'package:Nahvino/features/feature_auth/add_introduced/screen/add_introduced.dart';
import 'package:Nahvino/features/feature_auth/phone_number/controllers/otp_phone_controller.dart';
import 'package:Nahvino/features/feature_auth/phone_number/service/otp_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CodeOtpConrtoller extends GetxController{
  TextEditingController OtpCodeController = TextEditingController();
  OtpPhoneController otp_phone_controller = Get.put(OtpPhoneController());
  RegisterController registerController = Get.put(RegisterController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late OtpService otpService;
  late SharedPreferences logindata;
  CodePhoneNumberModel? codePhoneNumberModel;
  ProfileUserModelResponse? profileUserModelResponse;

  var resultResponsepro;
  var parentName;
  @override
  void onInit() {
    super.onInit();
    otpService = OtpService();

  }

  start(BuildContext context)async{
    codePhoneNumberModel= await  otpService.OtpCodePhone(otp_phone_controller.phone_text_controller.text,
        int.parse(OtpCodeController.text));
    logindata = await SharedPreferences.getInstance();
    if (codePhoneNumberModel!.statusCode == 200) {
      await logindata.setString(
          "token", codePhoneNumberModel!.data!.userToken!.token!);
      await logindata.setString("userId", codePhoneNumberModel!.data!.id!);
      profileUserModelResponse = await ProfileService.userprofile();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Caption1(
          color: Colors.white,
          textAlign: TextAlign.center,
          text: codePhoneNumberModel!.message!,
        ),
        backgroundColor: Colors.green,
      ));
      if (profileUserModelResponse?.parentName != null){
        Get.offAll(()=>MyTabs());

      }else{
        Get.offAll(()=>RegisterScreen());
        registerController.showTextReg.value = false;
        registerController.showAddIntroduced.value = true;
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Caption1(
          color: Colors.white,
          textAlign: TextAlign.center,
          text: codePhoneNumberModel!.message!,
        ),
        backgroundColor: Colors.red.shade700,
      ));
    }
  }
  resendStart(BuildContext context){
    otpService.ReSendCode(
      otp_phone_controller.phone_text_controller.text,
    );
  }
}