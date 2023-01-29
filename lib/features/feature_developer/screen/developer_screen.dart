import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/error/screen/report_screen.dart';
import 'package:Nahvino/core/shared/Services/notification_service.dart';
import 'package:Nahvino/features/feature_chat/group/chat_group/widget/requset_group_widght.dart';
import 'package:Nahvino/features/feature_profile/view_profile/controllers/user_abandon_controller.dart';
import 'package:Nahvino/features/feature_settings/menu/controllers/menu_controllers.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class DeveloperScreen extends StatelessWidget {
  DeveloperScreen({Key? key}) : super(key: key);
  MenuController menu_controller = Get.put(MenuController());
  UserAbandonController un = Get.put(UserAbandonController());
  final GlobalKey _key = GlobalKey();
  String? token;
  String? id;
  String? fileName;

  static void printHello() {
    final DateTime now = DateTime.now();
    final int isolateId = Isolate.current.hashCode;
    print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _key,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Buttonfull(
              text: "آیدی",
              color: Colors.white,
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                Clipboard.setData(
                    ClipboardData(text: await preferences.getString("userId")));
                id = await preferences.getString("userId");
                Get.snackbar("کپی شد", id!);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Buttonfull(
              text: "توکن",
              color: Colors.white,
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                Clipboard.setData(
                    ClipboardData(text: await preferences.getString("token")));
                token = await preferences.getString("token");
                Get.snackbar("کپی شد", token!);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Buttonfull(
              text: "گزارش",
              color: Colors.white,
              onPressed: () async {
                RenderRepaintBoundary boundary = _key.currentContext!
                    .findRenderObject() as RenderRepaintBoundary;
                ui.Image image = await boundary.toImage();
                ByteData? byteData =
                    await image.toByteData(format: ui.ImageByteFormat.png);
                Uint8List pngBytes = byteData!.buffer.asUint8List();
                //String base64Image = base64.encode(pngBytes);
                final directory = (await getExternalStorageDirectory())?.path;
                File imgFile = new File('$directory/screenshot.png');
                imgFile.writeAsBytes(pngBytes);
                print("$directory/screenshot.png");
                Get.to(ReportScreen(img: "$directory/screenshot.png"));
              },
            ),
            SizedBox(
              height: 10,
            ),
            Buttonfull(
              text: "ای پی",
              color: Colors.white,
              onPressed: () async {
                final ipv4 = await Ipify.ipv4();
                print(ipv4); // 98.207.254.136

                final ipv6 = await Ipify.ipv64();
                print(ipv6); // 98.207.254.136 or 2a00:1450:400f:80d::200e

                final ipv4json = await Ipify.ipv64(format: Format.JSON);
                print(
                    ipv4json); //{"ip":"98.207.254.136"} or {"ip":"2a00:1450:400f:80d::200e"}

                // The response type can be text, json or jsonp
                Get.snackbar("کپی شد", ipv4);
              },
            ),
            SizedBox(
              height: 10,
            ),

            ///تست نوتیف
            Buttonfull(
              text: "نوتیف",
              color: Colors.white,
              onPressed: () async {
                // final int helloAlarmID = 0;
                // await AndroidAlarmManager.periodic(
                //     const Duration(minutes: 1), helloAlarmID, printHello);
                Timer(Duration(seconds: 10), () {
                  print("Yeah, this line is printed after 3 seconds");
                  NotificationService().showNotifications();
                });
                print("OK");
              },
            ),
            SizedBox(
              height: 10,
            ), Buttonfull(
              text: "درخوسات",
              color: Colors.white,
              onPressed: () async {
    showModalBottomSheet(
    isScrollControlled: true,
    //backgroundColor: theme.backgroundColor,
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
    ),
    ),
    context: context,
    builder: (context) => RequsetGroupWidget());

              },
            ),
            SizedBox(
              height: 10,
            ),

            ///تست نوتیف
            Buttonfull(
              text: "پینگ",
              color: Colors.white,
              onPressed: () async {
                // Create ping object with desired args
                Socket.connect("185.8.175.198", 2000, timeout: Duration(seconds: 5)).then((socket){
                  print("Success");
                  socket.destroy();
                }).catchError((error){
                  print("Exception on Socket "+error.toString());
                });
                final ping = Ping('185.8.175.198', count: 5);
                // Begin ping process and listen for output
                print('Running command: ${ping.command}');
                ping.stream.listen((event) {
                  print("ping: $event");
                });


              },
            ),
          ],
        ),
      ),
    );
  }
}