import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/core/Utils/Menu/menu_pop.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/core/shared/presentation/controllers/getx/Utils/check_controller.dart';
import 'package:Nahvino/features/Chat/fake_info/model_user.dart';
import 'package:Nahvino/features/Chat/group/Widget/chat_group_widget.dart';
import 'package:Nahvino/features/Chat/group/Widget/public_group_widget.dart';
import 'package:Nahvino/features/Chat/group/chat_group/controllers/chat_group_controller.dart';
import 'package:Nahvino/features/Chat/group/info_group/controllers/info_group_controller.dart';
import 'package:Nahvino/features/Chat/group/edit_group/screen/edit_group_screen.dart';
import 'package:Nahvino/features/Chat/group/info_group/screen/info_screen.dart';
import 'package:Nahvino/features/Chat/group/main/controllers/group_controller.dart';
import 'package:Nahvino/features/Chat/group/sharing/screen/mission_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class ChatGroup extends StatelessWidget {
  ChatGroup({
    Key? key,
    required this.names,
    this.imagegrup,
  }) : super(key: key);
  final String names;
  final String? imagegrup;
  ChatGroupController chat_group_controller = Get.put(ChatGroupController());
  GroupController group_controller = Get.put(GroupController());
  InfoGroupController info_group_controller = Get.put(InfoGroupController());
  CheckController checkcontroller = Get.put(CheckController());
  ChatGroupWidget chat_group = ChatGroupWidget();
  PublicGroupWidget gowidget = PublicGroupWidget();
  Imageview img = Imageview();

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.cyan.shade800,
          actions: [
            chat_group_controller.select_mood.value
                ? Row(
                    children: [
                      IconButton(onPressed: () => "", icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () =>
                              chat_group_controller.select_mood.value = false,
                          icon: Icon(Icons.close)),
                    ],
                  )
                : Row(
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

                          Container(
                              width: width / 1.32,
                              child: gowidget.searchmood(changed: (value) {
                                chat_group_controller.serchtext.value = value;
                                chat_group_controller.update();
                              }),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () => Get.to(
                                        // InfoGroup()
                                        InfoScreen()),
                                    child: Row(
                                      children: [
                                        Title2(
                                            color: Colors.white,
                                            text: names.length > 17
                                                ? '${names.substring(0, 17)}...'
                                                : names),
                                        (imagegrup != null)
                                            ? img.image(imagegrup)
                                            : img.image_assets(),
                                      ],
                                    )),

                                //menu pop up
                                MenuPopUp(
                                  menuItems: <FocusedMenuItem>[
                                    FocusedMenuItem(
                                        title: Footnate(
                                          text: AppLocalizations.of(context)!.translate(
                                            'Settings',
                                          )!,
                                        ),
                                        trailingIcon: Icon(Icons.settings),
                                        onPressed: () {
                                          Get.to(EditGroup());
                                        }),
                                    FocusedMenuItem(
                                        title: Footnate(
                                          text: AppLocalizations.of(context)!.translate(
                                            'link',
                                          )!,
                                        ),
                                        trailingIcon: Icon(Icons.share),
                                        onPressed: () {
                                          Share.share(MainConfig.baseURL +
                                              "/" +
                                              info_group_controller.link
                                                  .toString());
                                        }),
                                    FocusedMenuItem(
                                        title: Footnate(
                                          text: AppLocalizations.of(context)!.translate(
                                            'Maram_Namah',
                                          )!,
                                        ),
                                        trailingIcon:
                                            Icon(Icons.pending_actions),
                                        onPressed: () {
                                          Get.to(MissionScreen());
                                        }),
                                    if (info_group_controller.join.value ==
                                        false)
                                      FocusedMenuItem(
                                          title: Footnate(
                                            color: Colors.redAccent,
                                            text: AppLocalizations.of(context)!.translate(
                                              'Leave_group',
                                            )!,
                                          ),
                                          trailingIcon: Icon(
                                            Icons.exit_to_app,
                                            color: Colors.redAccent,
                                          ),
                                          onPressed: () {
                                            info_group_controller.leavegroup();
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
                  itemCount: chat_group_controller.serchtext.value != "" &&
                          chat_group_controller.serach_mood.value
                      ? fakeMassagegroup
                          .where((element) => element.mass!
                              .contains(chat_group_controller.serchtext.value))
                          .toList()
                          .length
                      : fakeMassagegroup.length,
                  itemBuilder: chatItem,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
            ),
            if (info_group_controller.join.value == true)
              Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Caption1(
                                color: Colors.black,
                                text: AppLocalizations.of(context)!.translate(
                                  'You_are_not_a_member_of_the_group',
                                )!,
                                textAlign: TextAlign.right,
                              ),
                              TextButton(
                                onPressed: () {
                                  info_group_controller.join.value = false;
                                },
                                child: Subhead(
                                  color: Colors.blue,
                                  text: AppLocalizations.of(context)!.translate(
                                    'Subscribe',
                                  )!,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (info_group_controller.join.value == false)
              Card(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        showCursor: true,
                        enableSuggestions: true,
                        autocorrect: true,
                        enableInteractiveSelection: true,
                        enableIMEPersonalizedLearning: true,
                        scribbleEnabled: true,
                        mouseCursor: MouseCursor.uncontrolled,
                        focusNode: chat_group_controller.focusNode,
                        smartDashesType: SmartDashesType.enabled,
                        smartQuotesType: SmartQuotesType.enabled,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: chat_group_controller.icomke,
                              onPressed: () {
                                chat_group_controller.focusNode.unfocus();
                                focusNode.canRequestFocus = false;
                                chat_group_controller.emojiShowing.value =
                                    !chat_group_controller.emojiShowing.value;
                                chat_group_controller.icomke =
                                    Icon(Icons.keyboard_alt_outlined);
                                if (chat_group_controller.emojiShowing.value ==
                                    true) {
                                  FocusScope.of(context).requestFocus(
                                      chat_group_controller.focusNode);
                                } else {
                                  chat_group_controller.focusNode.unfocus();
                                  focusNode.canRequestFocus = false;
                                }
                              },
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "پیام خود را بنویسید"),
                        onChanged: (value) {
                          chat_group_controller.canSend.value =
                              value.isEmpty || value == "";
                        },
                        keyboardType: TextInputType.multiline,
                        autofocus: false,
                        maxLines: 5,
                        minLines: 1,
                        enabled: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16, fontFamily: 'Vazirmatn_Light'),
                        controller: chat_group_controller.chat_text,
                      ),
                    ),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(Icons.emoji_emotions_outlined)),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          color: chat_group_controller.canSend.value
                              ? Colors.black
                              : Colors.cyan,
                        ),
                        onPressed: () {}),
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
              fromMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
                  fromMe ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                //me
                fromMe
                    ? Row(
                        children: [
                          if (chat_group_controller.select_mood.value == true)
                            Checkbox(
                                value: chat_group_controller.checkbox.value,
                                onChanged: (Value) {}),
                          SwipeableTile(
                            color: Colors.transparent,
                            swipeThreshold: 0.1,
                            direction: SwipeDirection.horizontal,
                            isElevated: false,
                            movementDuration: Duration(milliseconds: 1),
                            resizeDuration: Duration(milliseconds: 1),
                            onSwiped: (direction) {
                              if (direction == SwipeDirection.endToStart) {
                                Clipboard.setData(ClipboardData(
                                    text: fakeMassagegroup[index].mass));
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
                                      text: AppLocalizations.of(context)!.translate(
                                        'copy',
                                      )!,
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
                                      text: AppLocalizations.of(context)!.translate(
                                        'Replay',
                                      )!,
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
                                child: Column(
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            //Title3(text: chat!.mass.toString()),

                                            ChatTextMassgae(
                                                fonts: chat_group_controller
                                                    .selectedfont.value,
                                                fontsize: chat_group_controller
                                                            .settings
                                                            .read("text") ==
                                                        null
                                                    ? 16
                                                    : chat_group_controller
                                                        .settings
                                                        .read("text"),
                                                text: fakeMassagegroup[index]
                                                    .name),
                                            InkWell(
                                              onTap: () {
                                                print("asd");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.black12,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 5,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            5),
                                                                topRight: Radius
                                                                    .circular(
                                                                        5)),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        color:
                                                            Colors.greenAccent,
                                                      ),
                                                    ),
                                                    // Footnate(
                                                    //   text: chat
                                                    //       .parentMessageUserNameAlias!,
                                                    //   ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: Column(
                                                        children: [
                                                          ChatTextMassgae(
                                                            fonts:
                                                                chat_group_controller
                                                                    .selectedfont
                                                                    .value,
                                                            text: "نام",
                                                          ),
                                                          // Caption1(
                                                          //     text: chat.parentMessageText!
                                                          //         .length >
                                                          //         30
                                                          //         ? '${chat.parentMessageText!.substring(0, 30)}...'
                                                          //         : chat
                                                          //         .parentMessageText),
                                                          ChatTextMassgae(
                                                              fonts: chat_group_controller
                                                                  .selectedfont
                                                                  .value,
                                                              text:
                                                                  fakeMassagegroup[
                                                                          index]
                                                                      .mass),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ChatTextMassgae(
                                                fonts: chat_group_controller
                                                    .selectedfont.value,
                                                fontsize: chat_group_controller
                                                            .settings
                                                            .read("text") ==
                                                        null
                                                    ? 16
                                                    : chat_group_controller
                                                        .settings
                                                        .read("text"),
                                                text: fakeMassagegroup[index]
                                                    .mass),

                                            ChatTextMassgae(
                                                fonts: chat_group_controller
                                                    .selectedfont.value,
                                                fontsize: chat_group_controller
                                                            .settings
                                                            .read("text") ==
                                                        null
                                                    ? 16
                                                    : chat_group_controller
                                                        .settings
                                                        .read("text"),
                                                text: fakeMassagegroup[index]
                                                    .time),
                                            Stack(
                                              children: [
                                                Icon(
                                                  Icons.check_outlined,
                                                  size: 14,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Icon(
                                                    Icons.check_outlined,
                                                    size: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                                    SwipeDirection.startToEnd) {
                                  Clipboard.setData(ClipboardData(
                                      text: fakeMassagegroup[index].mass));
                                }
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
                                        text: AppLocalizations.of(context)!.translate(
                                          'Replay',
                                        )!,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  );
                                } else if (direction ==
                                    SwipeDirection.startToEnd) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Subhead(
                                        color: Colors.black,
                                        text: AppLocalizations.of(context)!.translate(
                                          'copy',
                                        )!,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  );
                                }
                                return Container();
                              },
                              key: UniqueKey(),
                              child: // Here Tile which will be shown at the top
                                  Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ChatBubble(
                                    clipper: ChatBubbleClipper2(
                                        type: BubbleType.receiverBubble),
                                    backGroundColor: Color(0xffE7E7ED),
                                    margin: EdgeInsets.only(top: 4, bottom: 4),
                                    child: Column(
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ChatTextMassgae(
                                                  fonts: chat_group_controller
                                                      .selectedfont.value,
                                                  fontsize: chat_group_controller
                                                              .settings
                                                              .read("text") ==
                                                          null
                                                      ? 16
                                                      : chat_group_controller
                                                          .settings
                                                          .read("text"),
                                                  text: fakeMassagegroup[index]
                                                      .name),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.black12,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 5,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            5),
                                                                topRight: Radius
                                                                    .circular(
                                                                        5)),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        color:
                                                            Colors.greenAccent,
                                                      ),
                                                    ),
                                                    // Footnate(
                                                    //   text: chat
                                                    //       .parentMessageUserNameAlias!,
                                                    //   ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: Column(
                                                        children: [
                                                          ChatTextMassgae(
                                                            fonts:
                                                                chat_group_controller
                                                                    .selectedfont
                                                                    .value,
                                                            text: "نام",
                                                          ),
                                                          // Caption1(
                                                          //     text: chat.parentMessageText!
                                                          //         .length >
                                                          //         30
                                                          //         ? '${chat.parentMessageText!.substring(0, 30)}...'
                                                          //         : chat
                                                          //         .parentMessageText),
                                                          ChatTextMassgae(
                                                              fonts: chat_group_controller
                                                                  .selectedfont
                                                                  .value,
                                                              text: "پیام"),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ChatTextMassgae(
                                                  fonts: chat_group_controller
                                                      .selectedfont.value,
                                                  fontsize: chat_group_controller
                                                              .settings
                                                              .read("text") ==
                                                          null
                                                      ? 16
                                                      : chat_group_controller
                                                          .settings
                                                          .read("text"),
                                                  text: fakeMassagegroup[index]
                                                      .mass),
                                              ChatTextMassgae(
                                                  fonts: chat_group_controller
                                                      .selectedfont.value,
                                                  fontsize: chat_group_controller
                                                              .settings
                                                              .read("text") ==
                                                          null
                                                      ? 16
                                                      : chat_group_controller
                                                          .settings
                                                          .read("text"),
                                                  text: fakeMassagegroup[index]
                                                      .time),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  (imagegrup != null &&
                                          imagegrup != "" &&
                                          imagegrup != "null")
                                      ? img.image(imagegrup!)
                                      : img.image_asset_user(
                                          fakeMassagegroup[index].image!, true),
                                ],
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
