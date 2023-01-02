import 'package:Nahvino/features/profile/view_profile/widget/phonix_profile.dart';
import 'package:Nahvino/features/profile/view_profile/widget/user_abandon_profile.dart';
import 'package:Nahvino/features/profile/view_profile/widget/user_account_profile.dart';
import 'package:flutter/material.dart';
import '../widget/appbar_profile.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({Key? key, this.tabIndex}) : super(key: key);
  final int? tabIndex;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50), child: AppBarProfile()),
          body: SafeArea(child: body(context))
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
