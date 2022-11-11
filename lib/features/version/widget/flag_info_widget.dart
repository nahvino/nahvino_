import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/version/controllers/flag_controller.dart';
import 'package:Nahvino/features/version/model/flagmodel.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlagInfo extends StatelessWidget {
  FlagInfo({Key? key}) : super(key: key);
  FlagController flag_controller = Get.put(FlagController());
  FlagModel? flag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Container(
        child: Row(
          children: [
            Caption2(text: flag_controller.fetch["region"].toString()),
            // Flag.fromString(flag_controller.fetch["countryCode"],
            //     height: 30, width: 30),
          ],
        ),
      ),
    );
  }
}
