import 'package:Nahvino/Pages/Chat/Widget/chat_group_widget.dart';
import 'package:Nahvino/Pages/Chat/Widget/public_group_widget.dart';
import 'package:Nahvino/Pages/Chat/fake_info/model_user.dart';
import 'package:Nahvino/Pages/Chat/group/edit_group.dart';
import 'package:Nahvino/Pages/Chat/group/info_group.dart';
import 'package:Nahvino/Utils/Menu/menu_pop.dart';
import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:Nahvino/Utils/Widget/image_view.dart';
import 'package:Nahvino/controllers/getx/Utils/check_controller.dart';
import 'package:Nahvino/controllers/getx/chat/group/chat_group_controller.dart';
import 'package:Nahvino/controllers/getx/chat/group/info_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

/*
 TODO: Name Group
 TODO: Emoji and kaybord
 TODO: Massgae box
 */
class ChatGroup extends StatelessWidget {
  ChatGroup({Key? key, required this.idgroup}) : super(key: key);
  ChatGroupController chat_group_controller = Get.put(ChatGroupController());
  InfoGroupController info_group_controller = Get.put(InfoGroupController());

  CheckController checkcontroller = Get.put(CheckController());
  String idgroup;
  ChatGroupWidget chat_group = ChatGroupWidget();
  PublicGroupWidget gowidget = PublicGroupWidget();

