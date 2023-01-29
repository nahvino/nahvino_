import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_chat/group/Widget/public_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
class NotificationGroupWidget extends StatelessWidget {
  const NotificationGroupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 30),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.notification,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8,),
                  Callout(
                    color: Colors.black,
                    textAlign: TextAlign.center,
                    text: AppLocalizations.of(context)!.translate(
                      'Notifications',
                    )!,
                  ),
                ],
              ),

              Row(
                children: [
                  Callout(
                    color: Colors.black,
                    textAlign: TextAlign.center,
                    text: "|",
                  ),
                  PublicGroupWidget().notification(),
                ],
              )
            ]),
      ),
    );
  }
}
