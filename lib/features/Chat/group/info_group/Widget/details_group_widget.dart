import 'package:Nahvino/features/Chat/group/Widget/public_group_widget.dart';
import 'package:Nahvino/features/Chat/group/info_group/controllers/info_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DetailsGroupWidget extends StatelessWidget {
  DetailsGroupWidget({Key? key}) : super(key: key);
  InfoGroupController info_group_controller = Get.put(InfoGroupController());

  @override
  Widget build(BuildContext context) {
    return   Container(
      color: Colors.white,
      child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: PublicGroupWidget().details_group(
                    context,
                    info_group_controller.rules.value,
                    info_group_controller.promise.value,
                    "علنی این کار را انجام دهند، ارائه می دهد."
                ),
              )
            ],
          )),
    );
  }
}
