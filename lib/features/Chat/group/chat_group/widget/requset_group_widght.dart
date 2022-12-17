import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/Chat/group/chat_group/controllers/join_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class RequsetGroupWidget extends StatelessWidget {
  RequsetGroupWidget({Key? key}) : super(key: key);
  ChatJoinGroupController chat_join_group_controller = Get.put(ChatJoinGroupController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
     height: height  / 4,
      child:  Column(
        children: [
          // Card(
          //   //shape: CircleBorder(),
          //     clipBehavior: Clip.antiAliasWithSaveLayer,
          //     child:
          //     Image(
          //         height: 240,
          //         fit: BoxFit.cover,
          //         image: NetworkImage("https://axprint.com/blog/wp-content/uploads/2020/10/profile00-750x430.jpg"))
          // ),
        Padding(
          padding:  EdgeInsets.only(left: 20,right: 20,top: 20),
          child:
          Flexible(
            child: HeadLine(text: AppLocalizations.of(context)!.translate(
              'dti_grup',
            )!),
          ),),
          Spacer(flex: 1,),
          Padding(
            padding:  EdgeInsets.only(left: 20,right: 20,bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                SizedBox(
                  width: 260,
                  child: Buttonfull(
                    text: "درخواست عضویت",
                    color: Colors.white,
                    onPressed: () async {
                    chat_join_group_controller.get_rquset();
                    Get.snackbar("پیام", chat_join_group_controller.add_request_join_group_model!.message.toString());
                    Navigator.pop(context, true);

                    },
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Buttonfull(
                    text: "انصراف",
                    color: Colors.white,
                    onPressed: () async {
                      Navigator.pop(context, true);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ));
  }
}
