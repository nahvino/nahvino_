import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_auth/register/model/Intoducd_model.dart';
import 'package:Nahvino/features/feature_auth/register/model/register_model.dart';
import 'package:Nahvino/features/feature_auth/register/service/Intoducd_service.dart';
import 'package:Nahvino/features/feature_my_tabs/main/screen/mytab.dart';
import 'package:Nahvino/features/feature_my_tabs/main/screen/tabs.dart';
import 'package:Nahvino/features/feature_profile/view_profile/data/view_profial_data.dart';
import 'package:Nahvino/features/feature_profile/view_profile/model/Profile_user_model_response.dart';
import 'package:Nahvino/features/feature_profile/view_profile/service/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/register_service.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ///first [Model]
  RegisterModel? registerModel;
  IntoducdModel? intoducdModel;
  ProfileUserModelResponse? profileUserModelResponse;

  /// end [service]
  RegisterService? serviceRegister;

  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController sqAnswerController = TextEditingController();
  TextEditingController identifierCodeController = TextEditingController();
  String? securityQuestionselected = null;
  RxnString? Questionselected = null;
  RxString Questionselectedv = "0".obs;
  late SharedPreferences logindata;
  RxBool chackBoxSelect = false.obs;
  RxBool chackvaule = false.obs;
  RxBool showTextReg = true.obs;
  RxBool showAddIntroduced = false.obs;
  RxBool showPandect = false.obs;
  RxBool showWelcomeUser = false.obs;
  RxBool checkNull = false.obs;
  RxString usernames = "".obs;

  @override
  void onInit() {
    super.onInit();
    serviceRegister = RegisterService();
    reRequset();
  }
  reRequset() async {
     profileUserModelResponse = await ProfileService.userprofile();
  }

  cleartext() {
    passwordController.clear();
    usernameController.clear();
    sqAnswerController.clear();
  }

  register_btn(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (this.chackvaule == false) {
        chackBoxSelect.value = true;
      } else {
        register(context);
        //    cleartext();
      }
    } else {
      if (this.chackvaule == false) {
        chackBoxSelect.value = true;
      } else {}
    }
  }

  register(BuildContext context) async {
    registerModel = await serviceRegister?.Register(
        usernameController.text,
        passwordController.text,
        Questionselectedv.value,
        sqAnswerController.text);
    logindata = await SharedPreferences.getInstance();

    if (registerModel!.statusCode == 200) {
      await logindata.setString(
          "token", registerModel!.data!.userToken!.token!);
      await logindata.setString("userId", registerModel!.data!.id!);
      profileUserModelResponse = await ProfileService.userprofile();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Caption1(
          color: Colors.white,
          textAlign: TextAlign.center,
          text: registerModel!.message!,
        ),
        backgroundColor: Colors.green,
      ));
      showTextReg.value = false;
      showAddIntroduced.value = true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Caption1(
          color: Colors.white,
          textAlign: TextAlign.center,
          text: registerModel!.message!,
        ),
        backgroundColor: Colors.red.shade700,
      ));
    }
  }

  /// [AddIntroduced] /// btn to [widget]
  addIntroduced(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      intoducdModel = await IntoducdService.addIntroduced(
          int.parse(identifierCodeController.text));
      if (intoducdModel!.statusCode == 200) {
        //request get profile user
        profileUserModelResponse = await ProfileService.userprofile();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Caption1(
            color: Colors.white,
            textAlign: TextAlign.center,
            text: intoducdModel!.message!,
          ),
          backgroundColor: Colors.green,
        ));
        showAddIntroduced.value = false;
        showPandect.value = true;
        update();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Caption1(
            color: Colors.white,
            textAlign: TextAlign.center,
            text: intoducdModel!.message!,
          ),
          backgroundColor: Colors.red.shade700,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Caption1(
          color: Colors.white,
          textAlign: TextAlign.center,
          text: "خطا",
        ),
        backgroundColor: Colors.red.shade700,
      ));
    }
    update();
  }

  addNotIntroduced(BuildContext context) async {
    intoducdModel = await IntoducdService.NotIntroduced();
    profileUserModelResponse = await ProfileService.userprofile();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Caption1(
        color: Colors.white,
        textAlign: TextAlign.center,
        text: intoducdModel!.message!,
      ),
      backgroundColor: Colors.green,
    ));
    showAddIntroduced.value = false;
    showWelcomeUser.value = true;
  }

  //pandect_widget
  RxBool value1 = false.obs;
  RxBool value2 = false.obs;

  pandect_btn(BuildContext context) {
    if (this.value1.value == false || this.value2.value == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Caption1(
          color: Colors.white,
          textAlign: TextAlign.center,
          text: "تیک قوانین را بزنید",
        ),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Caption1(
          color: Colors.white,
          textAlign: TextAlign.center,
          text: "خوش آمدید",
        ),
        backgroundColor: Colors.green,
      ));
      Get.offAll(() => MyTabs());
    }
  }

  //welcome
  welcome_btn() {
    showWelcomeUser.value = false;
    showPandect.value = true;
  }
}
