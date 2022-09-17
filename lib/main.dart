import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:Nahvino/my_tabs/main/screen/tabs.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:once/once.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'App_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'LanguageConstants.dart';
import 'Services/http.dart';
import 'splash.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
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
    });
    super.initState();
    //خروجی اپ ویندوز
    
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    // FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
        ),
      );
    } else {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        supportedLocales: [
          Locale('fa', 'IR'),
          Locale('en', 'US'),
        ],
        locale: _locale,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: Splash(),

        navigatorKey: navigatorKey,
        // initialRoute:Splash() ,
      );
    }
  }
}
