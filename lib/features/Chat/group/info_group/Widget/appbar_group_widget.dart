import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/Chat/group/info_group/controllers/info_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarInfo extends StatelessWidget {
  // AppBarInfo({Key? key}) : super(key: key);
  InfoGroupController info_group_controller = Get.put(InfoGroupController());


  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
          background:(info_group_controller.imageUrl.value != "null"   ?
          Image.network(
            MainConfig.fileurl + info_group_controller.imageUrl.value,
            fit: BoxFit.fitWidth,
          ):
          Image.network(
            "https://flutterfix.com/wp-content/uploads/2020/07/FLUTTER-TABBAR.png",
            fit: BoxFit.fitWidth,
          )

          )),
      backgroundColor: Colors.cyan.shade800,
      stretch: true,
      actions: [
        SizedBox(
          width: 10,
        ),
      ],
      title: Title2(
          color: Colors.white,
          text: info_group_controller.name.value.length > 17
              ? '${info_group_controller.name.value.substring(0, 17)}...'
              : info_group_controller.name.value),
      leadingWidth: 60,
      pinned: true,
      floating: true,
    );
  }
}
