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
  @override
  void onInit(){
    super.onInit();
    _getMyData();
    //mylist = chats.length => List.generate(50, (index) => "Item: ${i + 1}");
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
      update();
    });
    await connection.invoke('Group');
    //await connection.invoke('GetAllMessage');
    await connection.invoke('GetAllMessage',args: [1,100]);
   // await connection.invoke('DeleteMessage');
  //  await connection.invoke('SendMessage', args: [myUserId,60, 'خداحافظ']);
  }


  List<ReceiveMessageModel> chats = [];

  //var reversedList =new List.from(chats.reversed);


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
  sendMessage(){
    if(chatEditController.text.isEmpty){
      return;
    }

    connection.invoke('SendMessage', args: [
    /*  {
        "UserId" : myUserId,
        "ParentMessageId" : 60 ,
        //MyRepledMessage == null ? null : MyRepledMessage!.UserId,
        "Message" : chatEditController.text,
      }*/
      myUserId,
      MyRepledMessage == null ? null : MyRepledMessage!.id,
      chatEditController.text,
    ],);
    MyRepledMessage = null;
    chatEditController.clear();
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

}