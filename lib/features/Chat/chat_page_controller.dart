import 'dart:async';
import 'package:Nahvino/features/Chat/config/chat_config.dart';
import 'package:Nahvino/features/Chat/model/SignalR/GroupModel.dart';
import 'package:Nahvino/features/Chat/model/SignalR/ReceiveMessageModel.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_core/signalr_core.dart';

class ChatPageController extends GetxController {
  RxBool emojiShowing = false.obs;
  TextEditingController chatEditController = TextEditingController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  GroupModel? model;
  String? myUserId;
  String? token;
  RxBool iconcaht = false.obs;
  FocusNode focusNode = FocusNode();
  RxBool canSend = true.obs;
  RxBool isInSearchMode = false.obs;
  RxBool isApiCallProgress = true.obs;
  RxString searchText = "".obs;
  RxString disconnected = "".obs;

  @override
  void onInit() {
    super.onInit();
    _getMyData();
   // dicreconnection();
    //openSignalRConnection();
  }

  @override
  void dispose() {
    chatEditController.clear();
    super.dispose();
  }

  Future _getMyData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    myUserId = await preferences.getString("userId");
  }

  //conntian
  final connection = HubConnectionBuilder()
      .withUrl(
        ChatConfig.mainurl,
        HttpConnectionOptions(
          logging: (level, message) => print(message),
        ),
      )
      .withAutomaticReconnect()
      .build();
  Future<void> openSignalRConnection() async {
    await connection.start();
    connection.on('ReceiveMessage', (message) {
      print("===========>ReceiveMessage<==============");
      print(message.toString());
      var res = message![0];
      ReceiveMessageModel? chatmodel;
      chatmodel = ReceiveMessageModel.fromJson(res);
      if (chats.where((element) => element.id == chatmodel!.id).length <= 0) {
        chats.add(chatmodel);
      }
      //chats.add(chatmodel);
      update();
    });
    connection.on('GetInfoGroup', (GroupDto) {
      print(GroupDto.toString());
      var res = GroupDto![0];
      model = GroupModel.fromJson(res);
      update();
    });
    connection.on('ReceiveDeleteMessage', (messageIds) {
      print('chat id is:' + messageIds.toString());
      chats.removeWhere((chat) => messageIds!.contains(chat.id));
      update();
    });

    connection.on('GetAllMessage', (messages) {
      print("===========>GetAllMessage<==============");
      print(messages.toString());
      for (var item in messages![0]) {
        ReceiveMessageModel? chatmodel;
        chatmodel = ReceiveMessageModel.fromJson(item);
        if (chats.where((element) => element.id == chatmodel!.id).length <= 0) {
          chats.add(chatmodel);
        }
      }
      chats.sort((a, b) => a.id.compareTo(b.id));
      loadMoreLoading.value = false;
      //Future.delayed(Duration(seconds: 3), () => isApiCallProgress.value = false);
      update();
    });
    await connection.invoke('Group');
    getAllMessages();
  }

  int chatPageSize = 0;
  RxBool loadMoreLoading = false.obs;
  RxBool showScrollToEnd = false.obs;
  ScrollController chatScrollController = ScrollController();
  ScrollController chatSingleChildScrollController = ScrollController();
  Future getAllMessages() async {
    if (loadMoreLoading.value) {
      return;
    }
    chatPageSize++;
    loadMoreLoading.value = true;
    await connection.invoke('GetAllMessage', args: [chatPageSize, 50]);
  }

  List<ReceiveMessageModel> chats = [];

  onEmojiSelected(Emoji emoji) {
    chatEditController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: chatEditController.text.length));
  }

  onBackspacePressed() {
    chatEditController
      ..text = chatEditController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: chatEditController.text.length));
  }

  ReceiveMessageModel? MyRepledMessage;

/*UserId ParentMessageId  Message */
  sendMessage() async {
    if (chatEditController.text.isEmpty) {
      return;
    }
    String chatext;
    String text = chatEditController.text;
    chatext = text.replaceAll(RegExp(r'[\n][\n]'), '\n');
    print("/******/$chatext");
    chatEditController.clear();
    var replay = MyRepledMessage == null ? null : MyRepledMessage!.id;
    MyRepledMessage = null;
    await connection.invoke(
      'SendMessage',
      args: [
        myUserId,
        replay,
        chatext,
      ],
    );
    /* chatScrollController.animateTo(
        chatScrollController.position.minScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.ease);*/
    scrollDown();
  }

  void addToReply(ReceiveMessageModel chat) {
    MyRepledMessage = chat;
    update();
  }

  void DeleteMessage(ReceiveMessageModel chat) async {
    connection.invoke(
      'DeleteMessage',
      args: [chat.id],
    );
    // chats.remove(chat.id);
    //chats.clear();
    update();
  }

  void removeMyReplyedMessage() {
    MyRepledMessage = null;
    update();
  }

  chaticon() {
    if (iconcaht.value) {
      return Icon(Icons.emoji_emotions_outlined);
    } else {
      return Icon(Icons.keyboard);
    }
  }

  void scrollDown() {
    chatSingleChildScrollController.animateTo(
        chatSingleChildScrollController.position.minScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.ease);
  }

  void scrollToChat(ReceiveMessageModel chat) {
    int index = chats.lastIndexWhere((element) =>
        element.text == chat.parentMessageText &&
        element.userNameAlias == chat.parentMessageUserNameAlias);

    if (index != -1) {}
  }
  scrolltointhechat(ReceiveMessageModel chat){
    // chats.removeWhere((chat) => messageIds!.contains(chat.id));
    // update();
    itemScrollController.scrollTo(index: chats.indexWhere((element) => element.id == chat.id),
        duration: Duration(seconds: 1)
    );
    //itemScrollController.scrollTo(index: 50, duration: Duration(seconds: 1));

    update();

  }
  dicreconnection() {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      if (connection.state == HubConnectionState.connected) {
        print("I am Alive!");
        //openSignalRConnection();
        disconnected = "".obs;
        //await connection.stop();
        update();
      } else {
        openSignalRConnection();

        print("I am dc!");
        disconnected = "اتصال قطع است".obs;
        //await connection.start();
        update();
      }
    });
    update();
  }
}
