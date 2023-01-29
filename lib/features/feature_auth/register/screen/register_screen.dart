import 'package:Nahvino/config/generated/assets.dart';
import 'package:Nahvino/features/feature_auth/register/controllers/register_controller.dart';
import 'package:Nahvino/features/feature_auth/register/service/register_service.dart';
import 'package:Nahvino/features/feature_auth/register/widget/add_introduced_widget.dart';
import 'package:Nahvino/features/feature_auth/register/widget/pandect_widget.dart';
import 'package:Nahvino/features/feature_auth/register/widget/register_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({
    Key? key,
  }) : super(key: key);

  RegisterController registerController = Get.put(RegisterController());

  late RegisterService seregister;
  bool obscurePasswordVisibility = true;
  late SharedPreferences logindata;
  bool value2 = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(() {
        return Container(
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.reg_background), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Form(
              key: registerController.formKey,
              child: CustomScrollView(
                reverse: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(45))),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        child: Column(
                          children: [
                            Visibility(
                              visible: registerController.showTextReg.value,
                              child: RegisterWidget(),
                            ),
                            // Visibility(
                            //   visible:
                            //       registerController.showAddIntroduced.value,
                            //   child: AddIntroducedWidget(),
                            // ),
                            Visibility(
                              visible:
                                  registerController.showAddIntroduced.value,
                              child: PandectWidget(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
