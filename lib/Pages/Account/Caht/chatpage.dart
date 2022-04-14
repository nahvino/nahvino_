import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nahvino/Pages/Account/Caht/removeMessageExtraChar.dart';
import 'package:signalr_core/signalr_core.dart';
import 'chatTypeMessageWidget.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({Key? key}) : super(key: key);

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  var mess="";
  @override
  void initState() {
    super.initState();
    openSignalRConnection();
    // GetGroupSignalRConnection();
    //createRandomId();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Text("متن پیام:$mess",),);
  }
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

  final connection = HubConnectionBuilder()
      .withUrl(
      'https://api.nahvino.ir/HubChatPartnership',
      HttpConnectionOptions(
        logging: (level, message) => print(message),
      ))
      .build();

  //connect to signalR
  Future<void> openSignalRConnection() async {
    await connection.start();
    connection.on('ReceiveMessage', (message) {
      print(message.toString());
      var mess= message.toString();
    });
   // connection.invoke('GetGroup');
    connection.on('GetGroup', (message) {
      print(message.toString());
      var mess= message.toString();
    });
    await connection.invoke('SendMessage', args: ['6', 'خداحافظ']);
    await connection.invoke('GetGroup',args: ['1', 'nvdhtj']);


  }

/*
Future<void> GetGroupSignalRConnection() async {
  connection.on('GetGroup', (message) {
    print(message.toString());
  });
}*/


