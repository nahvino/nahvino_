import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/features/my_tabs/main/screen/tabs.dart';
import 'package:Nahvino/features/profile/view_profile/service/profile_service.dart';
import 'package:Nahvino/features/registration/add_introduced/screen/add_introduced.dart';
import 'package:Nahvino/features/registration/otp/controllers/otp_phone_controller.dart';
import 'package:Nahvino/features/registration/otp/service/otp_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CodeOtpConrtoller extends GetxController{
  TextEditingController OtpCodeController = TextEditingController();
  OtpPhoneController otp_phone_controller = Get.put(OtpPhoneController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late OtpService otpService;
  late SharedPreferences logindata;

  var resultResponsepro;
  var parentName;
  @override
  void onInit() {
    super.onInit();
    otpService = OtpService();

  }

  start(BuildContext context){
    otpService.OtpCodePhone(otp_phone_controller.phone_text_controller.text,
        int.parse(OtpCodeController.text))
        .then((response) async {
      if (response != false) {
        logindata =
        await SharedPreferences.getInstance();
        await logindata.setString("token",
            response['data']['userToken']['token']);
        await logindata.setString(
            "userId", response['data']['id']);
        otpService.showSnackBar(
            text: AppLocalizations.of(context)!
                .translate(
              'Welcome',
            )!);

        ProfileService.profileuser().then((response) {
          print(
              "APIService.profilleall => $response");

            resultResponsepro = response;

          parentName = resultResponsepro['parentId'];
          if (parentName != null) {
            print("mogdar null => $parentName");

            Get.offAll(MyTabs());

          } else {
            print("mghdar por => $parentName");

            Get.offAll(AddIntroduced());

          }

        });

      } else {
        otpService.showSnackBar(
            text: response['message'] ?? "sdd");
      }
    });
  }
  resendStart(BuildContext context){
    otpService.ReSendCode(
      otp_phone_controller.phone_text_controller.text,
    ).then((response) async {

      if (response != false) {
        
        otpService.showSnackBar(
            text: AppLocalizations.of(context)!
                .translate(
              'Resendcode',
            )!);
      } else {

        otpService.showSnackBar(
            text: response['message']);
      }
    });
  }
}