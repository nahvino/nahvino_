import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:Nahvino/config/custom_theme.dart';
import 'package:Nahvino/core/shared/Services/http.dart';
import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/shared/presentation/controllers/getx/Utils/download_controller.dart';
import 'package:Nahvino/features/my_tabs/main/screen/tabs.dart';
import 'package:Nahvino/features/settings/menu/controllers/menu_controllers.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/shared/Services/notification_service.dart';
import 'core/shared/presentation/controllers/theme_get/theme_controller.dart';
import 'features/splash/screen/splash.dart';
import 'dart:async';
import 'firebase_options.dart';

/*
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  HttpOverrides.global = new MyHttpOverrides();
  await GetStorage.init();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await AndroidAlarmManager.initialize();
  runApp(MyApp());
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    print("Error From INSIDE FRAME_WORK");
    print("----------------------------");
    print("Error : ${details.exception}");
    print("StackTrace :${details.stack}");
  };
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MenuController menu_controller = Get.put(MenuController());
  ThemeController theme_controller = Get.put(ThemeController());
  DownloadController down_controller = Get.put(DownloadController());

  /*
  late int totalNotifications;
  String? tolll;
  String? messgaeTitle;
  String? notificationAlert = 'Alert';
  late SharedPreferences tak;
  final navigatorKey = GlobalKey<NavigatorState>();
  bool test = false;
  bool nots = false;

  Future<void> registerNotfition() async {
    //await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    String? fcntoken = await FirebaseMessaging.instance.getToken();
    tolll = fcntoken;
    final firebasetoken = await SharedPreferences.getInstance();
    await firebasetoken
      ..setString('firebasetoken', tolll.toString());
    print("-----------token------------->$fcntoken");
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings setings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
      carPlay: true,
      criticalAlert: false,
      announcement: false,
    );
    if (setings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        setState(() {
          messgaeTitle = message.data["title"];
          notificationAlert = message.data["body"];
        });
      });
    }

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   // if (message.data["notification"] == "screenA") {
    //   //   Navigator.pushAndRemoveUntil(
    //   //     context,
    //   //     MaterialPageRoute(builder: (context) => Chatpage()),
    //   //     (route) => false,
    //   //   );
    //   // }
    //   if (message.data['type'] == 'chat') {
    //     Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (context) => Chatpage()),
    //       (route) => false,
    //     );
    //   }
    //   setState(() {
    //     messgaeTitle = message.data["title"];
    //     notificationAlert = message.data['body'];
    //   });
    // });
  }
*/

  @override
  void initState() {
    /*
    totalNotifications = 0;
    registerNotfition();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("====================>$message");
      // Navigator.pushNamed(context, '/chat');
      // navigatorKey.currentState?.pushNamed('/tab', arguments: {'tabIndex': 1});
      navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (context) => MyTabs(
                tabIndex: 1,
              )));

      // printnavigatorKey.currentState?.pushNamed('/chat');
      setState(() {
        messgaeTitle = message.data["title"];
        notificationAlert = message.data['body'];
      });
    });*/
    super.initState();
    //خروجی اپ ویندوز
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ThemeController>(
      builder: (logic) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme_controller.switch_theme.value? CustomTheme.darkTheme : CustomTheme.lightTheme ,
          supportedLocales: [
            Locale('en', 'US'),
            Locale('fa', 'IR'),

          ],
          locale: Locale(menu_controller.box_menu.read('lang'), menu_controller.box_menu.read('langs')),

          //  locale:  Locale('fa', 'IR'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          // localeResolutionCallback: (locale, supportedLocales) {
          //   for (var supportedLocale in supportedLocales) {
          //     if (supportedLocale.languageCode == locale!.languageCode &&
          //         supportedLocale.countryCode == locale.countryCode) {
          //       return supportedLocale;
          //     }
          //   }
          //   return supportedLocales.first;
          // },
          home: Splash(),

          //   navigatorKey: navigatorKey,
          // initialRoute:Splash() ,
        );
      },
    );
  }
}
