import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/Chat/group/Widget/chat_group_widget.dart';
import 'package:Nahvino/features/Chat/group/Widget/public_group_widget.dart';
import 'package:Nahvino/features/Chat/group/chat_group/controllers/chat_group_controller.dart';
import 'package:Nahvino/features/Chat/group/chat_group/widget/menu_chat_group_widght.dart';
import 'package:Nahvino/features/Chat/group/info_group/controllers/info_group_controller.dart';
import 'package:Nahvino/features/Chat/group/info_group/screen/info_screen.dart';
import 'package:Nahvino/features/Chat/group/main/controllers/group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AppBarChatWidght extends StatelessWidget {
   AppBarChatWidght({Key? key,}) : super(key: key);
   ChatGroupController chat_group_controller = Get.put(ChatGroupController());
   InfoGroupController info_group_controller = Get.put(InfoGroupController());
   GroupController group_controller = Get.put(GroupController());
   ChatGroupWidget chat_group = ChatGroupWidget();
   PublicGroupWidget gowidget = PublicGroupWidget();
   Imageview img = Imageview();
   @override
  Widget build(BuildContext context) {
     var size, height, width;
     size = MediaQuery.of(context).size;
     height = size.height;
     width = size.width;
    return Obx(() {
  return AppBar(
      elevation: 1,
      backgroundColor: Colors.cyan.shade800,
      actions: [
        chat_group_controller.select_mood.value
            ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () => "", icon: Icon(Icons.delete)),
            IconButton(
                onPressed: () =>
                chat_group_controller.select_mood.value = false,
                icon: Icon(Icons.close)),

          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [


            // SizedBox(
            //   width: width / 2.5,
            // ),
            chat_group_controller.serach_mood.value
                ?
            // name group

            Row(
      children: [

      Container(
       width: width / 1.22,
      child:
              gowidget.searchmood(changed: (value) {
                chat_group_controller.serchtext.value = value;
                chat_group_controller.update();
              }),
      ),
        IconButton(
            onPressed: () {
              chat_group_controller.serach_mood.value = false;

              chat_group_controller.update();
            },
            icon: Icon(chat_group_controller.serach_mood.value
                ? Icons.close
                : Icons.search)),
             ]
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: width * 0.25,),

                InkWell(
                    onTap: () => Get.to(
                      // InfoGroup()
                        InfoScreenGroup()),
                    child: Row(
                      children: [
                        Title2(
                            color: Colors.white,
                            text: chat_group_controller.appbarname.value.length > 17
                                ? 'chat_group_controller.appbarname.value.substring(0, 17))}...'
                                : chat_group_controller.appbarname.value),
                        (chat_group_controller.appbarimage.value != null)
                            ? img.image(chat_group_controller.appbarimage.value)
                            : img.image_assets(),
                      ],
                    )),

                //menu pop up
                MenuAppbarChatGroupWudght(),
              ],
            ),
          ],
        ),
        SizedBox(
          width: 8,
        ),
      ],
    );
});
  }
}
