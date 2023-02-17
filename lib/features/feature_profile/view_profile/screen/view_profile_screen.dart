import 'package:Nahvino/features/feature_profile/view_profile/controllers/profile_controller.dart';
import 'package:Nahvino/features/feature_profile/view_profile/widget/phonix_profile.dart';
import 'package:Nahvino/features/feature_profile/view_profile/widget/user_abandon_profile.dart';
import 'package:Nahvino/features/feature_profile/view_profile/widget/user_account_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../widget/appbar_profile.dart';

class ViewProfile extends StatelessWidget {
  ViewProfile({Key? key, this.tabIndex}) : super(key: key);
  final int? tabIndex;
  ProfileController profile_Controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GetBuilder<ProfileController>(builder: (logic) {
      return (profile_Controller.profileUserModelResponse == null)
          ? Center(
              child: Lottie.asset('assets/anim/loading/loading.json',
                  height: 300, width: 300),
            )
          : Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                  backgroundColor: theme.backgroundColor,
                  appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: AppBarProfile()),
                  body: SafeArea(child: body(context))));
    });
  }

  Widget body(BuildContext context) {
    return Column(
      children: [
        UserAcconutProfile(),
        PhonixProfile(),
        UserAbandonProfile(),
      ],
    );
  }
}
