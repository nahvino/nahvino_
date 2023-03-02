import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/controllers/view_profile_user_controller.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/widget/other_user_abandon_profile.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/widget/other_user_account_profile_widget.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/widget/other_user_phonix_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ViewProfileUserScreen extends StatelessWidget {
  ViewProfileUserScreen({Key? key}) : super(key: key);
  ViewProfileUserController vpu_Controller =
      Get.put(ViewProfileUserController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewProfileUserController>(builder: (logic) {
      return (vpu_Controller.otherLastVisitModel != null)
          ? Scaffold(
              appBar: AppBar(
                  elevation: 1,
                  title: Callout(
                    text: "پروفایل ارشد",
                    textAlign: TextAlign.start,
                  )),
              body: SafeArea(
                  child: Column(
                children: [
                  UserOtherAccountProfileWidget(),
                  OtherUserPhonixProfile(),
                  OtherUserAbandonProfile()
                ],
              )),
            )
          : Container(
              color: Colors.grey.shade100,
              child: Center(
                child: Lottie.asset('assets/anim/loading/loading.json',
                    height: 300, width: 300),
              ),
            );
    });
  }
}
