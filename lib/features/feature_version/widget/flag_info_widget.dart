import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_version/controllers/flag_controller.dart';
import 'package:Nahvino/features/feature_version/widget/details_flag_widget.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FlagInfo extends StatelessWidget {
  FlagInfo({Key? key}) : super(key: key);
  FlagController flag_controller = Get.put(FlagController());

  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<FlagController>(
        builder: (logic) {
          return Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: (flag_controller.flagmodel != null) ?
            Container(
              child:
              InkWell(
                onTap: () =>  showModalBottomSheet(
                    isScrollControlled: true,
                    //backgroundColor: theme.backgroundColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    context: context,
                    builder: (context) => FlagDetailsWidget()),
                child: Row(
                  children: [
                    Subhead(text: flag_controller.flagmodel?.country!),
                    SizedBox(width: 2,),
                    Flag.fromString(
                        flag_controller.flagmodel!.countryCode!.toString(),
                        height: 30, width: 30),
                  ],
                ),
              ),
            ) : CircularProgressIndicator(),
          );
        },
      );
  }
}
