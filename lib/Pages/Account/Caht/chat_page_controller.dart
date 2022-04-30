import 'dart:async';
import 'dart:ffi';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:nahvino/Model/User/SignalR/GroupModel.dart';
import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_core/signalr_core.dart';

import '../../../Model/User/SignalR/ReceiveMessageModel.dart';


class ChatPageController extends GetxController{

  RxBool emojiShowing = false.obs;
  TextEditingController chatEditController = TextEditingController();
  GroupModel? model;


  String myUserId = "";
   int? id;
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



  Future<void> initializeService() async {
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will executed when app is in foreground or background in separated isolate
        onStart: onStartService,
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: true,

        // this will executed when app is in foreground in separated isolate
        onForeground: onStartService,

        // you have to enable background fetch capability on xcode project
        onBackground: onIosBackground,
      ),
    );
    service.startService();

    FlutterBackgroundService().invoke("setAsBackground");

  }

// to ensure this executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
  bool onIosBackground(ServiceInstance service) {
    WidgetsFlutterBinding.ensureInitialized();
    print('FLUTTER BACKGROUND FETCH');

    return true;
  }

  void onStartService(ServiceInstance service) {
    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });


    connection.on('ReceiveMessage', (message) {
      print("-----------------------------------------");
      print(message.toString());
      var res = message![0];
      ReceiveMessageModel? chatmodel;
      chatmodel = ReceiveMessageModel.fromJson(res);
      chats.add(chatmodel);
      update();
    });

    // // bring to foreground
    // Timer.periodic(const Duration(seconds: 1), (timer) async {
    //   if (service is AndroidServiceInstance) {
    //     service.setForegroundNotificationInfo(
    //       title: "My App Service",
    //       content: "Updated at ${DateTime.now()}",
    //     );
    //   }
    //
    //   /// you can see this log in logcat
    //   print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    //
    //   // test using external plugin
    //   final deviceInfo = DeviceInfoPlugin();
    //   String? device;
    //   if (Platform.isAndroid) {
    //     final androidInfo = await deviceInfo.androidInfo;
    //     device = androidInfo.model;
    //   }
    //
    //   if (Platform.isIOS) {
    //     final iosInfo = await deviceInfo.iosInfo;
    //     device = iosInfo.model;
    //   }
    //
    //   service.invoke(
    //     'update',
    //     {
    //       "current_date": DateTime.now().toIso8601String(),
    //       "device": device,
    //     },
    //   );
    // });
  }





  Future<void> openSignalRConnection() async {


    await initializeService();

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
    await connection.invoke('GetAllMessage');
   // await connection.invoke('DeleteMessage');


  //  await connection.invoke('SendMessage', args: [myUserId,60, 'خداحافظ']);
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