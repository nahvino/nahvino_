import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/Chat/group/chat_group/controllers/join_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequsetGroupWidget extends StatelessWidget {
  RequsetGroupWidget({Key? key}) : super(key: key);
  ChatJoinGroupController chat_join_group_controller =
      Get.put(ChatJoinGroupController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
        height: height / 4,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.translate('dti_grup'),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Vazirmatn_ExtraBold'),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.6,
                    child: Buttonfull(
                      text: "درخواست عضویت",
                      color: Colors.white,
                      onPressed: () async {
                        chat_join_group_controller.get_rquset();
                        Get.snackbar(
                            "پیام",
                            chat_join_group_controller
                                .add_request_join_group_model!.message
                                .toString());
                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                  SizedBox(
                    width: width * 0.28,
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
