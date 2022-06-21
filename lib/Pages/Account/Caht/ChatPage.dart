import 'dart:io';
import 'dart:ui' as ui;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:get/get.dart';
import 'package:Nahvino/Pages/Account/Caht/ChatPageController.dart';
import 'package:Nahvino/Pages/Account/Caht/AboutGroup.dart';
import 'package:lottie/lottie.dart';
import '../../../App_localizations.dart';
import '../../../Model/User/SignalR/ReceiveMessageModel.dart';
import '../../../Utils/Text/Text.dart';
import '../User/ViewProfileUesr.dart';

class Chatpage extends StatefulWidget {
  Chatpage({Key? key}) : super(key: key);

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  late String adminName;
  final ChatPageController chatPageController = Get.put(ChatPageController());
  String? adminid;
  String? nazer1;
  String? nazer2;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1),
        () => chatPageController.isApiCallProgress.value = false);
    adminid = chatPageController.model?.adminId.toString();
    nazer1 = chatPageController.model?.supervisor1Id.toString();
    nazer2 = chatPageController.model?.supervisor2Id.toString();
  }

  @override
  Widget build(BuildContext context) {
    _checkKEyboardAndEmojiVisibility();
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Obx(() {
        return chatPageController.isApiCallProgress.value
            ? Center(
                child: Lottie.asset('assets/anim/chat/arty-chat.json',
                    height: 300, width: 300),
              )
            : Scaffold(
                appBar: AppBar(
                    title: chatPageController.isInSearchMode.value
                        ? TextField(
                            onChanged: (value) {
                              chatPageController.searchText.value = value;
                              chatPageController.update();
                            },
                            decoration: InputDecoration(hintText: "جستجو"),
                          )
                        : InkWell(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Subhead(
                                      text:
                                          chatPageController.model!.name ?? "",
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
                                      text: chatPageController.model!.userCount
                                          .toString(),
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AboutGroup(
                                          model: chatPageController.model!)));
                            }),
                    leading: IconButton(
                        icon: Image.asset("assets/images/ram/gorp.png"),
                        onPressed: () {
                          if (chatPageController.model == null) {
                            return;
                          }

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutGroup(
                                      model: chatPageController.model!)));
                        }),
                    actions: [
                      IconButton(
                          icon: Icon(chatPageController.isInSearchMode.value
                              ? Icons.close
                              : Icons.search),
                          onPressed: () {
                            chatPageController.isInSearchMode.value =
                                !chatPageController.isInSearchMode.value;
                            chatPageController.update();
                          }),
                      chatPageController.showScrollToEnd.value
                          ? IconButton(
                              onPressed: () {
                                chatPageController.scrollDown();
                              },
                              icon: Icon(Icons.arrow_downward))
                          : SizedBox(),
                    ]),
                backgroundColor: Colors.grey[200],
                body: SafeArea(child: body(context)));
      }),
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
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller.chatSingleChildScrollController,
                      reverse: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: controller.chatScrollController,
                        itemCount: chatPageController.searchText.value != "" &&
                                chatPageController.isInSearchMode.value
                            ? chatPageController.chats
                                .where((element) => element.text!.contains(
                                    chatPageController.searchText.value))
                                .toList()
                                .length
                            : chatPageController.chats.length,
                        itemBuilder: chatItem,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ),
                  ),
                  if (controller.loadMoreLoading.value)
                    CircularProgressIndicator(),
                ],
              ),
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
                IconButton(
                    onPressed: () {
                      if (WidgetsBinding.instance.window.viewInsets.bottom >
                          0) {
                        FocusScope.of(context).unfocus();

                        Future.delayed(Duration(milliseconds: 500), () {
                          chatPageController.emojiShowing.value = true;
                        });
                      } else {
                        chatPageController.emojiShowing.value =
                            !chatPageController.emojiShowing.value;
                      }
                    },
                    icon: Icon(chatPageController.emojiShowing.value
                        ? Icons.keyboard
                        : Icons.emoji_emotions_outlined)),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "پیام خود را بنویسید"),
                  onChanged: (value) {
                    chatPageController.canSend.value =
                        value.isEmpty || value == "";
                  },
                  keyboardType: TextInputType.multiline,
                  autofocus: false,
                  maxLines: 5,
                  minLines: 1,
                  enabled: true,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, fontFamily: 'Vazirmatn_Light'),
                  controller: chatPageController.chatEditController,
                )),
                IconButton(
                    icon: Icon(
                      Icons.send,
                      color: chatPageController.canSend.value
                          ? Colors.black
                          : Colors.cyan,
                    ),
                    onPressed: () {
                      chatPageController.sendMessage();
                      chatPageController.canSend.value = true;
                    }),
              ],
            )),
        Offstage(
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
                    //noRecentsText: 'No Recents',
                    //  noRecentsStyle:
                    //    const TextStyle(fontSize: 20, color: Colors.black26),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL)),
          ),
        ),
      ]);

  Widget chatItem(context, index) {
    ReceiveMessageModel chat;

    if (chatPageController.isInSearchMode.value &&
        chatPageController.searchText.value != "") {
      chat = chatPageController.chats
          .where((element) =>
              element.text!.contains(chatPageController.searchText.value))
          .toList()[index];
    } else {
      chat = chatPageController.chats[index];
    }
    bool fromMe = chat.userId == chatPageController.myUserId;
    return Column(
      crossAxisAlignment:
          fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // Container(
        //   alignment: Alignment.center,
        //   child: Footnate(
        //     color: Colors.black,
        //     text: csسhat.insertTime.toString().split("   ")[1].split(":")[0] +
        //         ":" +
        //         chat.insertTime.toString().split("   ")[1].split(":")[1],
        //     textAlign: TextAlign.left,
        //   ),
        // ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              fromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            fromMe
                ? ChatBubble(
                    clipper:
                        ChatBubbleClipper1(type: BubbleType.receiverBubble),
                    backGroundColor: Color(0xffE7E7ED),
                    margin: EdgeInsets.only(top: 4, bottom: 4),
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
                                          title: Subhead(
                                            color: Colors.black,
                                            text: AppLocalizations.of(context)!
                                                .translate(
                                              'Replay',
                                            )!,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(
                                                text: chat.text!));
                                            Navigator.of(context).pop();
                                          },
                                          title: Subhead(
                                            color: Colors.black,
                                            text: "کپی",
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        if (fromMe)
                                          ListTile(
                                            onTap: () {
                                              chatPageController.DeleteMessage(
                                                  chat);
                                              Navigator.of(context).pop();
                                            },
                                            title: Subhead(
                                              color: Colors.black,
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .translate(
                                                'delete',
                                              )!,
                                              textAlign: TextAlign.right,
                                            ),
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
                            children: [
                              Container(
                                child: Subhead(
                                  color: Colors.teal,
                                  text: chat.userNameAlias!,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              if (chat.parentMessageUserNameAlias != null)
                                if (chat.parentMessageText != null)
                                  InkWell(
                                    onTap: () {
                                      chatPageController.scrollToChat(chat);
                                    },
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              shape: BoxShape.rectangle,
                                              color: Colors.black12,
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 5,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight: Radius
                                                                .circular(5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5)),
                                                    shape: BoxShape.rectangle,
                                                    color: Colors.greenAccent,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Footnate(
                                                      text: chat
                                                          .parentMessageUserNameAlias!,
                                                    ),
                                                    Caption1(
                                                        text: chat.parentMessageText!
                                                                    .length >
                                                                30
                                                            ? '${chat.parentMessageText!.substring(0, 30)}...'
                                                            : chat
                                                                .parentMessageText),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                              Subhead(
                                color: Colors.black,
                                text: chat.text!,
                                textAlign: TextAlign.right,
                              ),
                              Footnate(
                                color: Colors.black,
                                text: chat.insertTime
                                        .toString()
                                        .split("   ")[1]
                                        .split(":")[0] +
                                    ":" +
                                    chat.insertTime
                                        .toString()
                                        .split("   ")[1]
                                        .split(":")[1],
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : ChatBubble(
                    clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                    margin: EdgeInsets.only(top: 4, bottom: 4),
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
                              child: Subhead(
                                color: Colors.teal,
                                text: chat.userNameAlias ?? "بدون نام",
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
                                                chatPageController
                                                    .addToReply(chat);
                                                Navigator.of(context).pop();
                                              },
                                              title: Subhead(
                                                color: Colors.black,
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .translate(
                                                  'Replay',
                                                )!,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: chat.text!));
                                                Navigator.of(context).pop();
                                              },
                                              title: Subhead(
                                                color: Colors.black,
                                                text: "کپی",
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                chatPageController
                                                    .addToReply(chat);
                                                Navigator.of(context).pop();
                                              },
                                              title: Subhead(
                                                color: Colors.black,
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .translate(
                                                  'Report',
                                                )!,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            if (fromMe)
                                              ListTile(
                                                onTap: () {
                                                  chatPageController
                                                      .DeleteMessage(chat);
                                                  Navigator.of(context).pop();
                                                },
                                                title: Subhead(
                                                  color: Colors.black,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .translate(
                                                    'delete',
                                                  )!,
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            if (nazer2 ==
                                                chatPageController.myUserId)
                                              ListTile(
                                                onTap: () {
                                                  chatPageController
                                                      .DeleteMessage(chat);
                                                  Navigator.of(context).pop();
                                                },
                                                title: Subhead(
                                                  color: Colors.black,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .translate(
                                                    'delete',
                                                  )!,
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            if (nazer1 ==
                                                chatPageController.myUserId)
                                              ListTile(
                                                onTap: () {
                                                  chatPageController
                                                      .DeleteMessage(chat);
                                                  Navigator.of(context).pop();
                                                },
                                                title: Subhead(
                                                  color: Colors.black,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .translate(
                                                    'delete',
                                                  )!,
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            if (adminid ==
                                                chatPageController.myUserId)
                                              ListTile(
                                                onTap: () {
                                                  chatPageController
                                                      .DeleteMessage(chat);
                                                  Navigator.of(context).pop();
                                                },
                                                title: Subhead(
                                                  color: Colors.black,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .translate(
                                                    'delete',
                                                  )!,
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ));
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width - 90),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (chat.parentMessageUserNameAlias != null)
                                    if (chat.parentMessageText != null)
                                      InkWell(
                                        onTap: () {
                                          chatPageController.scrollToChat(chat);
                                        },
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.black12,
                                                ),
                                                child: Row(
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
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Footnate(
                                                          text: chat
                                                              .parentMessageUserNameAlias!,
                                                        ),
                                                        Caption1(
                                                            text: chat.parentMessageText!
                                                                        .length >
                                                                    30
                                                                ? '${chat.parentMessageText!.substring(0, 30)}...'
                                                                : chat
                                                                    .parentMessageText),
                                                        /*Caption1(
                                                            text: chat
                                                                .parentMessageText!),*/
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      ),
                                  Subhead(
                                    color: Colors.black,
                                    text: chat.text!,
                                    textAlign: TextAlign.right,
                                  ),
                                  Footnate(
                                    color: Colors.black,
                                    text: chat.insertTime
                                            .toString()
                                            .split("   ")[1]
                                            .split(":")[0] +
                                        ":" +
                                        chat.insertTime
                                            .toString()
                                            .split("   ")[1]
                                            .split(":")[1],
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
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
      if (WidgetsBinding.instance.window.viewInsets.bottom > 0) {
        chatPageController.emojiShowing.value = false;
      }
    }
  }
}