  Imageview img = Imageview();
  String? imagegrup;

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Obx(
      () => Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.cyan.shade800,
            actions: [
              chat_group_controller.select_mood.value
                  ? Row(
                      children: [
                        IconButton(
                            onPressed: () => "", icon: Icon(Icons.delete)),
                        IconButton(
                            onPressed: () =>
                                chat_group_controller.select_mood.value = false,
                            icon: Icon(Icons.close)),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              chat_group_controller.serach_mood.value =
                                  !chat_group_controller.serach_mood.value;
                              chat_group_controller.update();
                            },
                            icon: Icon(chat_group_controller.serach_mood.value
                                ? Icons.close
                                : Icons.search)),
                        // SizedBox(
                        //   width: width / 2.5,
                        // ),
                        chat_group_controller.serach_mood.value
                            ?
                            // name group
                            Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    width: width / 1.32,
                                    height: height / 17,
                                    child: gowidget.searchmood(),
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                    width: width / 2.5,
                                  ),
                                  Title2(
                                    color: Colors.white,
                                    text: "نام گروه",
                                  ),
                                  InkWell(
                                    onTap: () => Get.to(InfoGroup()),
                                    child: (imagegrup != null &&
                                            imagegrup != "" &&
                                            imagegrup != "null")
                                        ? img.image(imagegrup!)
                                        : img.image_assets(),
                                  ),

                                  //menu pop up
                                  MenuPopUp(
                                    menuItems: <FocusedMenuItem>[
                                      FocusedMenuItem(
                                          title: Footnate(
                                            text: "تنظیمات",
                                          ),
                                          trailingIcon: Icon(Icons.settings),
                                          onPressed: () {
                                            Get.to(EditGroup());
                                          }),
                                      FocusedMenuItem(
                                          title: Footnate(
                                            text: "لینک",
                                          ),
                                          trailingIcon: Icon(Icons.share),
                                          onPressed: () {
                                            print("درسته");
                                          }),
                                      if (info_group_controller.join.value ==
                                          false)
                                        FocusedMenuItem(
                                            title: Footnate(
                                              color: Colors.redAccent,
                                              text: "ترک گروه",
                                            ),
                                            trailingIcon: Icon(
                                              Icons.exit_to_app,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              info_group_controller
                                                  .leavegroup();
                                            }),
                                    ],
                                  ),
                                ],
                              ),
                      ],
                    ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
          body: body(context),
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    FocusNode focusNode = FocusNode();
    return SafeArea(
      child: Obx(
        () => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: fakeMassagegroup.length,
                  itemBuilder: chatItem,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
            ),
            Card(
              child: Row(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: chat_group_controller.canSend.value
                              ? Colors.black
                              : Colors.cyan,
                        ),
                        onPressed: () {

                        }),
                  ),
                  chat_group.text_group((value) {
                    chat_group_controller.canSend.value =
                        value.isEmpty || value == "";
                  }, chat_group_controller.chat_text, focusNode),
                  IconButton(
                      onPressed: () {
                      },
                      icon:

                      Icon(Icons.emoji_emotions_outlined)),
                ],
              ),
            ),
            chat_group.icon_message(
              chat_group_controller.emojiShowing.value,
              () {
                chat_group_controller.onBackspacePressed();
              },
              (category, emoji) {
                chat_group_controller.onEmojiSelected(emoji);
              },
            ),

          ],
        ),
      ),
    );
  }

  Widget chatItem(context, index) {
    Massage? chat;
    String myuserid = "a";
    bool fromMe = fakeMassagegroup[index].userid == myuserid;
    // bool fromMe = chat!.userid.toString() == myuserid;
    return Obx(
      () => Column(
          crossAxisAlignment:
              fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
                  fromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                fromMe
                    ? Row(
                        children: [
                          SwipeableTile(
                            color: Colors.transparent,
                            swipeThreshold: 0.1,
                            direction: SwipeDirection.horizontal,
                            isElevated: false,
                            movementDuration: Duration(milliseconds: 1),
                            resizeDuration: Duration(milliseconds: 1),
                            onSwiped: (direction) {
                              if (direction == SwipeDirection.endToStart) {
                                // Clipboard.setData(ClipboardData(text: chat.text!));

                              } else if (direction ==
                                  SwipeDirection.startToEnd) {}
                            },
                            backgroundBuilder: (context, direction, progress) {
                              if (direction == SwipeDirection.endToStart) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Subhead(
                                      color: Colors.black,
                                      text: "کپی",
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                );
                              } else if (direction ==
                                  SwipeDirection.startToEnd) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Subhead(
                                      color: Colors.black,
                                      text: "پاسخ",
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                );
                              }
                              return Container();
                            },
                            key: UniqueKey(),
                            child: InkWell(
                              onLongPress: (() => chat_group_controller
                                  .select_mood.value = true),
                              child: ChatBubble(
                                clipper: ChatBubbleClipper1(
                                    type: BubbleType.sendBubble),
                                margin: EdgeInsets.only(top: 4, bottom: 4),
                                backGroundColor: Colors.cyan[50],
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  child: Column(children: [
                                    //Title3(text: chat!.mass.toString()),
                                    Title3(text: fakeMassagegroup[index].mass),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          if (chat_group_controller.select_mood.value == true)
                            Checkbox(
                                value: chat_group_controller.checkbox.value,
                                onChanged: (Value) {}),
                        ],
                      )
                    : Center(
                        child: Row(
                          children: [
                            if (chat_group_controller.admin_select_mood.value ==
                                true)
                              Checkbox(
                                  value: chat_group_controller.checkbox.value,
                                  onChanged: (Value) {}),
                            SwipeableTile(
                              color: Colors.transparent,
                              swipeThreshold: 0.1,
                              isElevated: false,
                              movementDuration: Duration(milliseconds: 1),
                              resizeDuration: Duration(milliseconds: 1),
                              direction: SwipeDirection.horizontal,
                              onSwiped: (direction) {
                                if (direction == SwipeDirection.endToStart) {
                                } else if (direction ==
                                    SwipeDirection.startToEnd) {}
                              },
                              backgroundBuilder:
                                  (context, direction, progress) {
                                if (direction == SwipeDirection.endToStart) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Subhead(
                                        color: Colors.black,
                                        text: "پاسخ",
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  );
                                } else if (direction ==
                                    SwipeDirection.startToEnd) {}
                                return Container();
                              },
                              key: UniqueKey(),
                              child: // Here Tile which will be shown at the top
                                  ChatBubble(
                                clipper: ChatBubbleClipper1(
                                    type: BubbleType.receiverBubble),
                                backGroundColor: Color(0xffE7E7ED),
                                margin: EdgeInsets.only(top: 4, bottom: 4),
                                child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                    ),
                                    child: Column(
                                      children: [
                                        Title3(
                                            text: fakeMassagegroup[index].mass),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            )
          ]),
    );
  }
}
