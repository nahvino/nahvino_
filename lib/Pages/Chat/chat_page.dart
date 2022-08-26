import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:Nahvino/Pages/Account/User/view_profile_uesr.dart';
import 'package:Nahvino/Pages/Chat/about_group.dart';
import 'package:Nahvino/Pages/Chat/chat_page_controller.dart';
import 'package:Nahvino/Services/chat/chat_service.dart';
import 'package:Nahvino/controllers/getx/Utils/check_controller.dart';
import 'package:Nahvino/tabs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import '../../../App_localizations.dart';
import '../../../Model/User/SignalR/ReceiveMessageModel.dart';
import '../../../Utils/Text/Text.dart';

class Chatpage extends StatefulWidget {
  Chatpage({Key? key}) : super(key: key);

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  late String adminName;
  final ChatPageController chatPageController = Get.put(ChatPageController());
  CheckController checkcontroller = Get.put(CheckController());
  ConnectivityResult result = ConnectivityResult.none;
  String? adminid;
  String? nazer1;
  String? nazer2;
  late ChatService chatService;
  late StreamSubscription interfaceSubscription;
  late StreamSubscription Subscription;
  @override
  void initState() {
    super.initState();
    Subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() => this.result = result);
    });
    interfaceSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        checkcontroller.inter();
      } else if (status == InternetConnectionStatus.connected) {
        Get.offAll(MyTabs(
          tabIndex: 1,
        ));
      }
    });
    Future.delayed(Duration(seconds: 2),
        () => chatPageController.isApiCallProgress.value = false);
    adminid = chatPageController.model?.adminId.toString();
    nazer1 = chatPageController.model?.supervisor1Id.toString();
    nazer2 = chatPageController.model?.supervisor2Id.toString();
  }

  @override
  void dispose() {
    Subscription.cancel();
    interfaceSubscription.cancel();

    super.dispose();
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
                    backgroundColor: Colors.cyan.shade800,
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
                                      text: chatPageController.model!.name ??
                                          "گروه ترک اعتیاد",
                                      color: Colors.white,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                if (chatPageController.disconnected.isNotEmpty)
                                  Obx(() {
                                    return Row(
                                      children: [
                                        Caption2(
                                          text: chatPageController
                                              .disconnected.value,
                                          color: Colors.amberAccent,
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    );
                                  }),
                                if (chatPageController.disconnected.isEmpty)
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
                                        text: chatPageController
                                            .model!.userCount
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
                              Get.to(
                                  AboutGroup(model: chatPageController.model!));
                              /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AboutGroup(
                                          model: chatPageController.model!)));*/
                            }),
                    leading: IconButton(
                        icon: Image.asset("assets/images/ram/gorp.png"),
                        onPressed: () {
                          if (chatPageController.model == null) {
                            return;
                          }

                          Get.to(AboutGroup(model: chatPageController.model!));
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
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: SizedBox(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: PopupMenuButton<int>(
                              icon: Icon(Icons.more_vert_rounded),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 0,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.info_outline_rounded,
                                        color: Colors.cyan,
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      textspan(
                                        textAlign: TextAlign.end,
                                        text: "اطلاعات گروه",
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (item) => onSelected(context, item),
                            ),
                          ),
                        ),
                      ),
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
        Card(
            elevation: 0,
            child: Column(
              children: [
                GetBuilder<ChatPageController>(
                    builder: (controller) =>
                        chatPageController.MyRepledMessage != null
                            ? _showReplay(context)
                            : SizedBox()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (WidgetsBinding.instance.window.viewInsets.bottom >
                              0) {
                            FocusScope.of(context).unfocus();

                            Future.delayed(Duration(milliseconds: 1000), () {
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
                      showCursor: true,
                      enableSuggestions: true,
                      autocorrect: true,
                      enableInteractiveSelection: true,
                      enableIMEPersonalizedLearning: true,
                      scribbleEnabled: true,
                      mouseCursor: MouseCursor.uncontrolled,
                      smartDashesType: SmartDashesType.enabled,
                      smartQuotesType: SmartQuotesType.enabled,
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
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'Vazirmatn_Light'),
                      controller: chatPageController.chatEditController,
                    )),
                    //  if (chatPageController.chatEditController.text.isNotEmpty)
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
                ),
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
                ? SwipeableTile(
                    color: Colors.transparent,
                    swipeThreshold: 0.1,
                    isElevated: false,
                    movementDuration: Duration(milliseconds: 1),
                    resizeDuration: Duration(milliseconds: 1),
                    direction: SwipeDirection.horizontal,
                    onSwiped: (direction) {
                      if (direction == SwipeDirection.endToStart) {
                        chatPageController.addToReply(chat);
                      } else if (direction == SwipeDirection.startToEnd) {
                        chatPageController.addToReply(chat);
                      }
                    },
                    backgroundBuilder: (context, direction, progress) {
                      if (direction == SwipeDirection.endToStart) {
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
                      } else if (direction == SwipeDirection.startToEnd) {}
                      return Container();
                    },
                    key: UniqueKey(),
                    child: // Here Tile which will be shown at the top
                        ChatBubble(
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
                                              chatPageController
                                                  .addToReply(chat);
                                              Navigator.of(context).pop();
                                            },
                                            title: Subhead(
                                              color: Colors.black,
                                              text:
                                                  AppLocalizations.of(context)!
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
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5),
                                                              topRight: Radius
                                                                  .circular(5)),
                                                      shape: BoxShape.rectangle,
                                                      color: Colors.greenAccent,
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
                    ),
                  )
                : SwipeableTile(
                    color: Colors.transparent,
                    swipeThreshold: 0.1,
                    direction: SwipeDirection.horizontal,
                    isElevated: false,
                    movementDuration: Duration(milliseconds: 1),
                    resizeDuration: Duration(milliseconds: 1),
                    onSwiped: (direction) {
                      if (direction == SwipeDirection.endToStart) {
                        Clipboard.setData(ClipboardData(text: chat.text!));
                        chatPageController.update();
                      } else if (direction == SwipeDirection.startToEnd) {
                        chatPageController.addToReply(chat);
                      }
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
                      } else if (direction == SwipeDirection.startToEnd) {
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
                    child: ChatBubble(
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
                                                  Clipboard.setData(
                                                      ClipboardData(
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
                                                  ChatService.userreport(
                                                          chat.userId
                                                              .toString(),
                                                          chat.id)
                                                      .then((response) async {
                                                    if (response != false) {
                                                      print(
                                                          "userreport---------------------------- => $response");
                                                      /* apiService.showSnackBar(
                                                        text: response[
                                                            'message']);*/

                                                    } else {
                                                      /* apiService.showSnackBar(
                                                        text: response[
                                                            'message']);*/
                                                    }
                                                  });
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
                                            chatPageController
                                                .scrollToChat(chat);
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
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5)),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          color: Colors
                                                              .greenAccent,
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
                  ),
          ],
        ),
      ],
    );
  }

  _showReplay(context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        shape: BoxShape.rectangle,
        color: Colors.grey.shade50,
      ),
      child: Row(children: [
        Container(
          width: 4,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(0), topRight: Radius.circular(0)),
            shape: BoxShape.rectangle,
            color: Colors.greenAccent.shade400,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Caption1(
                text: chatPageController.MyRepledMessage!.userNameAlias!,
              ),
              Text(
                chatPageController.MyRepledMessage!.text!,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontFamily: 'Vazirmatn_Regular'),
              )
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              chatPageController.removeMyReplyedMessage();
            },
            icon: Icon(Icons.close)),
      ]),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Get.to(AboutGroup(model: chatPageController.model!));
    }
  }

  void _checkKEyboardAndEmojiVisibility() {
    if (chatPageController.emojiShowing.isTrue) {
      if (WidgetsBinding.instance.window.viewInsets.bottom > 0) {
        chatPageController.emojiShowing.value = false;
      }
    }
  }
}
