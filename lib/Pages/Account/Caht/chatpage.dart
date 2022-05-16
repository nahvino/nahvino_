import 'dart:io';
import 'dart:ui' as ui;
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:Nahvino/Pages/Account/Caht/chat_page_controller.dart';
import 'package:Nahvino/Pages/Account/Caht/AboutGroup.dart';

import '../../../Model/User/SignalR/ReceiveMessageModel.dart';
import '../../../Utils/Text/Text.dart';
import '../User/ViewProfileUesr.dart';

class Chatpage extends StatelessWidget {
  Chatpage({Key? key}) : super(key: key);

  late String adminName;
  final ChatPageController chatPageController = Get.put(ChatPageController());

  @override
  Widget build(BuildContext context) {
    _checkKEyboardAndEmojiVisibility();

    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            title: Column(
              children: [
                Row(
                  children: [
                    Subhead(
                      text: chatPageController.model!.name.toString(),
                      color: Colors.white,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Caption2(
                      text: 'تعداد اعضای گروه',
                      color: Colors.amberAccent,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Caption1(
                      text: chatPageController.model!.userCount.toString(),
                      color: Colors.amberAccent,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Caption2(
                      text: 'نفر',
                      color: Colors.amberAccent,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
            leading: IconButton(
                icon: Image.asset("assets/images/ram/gorp.png"),
                onPressed: () {
                  if (chatPageController.model == null) {
                    return;
                  }

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AboutGroup(model: chatPageController.model!)));
                }),
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              Obx(
                () => chatPageController.showScrollToEnd.value
                    ? IconButton(
                        onPressed: () {
                          chatPageController.scrollDown();
                        },
                        icon: Icon(Icons.arrow_downward))
                    : SizedBox(),
              )
            ]),
        backgroundColor: Colors.grey[200],
        body: SafeArea(child: body(context)),
      ),
    );
  }

  Widget body(BuildContext context) => Column(children: [
        Expanded(
          child: GetBuilder<ChatPageController>(builder: (controller) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                controller.showScrollToEnd.value =
                    notification.metrics.pixels >= 90;

                if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent) {
                  // load more
                  if (controller.loadMoreLoading.value == false) {
                    print("Load more");
                    controller.getAllMessages();
                  }
                }
                return true;
              },
              child: Obx(() => SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ListView.builder(
                              reverse: false,
                              shrinkWrap: true,
                              itemCount: chatPageController.chats.length,
                              itemBuilder: chatItem,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                            if (controller.showScrollToEnd.value)
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                    onPressed: () {}, icon: Icon(Icons.home)),
                              )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        if (controller.loadMoreLoading.value)
                          CircularProgressIndicator(),
                      ],
                    ),
                  )),
            );
          }),
        ),
        GetBuilder<ChatPageController>(
            builder: (controller) => chatPageController.MyRepledMessage != null
                ? _showReplay(context)
                : SizedBox()),
        Card(
            elevation: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(() {
                  return Column(
                    children: [
                      Visibility(
                        visible: chatPageController.show(),
                        child: IconButton(
                            icon: Icon(Icons.emoji_emotions_outlined),
                            onPressed: () {
                              if (WidgetsBinding
                                      .instance!.window.viewInsets.bottom >=
                                  0) {
                                FocusScope.of(context).unfocus();
                              }
                              Future.delayed(Duration(milliseconds: 10), () {
                                chatPageController.emojiShowing.value =
                                    !chatPageController.emojiShowing.value;
                                chatPageController.hide.value =
                                    !chatPageController.hide.value;
                                chatPageController.show.value =
                                    !chatPageController.show.value;
                              });
                            }),
                      ),
                      Visibility(
                        visible: chatPageController.hide(),
                        child: IconButton(
                            icon: Icon(Icons.keyboard),
                            onPressed: () {
                              if (WidgetsBinding
                                      .instance!.window.viewInsets.bottom >=
                                  0) {
                                FocusScope.of(context).requestFocus();
                              }
                              chatPageController.hide.value =
                                  !chatPageController.hide.value;
                              chatPageController.show.value =
                                  !chatPageController.show.value;
                            }),
                      ),
                    ],
                  );
                }),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "پیام خود را بنویسید"),
                  keyboardType: TextInputType.multiline,
                  autofocus: false,
                  maxLines: 5,
                  minLines: 1,
                  enabled: true,
                  textAlign: TextAlign.start,
                  maxLengthEnforced: true,
                  controller: chatPageController.chatEditController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                        RegExp(r'(کیر|کص|جنده|کصکش)', caseSensitive: false),
                        replacementString: '')
                  ],
                )),
                IconButton(
                    icon: Icon(
                      Icons.send,
                      color: chatPageController.changecolor(),
                    ),
                    onPressed: () {
                      chatPageController.sendMessage();
                    }),
              ],
            )),
        Obx(() {
          return Offstage(
            offstage: !chatPageController.emojiShowing.value,
            child: SizedBox(
              height: 250,
              child: EmojiPicker(
                  onEmojiSelected: (Category category, Emoji emoji) {
                    chatPageController.onEmojiSelected(emoji);
                  },
                  onBackspacePressed: chatPageController.onBackspacePressed,
                  config: Config(
                      columns: 7,
                      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      initCategory: Category.RECENT,
                      bgColor: const Color(0xFFF2F2F2),
                      indicatorColor: Colors.blue,
                      iconColor: Colors.grey,
                      iconColorSelected: Colors.blue,
                      progressIndicatorColor: Colors.blue,
                      backspaceColor: Colors.blue,
                      skinToneDialogBgColor: Colors.white,
                      skinToneIndicatorColor: Colors.grey,
                      enableSkinTones: true,
                      showRecentsTab: true,
                      recentsLimit: 28,
                      noRecentsText: 'No Recents',
                      noRecentsStyle:
                          const TextStyle(fontSize: 20, color: Colors.black26),
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL)),
            ),
          );
        }),
        /*Container(
      child: Buttonfull(
          text: AppLocalizations.of(context)!
              .translate('Date_of_departure')!,
          onPressed: () {
            if(model == null){
              return;
            }


            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AboutGroup(model: model!)));
          },
          color: Colors.white),
    ),*/
      ]);

  Widget chatItem(context, index) {
    ReceiveMessageModel chat = chatPageController.chats[index];
    bool fromMe = chat.userId == chatPageController.myUserId;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          fromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        fromMe
            ? ChatBubble(
                clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                backGroundColor: Color(0xffE7E7ED),
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        chatPageController.addToReply(chat);
                                        Navigator.of(context).pop();
                                      },
                                      title: Text("Replay"),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        chatPageController.addToReply(chat);
                                        Navigator.of(context).pop();
                                      },
                                      title: Text("Report"),
                                    ),
                                    if (fromMe)
                                      ListTile(
                                        onTap: () {
                                          chatPageController.DeleteMessage(
                                              chat);
                                          Navigator.of(context).pop();
                                        },
                                        title: Text("delete"),
                                      ),
                                  ],
                                ),
                              ));
                    },
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 90),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: Footnate(
                              color: Colors.teal,
                              text: chat.userNameAlias!,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          if (chat.parentMessageUserNameAlias != null)
                            if (chat.parentMessageText != null)
                              Card(
                                shape: Border(right: BorderSide(color: Colors.cyan, width: 5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Caption1(
                                        text: chat
                                            .parentMessageUserNameAlias!,
                                      ),
                                      Caption1(
                                          text: chat.parentMessageText!),
                                    ],
                                  ),
                                ),
                                color: Colors.grey[100],
                              ),
                            /*Caption1(
                                text: chat.parentMessageText!),*/
                            /* Container(
                              child: Subhead(
                                color: Colors.black,
                                text: chat.text!,
                                textAlign: TextAlign.right,
                              ),
                            ),*/
                            //Text(chat.parentMessageText!),
                            Subhead(
                              color: Colors.black,
                              text: chat.text!,
                              textAlign: TextAlign.right,
                            ),
                          Container(
                            padding: EdgeInsets.only(right: 5, left: 5),
                            child: Footnate(
                              color: Colors.black,
                              text: chat.insertTime.toString(),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : ChatBubble(
                clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                margin: EdgeInsets.only(top: 10),
                backGroundColor: Colors.cyan[50],
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        child: Container(
                          child: Footnate(
                            color: Colors.teal,
                            text: chat.userNameAlias!,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewProfileUesr(
                                        userid: chat.userId,
                                      )));
                        },
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            chatPageController.addToReply(chat);
                                            Navigator.of(context).pop();
                                          },
                                          title: Text("Replay"),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            chatPageController.addToReply(chat);
                                            Navigator.of(context).pop();
                                          },
                                          title: Text("Report"),
                                        ),
                                        if (fromMe)
                                          ListTile(
                                            onTap: () {
                                              chatPageController.DeleteMessage(
                                                  chat);
                                              Navigator.of(context).pop();
                                            },
                                            title: Text("delete"),
                                          ),
                                      ],
                                    ),
                                  ));
                        },
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width - 90),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (chat.parentMessageUserNameAlias != null)
                                if (chat.parentMessageText != null)

                                  Card(
                                    shape:Border(right: BorderSide(color: Colors.cyan, width: 5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Caption1(
                                            text: chat
                                                .parentMessageUserNameAlias!,
                                          ),
                                          Caption1(
                                              text: chat.parentMessageText!),
                                        ],
                                      ),
                                    ),
                                    color: Colors.grey[100],
                                  ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5, left: 5),
                                    child: Subhead(
                                      color: Colors.black,
                                      text: chat.text!,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                              /*   Subhead(
                                  color: Colors.black,
                                  text: chat.text!,
                                  textAlign: TextAlign.right,
                                ),*/

                              Container(
                                padding: EdgeInsets.only(right: 1, left: 1),
                                child: Footnate(
                                  color: Colors.black,
                                  text: chat.insertTime.toString().replaceAll(
                                      RegExp(
                                          r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$'),
                                      chat.insertTime.toString()),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: fromMe ? Colors.red : Colors.cyan, width: 2),
              borderRadius: BorderRadius.circular(8)),
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              onTap: () {
                                chatPageController.addToReply(chat);
                                Navigator.of(context).pop();
                              },
                              title: Text("Replay"),
                            ),
                            ListTile(
                              onTap: () {
                                chatPageController.addToReply(chat);
                                Navigator.of(context).pop();
                              },
                              title: Text("Report"),
                            ),
                            if (fromMe)
                              ListTile(
                                onTap: () {
                                  chatPageController.addToReply(chat);
                                  Navigator.of(context).pop();
                                },
                                title: Text("delete"),
                              ),
                          ],
                        ),
                      ));
            },
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 3,
                      right: 10,
                      left: 8,
                      bottom: 3,
                    ),
                    child: Callout(
                      color: Colors.teal,
                      text: chat.userNameAlias!,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  if (chat.parentMessageUserNameAlias != null)
                    Container(
                        child: Text(chat.parentMessageUserNameAlias!),
                        color: Colors.grey[100],
                        padding: EdgeInsets.all(12)),
                  if (chat.parentMessageText != null)
                    //Text(chat.parentMessageText!),

                    Container(
                        child: Text(chat.parentMessageText!),
                        color: Colors.grey[100],
                        padding: EdgeInsets.all(8)),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(right: 5, left: 5, top: 10),
                      child: Subhead(
                        color: Colors.black,
                        text: chat.text!,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 5, left: 5),
                    child: Footnate(
                      color: Colors.black,
                      text: ti,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),*/
              ),
      ],
    );
  }

  _showReplay(context) {
    return Card(
      color: Colors.red.shade50,
      child: Container(
        padding: EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  chatPageController.removeMyReplyedMessage();
                },
                icon: Icon(Icons.close)),
            Expanded(
              child: Text(
                chatPageController.MyRepledMessage!.text!,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkKEyboardAndEmojiVisibility() {
    if (chatPageController.emojiShowing.isTrue) {
      if (WidgetsBinding.instance!.window.viewInsets.bottom >= 0) {
        chatPageController.emojiShowing.value = false;
      }
    }
  }
}
