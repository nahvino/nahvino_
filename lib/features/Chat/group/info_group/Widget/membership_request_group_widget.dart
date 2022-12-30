import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/Chat/group/info_group/controllers/members_controller.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembershipRequestList extends StatelessWidget {
  MembershipRequestList({Key? key}) : super(key: key);
  MembersListController membersListController =
      Get.put(MembersListController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: (membersListController.members != null)
          ? ListView.builder(
              itemCount: membersListController.requestmembresmodel!.length,
              shrinkWrap: true,
              itemBuilder: requestList_item,
              physics: NeverScrollableScrollPhysics(),
            )
          : Container(),
    );

    /*
      SingleChildScrollView(
      child: ListView.builder(
        itemCount: 30,
        shrinkWrap: true,
        itemBuilder: requestList_item,
        physics: NeverScrollableScrollPhysics(),
      ),
    );*/
  }

  Widget requestList_item(context, index) {
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
                    text: membersListController
                        .requestmembresmodel?[index].userName!,
                  )
                ],
              ),
/*
              SizedBox(
                width: 175,
                height: 35,
                child: Visibility(
                  visible: membersListController.requestmembresmodel?[index].isAccsept!,
                  child: Buttonfull(
                    text:AppLocalizations.of(context)!.translate(
                      'Accept_request',
                    )!,
                    onPressed: () => "",
                    color: Colors.white,
                  ),
                ),
              )*/
              if (membersListController
                      .requestmembresmodel?[index].isAccsept! ==
                  0)
                // Body(
                //   color: Colors.black,
                //   text: "بدون وضعیت",
                // ),
                //TODO ReActionRequestJoin
                Row(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 35,
                      child: Buttonfull(
                        text:"تایید",
                        onPressed: () => membersListController.reJoin("1"),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4,),
                    SizedBox(
                      width: 75,
                      height: 35,
                      child: Buttonfull(
                        text:"رد",
                        onPressed: () => membersListController.notreJoin(),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              if (membersListController
                      .requestmembresmodel?[index].isAccsept! ==
                  1)
                Body(
                  color: Colors.black,
                  text: "رد شده",
                ),
              if (membersListController
                      .requestmembresmodel?[index].isAccsept! ==
                  2)
                Body(
                  color: Colors.black,
                  text: "تایید شده",
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10, left: 20),
          child: Row(
            children: [
              Body(
                color: Colors.black,
                text: "تاریخ درخواست : ",
              ),
              Body(
                color: Colors.black,
                text: membersListController
                    .requestmembresmodel?[index].requesteDateTime
                    .toString(),
              ),
            ],
          ),
        ),
        Container(
          decoration: DottedDecoration(),
        ),
      ],
    );
  }
}
