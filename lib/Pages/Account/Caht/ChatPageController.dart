import 'dart:async';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nahvino/Model/User/SignalR/GroupModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_core/signalr_core.dart';
import '../../../Model/User/SignalR/ReceiveMessageModel.dart';
import '../../../Services/config.dart';

class ChatPageController extends GetxController {
  RxBool emojiShowing = false.obs;
  TextEditingController chatEditController = TextEditingController();
  GroupModel? model;
  String myUserId = "";
  RxBool iconcaht = false.obs;
  FocusNode focusNode = FocusNode();
  RxBool canSend = true.obs;
  RxBool isInSearchMode = false.obs;
  RxBool isApiCallProgress = true.obs;
  RxString searchText = "".obs;

  @override
  void onInit() {
    super.onInit();
    _getMyData();
  }

  @override
  void dispose() {
    chatEditController.clear();
    super.dispose();
  }

  Future _getMyData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    myUserId = await preferences.getString("userId") ?? "";
    //myUserId="01d772d7-4a35-498e-9f24-5a27e5ef1438";
  }

  var url = Uri.parse(configss.baseURL + configss.repassword);
  final connection = HubConnectionBuilder()
      .withUrl(
          'https://api.faradeiazoapi.xyz/HubChatPartnership',
          //'https://tset.faradeiazoapi.xyz/HubChatPartnership',
          HttpConnectionOptions(
            logging: (level, message) => print(message),
          ))
      .build();
  Future<void> openSignalRConnection() async {
    await connection.start();
    connection.on('ReceiveMessage', (message) {
      print(message.toString());
      var res = message![0];
      ReceiveMessageModel? chatmodel;
      chatmodel = ReceiveMessageModel.fromJson(res);
      chats.add(chatmodel);
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
      print(messages.toString());
      for (var item in messages![0]) {
        ReceiveMessageModel? chatmodel;
        chatmodel = ReceiveMessageModel.fromJson(item);
        if (chats.where((element) => element.id == chatmodel!.id).length <= 0) {
          chats.add(chatmodel);
        }
      }
      //chats = chats.reversed.toList();
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
    String text = chatEditController.text;
    chatEditController.clear();
    var replay = MyRepledMessage == null ? null : MyRepledMessage!.id;
    MyRepledMessage = null;
    await connection.invoke(
      'SendMessage',
      args: [
        myUserId,
        replay,
        text,
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
}
