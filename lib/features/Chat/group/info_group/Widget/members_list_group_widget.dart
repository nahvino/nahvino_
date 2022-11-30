import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/Chat/group/info_group/controllers/info_group_controller.dart';
import 'package:Nahvino/features/Chat/group/info_group/controllers/members_controller.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembersList extends StatelessWidget {
  MembersList({Key? key}) : super(key: key);
  InfoGroupController info_group_controller = Get.put(InfoGroupController());
  MembersListController membersListController =
      Get.put(MembersListController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: membersListController.members.length,
        shrinkWrap: true,
        itemBuilder: member_item,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget member_item(context, index) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 50, width: 50, child: Imageview().image_assets()),
                  SizedBox(
                    width: 5,
                  ),
                  Body(
                      color: Colors.black,
                      text: membersListController.memmodel?.data![index].userame.toString()
                      //membersListController.members[index].data?[index].userame
                  ),
                ],
              ),
              Icon(Icons.stars)
            ],
          ),
        ),
        Container(
          decoration: DottedDecoration(),
        )
      ],
    );
  }
}
