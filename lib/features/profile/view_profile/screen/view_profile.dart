import 'package:Nahvino/features/Chat/service/notification_service.dart';
import 'package:Nahvino/features/profile/view_profile/service/profile_service.dart';
import 'package:Nahvino/features/profile/view_profile/widget/phonix_profile.dart';
import 'package:Nahvino/features/profile/view_profile/widget/user_abandon_profile.dart';
import 'package:Nahvino/features/profile/view_profile/widget/user_account_profile.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../version/data/version_data.dart';
import '../widget/appbar_profile.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({Key? key, this.tabIndex}) : super(key: key);
  final int? tabIndex;

 
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50), child: AppBarProfile()),
          backgroundColor: Colors.white,
          body: SafeArea(
              child: body(context))


            /*  isApiCallProgress
                  ? Center(
                      child: Lottie.asset('assets/anim/loading/loading.json',
                          height: 300, width: 300),
                    )
                  : body(context))*/

    ),
    );
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
