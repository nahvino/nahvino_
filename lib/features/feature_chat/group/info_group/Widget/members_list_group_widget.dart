import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/feature_chat/group/info_group/controllers/info_group_controller.dart';
import 'package:Nahvino/features/feature_chat/group/info_group/controllers/members_controller.dart';
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
      child: (membersListController.members != null)
          ? ListView.builder(
        itemCount:
        membersListController.members!.length,
        shrinkWrap: true,
        itemBuilder: member_item,
        physics: NeverScrollableScrollPhysics(),
      )
          : Container(),
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
                  (membersListController.members?[index].imageUrl ==null)?
                  SizedBox(
                      height: 50, width: 50, child: Imageview().image_assets()):
                  SizedBox(
                      height: 50, width: 50, child: Imageview().image(membersListController.members?[index].imageUrl)),
                  SizedBox(
                    width: 5,
                  ),
                  Body(
                      color: Colors.black,
                      text: membersListController.members?[index].userame
                      //membersListController.members[index].data?[index].userame
                  ),
                ],
              ),
              Visibility(
                  visible: membersListController.members![index].isAdmin!,
                  child: Icon(Icons.stars))
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
