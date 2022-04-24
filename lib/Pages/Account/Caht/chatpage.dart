import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nahvino/Model/User/SignalR/chat_model.dart';
import 'package:nahvino/Pages/Account/Caht/chat_page_controller.dart';
import 'package:nahvino/Pages/Account/Caht/AboutGroup.dart';

import '../../../Model/User/SignalR/ReceiveMessageModel.dart';
import '../../../Utils/Widget/Text.dart';


class Chatpage extends StatelessWidget {
  Chatpage({Key? key}) : super(key: key);

  late String adminName;

  final ChatPageController chatPageController = Get.put(ChatPageController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            title: Text("ترک اعتیاد"),
            leading: IconButton(
                icon: Image.asset("assets/images/ram/gorp.png"),
                onPressed: () {
                  if (chatPageController.model == null) {
                    return;
                  }

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AboutGroup(model: chatPageController.model!)));
                }),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {

                  })
            ]),
        backgroundColor: Colors.grey[200],
        body: SafeArea(child: body(context)),
      ),
    );
  }

  Widget body(BuildContext context) => Column(children: [
        Expanded(
          child: GetBuilder<ChatPageController>(builder: (controller) {
            return ListView.builder(
              reverse: false,
              itemBuilder: chatItem,
              itemCount: chatPageController.chats.length,
            );
          }),
        ),
        GetBuilder<ChatPageController>(
            builder: (controller) => chatPageController.MyRepledMessage != null
                ? _showReplay(context)
                : SizedBox()),
        Card(
            child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.emoji_emotions_outlined),
                onPressed: () {
                  chatPageController.emojiShowing.value =
                      !chatPageController.emojiShowing.value;
                }),
            Expanded(
                child: TextField(
              controller: chatPageController.chatEditController,
            )),
            IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  chatPageController.sendMessage();
                  chatPageController.dispose();
                })
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
                      // Issue: https://github.com/flutter/flutter/issues/28894
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

    bool fromMe = chat.id == chatPageController.myUserId;

    return Row(
      mainAxisAlignment: chat.id == chatPageController.myUserId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: fromMe ? Colors.red : Colors.black, width: 2),
              borderRadius: BorderRadius.circular(24)),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 90),
            child: Column(
              children: [
                if (chat.id != null)
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      //color: Colors.grey[200],
                    ),
                    alignment: Alignment.topRight,
                    //width: 100,
                   // height: 50,
                    child: Callout( color: Colors.teal, text: chat.userNameAlias!, textAlign:TextAlign.right,),
                  ),
                InkWell(
                  onTap: () {
                    chatPageController.addToReply(chat);
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:EdgeInsets.only(
                          right:
                          MediaQuery.of(context).size.height * 0.02),
                      child: Subhead( color: Colors.black, text: chat.text!, textAlign:TextAlign.right,),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.bottomLeft,
                  child: Footnate( color: Colors.black, text: chat.insertTime.toString(), textAlign:TextAlign.left,),
                ),
              ],
            ),
          ),
        )
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

/* @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Column(
        children: [
          Container(
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
          ),
        ],
      ),
    );
  }*/
/*
  int currentUserId = 0;
  //generate random user id
  createRandomId() {
    Random random = Random();
    currentUserId = random.nextInt(999999);
  }

  ScrollController chatListScrollController = new ScrollController();
  TextEditingController messageTextController = TextEditingController();

  submitMessageFunction() async {
    var messageText = removeMessageExtraChar(messageTextController.text);
    await connection.invoke('SendMessage',
        args: [currentUserId, messageText]);
    messageTextController.text = "";

    Future.delayed(const Duration(milliseconds: 500), () {
      chatListScrollController.animateTo(
          chatListScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
    });
*/
}

/*
Future<void> GetGroupSignalRConnection() async {
  connection.on('GetGroup', (message) {
    print(message.toString());
  });
}*/
