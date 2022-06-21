import 'package:Nahvino/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'App_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'LanguageConstants.dart';
import 'Pages/Account/Caht/ChatPage.dart';
import 'Pages/Account/Caht/ChatPageController.dart';
import 'Services/Login/ApiService.dart';
import 'controllers/getx/aboutgroupcontroller.dart';
import 'splash.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  AboutGroupController notiController = Get.put(AboutGroupController());
  notiController.notfi.value = true;
}

/*
/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

*/
/*Future<void> main() async {
/*
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  FirebaseMessaging.instance.getToken().then((value) => print("firebase token => $value"));

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    print('Message notification title: ${message.notification?.title ?? "empty"}');
    print('Message notification body: ${message.notification?.body ?? "empty body"}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }

    Map<String,dynamic> data = message.data;

    print(data);
  });


//   $headers = array
//     (
//       'Authorization:key=' . 'secret',
//       'Content-Type: application/json'
//   );

  //url https://fcm.googleapis.com/fcm/send

  //
  // $fields = array
  //   (
  //     'registration_ids' => $listTokens,
  //     'data' => $data,
  //     "notification" => [
  //     "title" => "Check this Mobile (title)",
  //     "body" => "Rich Notification testing (body)",
  //     "mutable_content" => true,
  //     "sound" => "Tri-tone"
  //     ]
  // );

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
*/

  runApp(MyApp());
}*/
void main() async {
  // await GetStorage.init();

  runApp(MyApp());
}

/*
class MyApp extends StatelessWidget {
  late Locale _locale;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('fa', 'IR'),
      ],
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],/*
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },*/
      home: Splash(),
    );
  }
}
*/
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
  late APIService apiService;
  String? tolll;
  String? messgaeTitle;
  String notificationAlert = 'Alert';
  late SharedPreferences tak;
  final navigatorKey = GlobalKey<NavigatorState>();
  bool test = false;
  bool nots = false;
  ChatPageController chatPageController = Get.put(ChatPageController());
  AboutGroupController notiController = Get.put(AboutGroupController());

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
        notiController.notfi.value = true;
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

  @override
  void initState() {
    totalNotifications = 0;
    registerNotfition();
    chatPageController.openSignalRConnection();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("====================>$message");
      // Navigator.pushNamed(context, '/chat');
      // navigatorKey.currentState?.pushNamed('/tab', arguments: {'tabIndex': 1});
      notiController.notfi.value = true;
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
    if (messgaeTitle != null) {
      notiController.notfi.value = true;
    }
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
        initialRoute: '/',
        navigatorKey: navigatorKey,
        routes: {
          '/chat': (context) => Chatpage(),
          '/tab': (context) => MyTabs(),
        },
        // initialRoute:Splash() ,
      );
    }
  }
}
