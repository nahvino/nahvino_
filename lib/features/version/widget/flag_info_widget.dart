import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/version/controllers/flag_controller.dart';
import 'package:Nahvino/features/version/model/flagmodel.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FlagInfo extends StatelessWidget {
  FlagInfo({Key? key}) : super(key: key);
  FlagController flag_controller = Get.put(FlagController());
  FlagModel? flag;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Container(
        child: Obx(() {
          return Row(
            children: [
              Subhead(text: flag_controller.country.value),
              SizedBox(width: 2,),
              Flag.fromString(flag_controller.countryCode.value,
                  height: 30, width: 30),
            ],
          );
        }),
      ),
    );
  }
}
