import 'dart:async';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nahvino/Model/User/SignalR/GroupModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_core/signalr_core.dart';
import '../../../Model/User/SignalR/ReceiveMessageModel.dart';


class ChatPageController extends GetxController{

  RxBool emojiShowing = false.obs;
  TextEditingController chatEditController = TextEditingController();
  GroupModel? model;
  String myUserId = "";
  RxBool iconcaht = false.obs;
  FocusNode focusNode = FocusNode();
  RxBool  canSend = true.obs;
  RxBool isInSearchMode = false.obs;
  RxBool isApiCallProgress = false.obs;
  RxString searchText = "".obs;
  //final ScrollController _scrollController = ScrollController();
  @override
  void onInit(){
    super.onInit();
    _getMyData();
  }
  @override
  void dispose(){
    chatEditController.clear();
    super.dispose();
  }
  Future _getMyData() async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
    myUserId = await preferences.getString("userId") ?? "";
    //myUserId="01d772d7-4a35-498e-9f24-5a27e5ef1438";
  }

  final connection = HubConnectionBuilder()
      .withUrl(
      'https://api.nahvino.ir/HubChatPartnership',
      HttpConnectionOptions(
        logging: (level, message) => print(message),
      ))
      .build();

/*
    connection.on('ReceiveMessage', (message) {
      print("-----------------------------------------");
      print(message.toString());
      var res = message![0];
      ReceiveMessageModel? chatmodel;
      chatmodel = ReceiveMessageModel.fromJson(res);
      chats.add(chatmodel);
      update();
    });
*/

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
    // connection.invoke('GetGroup');
    connection.on('GetInfoGroup', (GroupDto) {
      print(GroupDto.toString());
      var res = GroupDto![0];
      model = GroupModel.fromJson(res);
      update();
    });
    connection.on('GetAllMessage', (messages) {
      print(messages.toString());
      for(var item in messages![0]){
        ReceiveMessageModel? chatmodel;
        chatmodel = ReceiveMessageModel.fromJson(item);
        chats.add(chatmodel);
      }
      chats.sort((a, b) => a.id!.compareTo(b.id!));
      loadMoreLoading.value = false;
      isApiCallProgress.value =false;
      update();
    });
    await connection.invoke('Group');
    getAllMessages();
  }

  int chatPageSize = 0;
  RxBool loadMoreLoading = false.obs;
  RxBool showScrollToEnd = false.obs;
  ScrollController chatScrollController = ScrollController();

  Future getAllMessages()async{
    if(loadMoreLoading.value){
      return;
    }
    chatPageSize++;
    loadMoreLoading.value = true;
    await connection.invoke('GetAllMessage',args: [chatPageSize,50]);
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
  sendMessage() async{
    if(chatEditController.text.isEmpty){
      return;
    }
    String text = chatEditController.text;
    chatEditController.clear();
    var replay = MyRepledMessage == null ? null : MyRepledMessage!.id;
    MyRepledMessage = null;
    await connection.invoke('SendMessage', args: [
      myUserId,
      replay,
      text,
    ],);
    chatScrollController.animateTo(chatScrollController.position.minScrollExtent, duration: Duration(seconds: 1), curve: Curves.ease);
  }
  void addToReply(ReceiveMessageModel chat) {
    MyRepledMessage = chat;
    update();
  }

  void DeleteMessage(ReceiveMessageModel chat) {
    connection.invoke('DeleteMessage', args: [chat.id],);
    connection.on('GetAllMessage', (messages) {
      print(messages.toString());
      for(var item in messages![0]){
        ReceiveMessageModel? chatmodel;
        chatmodel = ReceiveMessageModel.fromJson(item);
        chats.add(chatmodel);
      }
      update();
    });
    connection.invoke('GetAllMessage');
    //chats.remove(chat);
    update();
  }


  void removeMyReplyedMessage() {
    MyRepledMessage = null;
    update();
  }


  chaticon() {
    if(iconcaht.value){
      return Icon(Icons.emoji_emotions_outlined);
    }else{
      return Icon(Icons.keyboard);
    }
  }


  void scrollDown() {
    chatScrollController.animateTo(chatScrollController.position.minScrollExtent, duration: Duration(seconds: 1), curve: Curves.ease);
  }

}