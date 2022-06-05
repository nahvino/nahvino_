import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'App_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'LanguageConstants.dart';
import 'splash.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
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
void main() => runApp(MyApp());

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
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final FirebaseMessaging messaging;
  late int totalNotifications;

  String messgaeTitle = 'Empty';
  String notificationAlert = 'Alert';

  Future<void> registerNotfition() async {
    //await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    String? fcntoken = await FirebaseMessaging.instance.getToken();
    print("-----------token------------->$fcntoken");
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    NotificationSettings setings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (setings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        setState(() {
          messgaeTitle = message.data["title"];
          notificationAlert = message.data["body"];
        });
      });
    }
  }

  @override
  void initState() {
    totalNotifications = 0;
    registerNotfition();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      setState(() {
        messgaeTitle = message.data["title"];
        notificationAlert = message.data['body'];
      });
    });

    super.initState();
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
        // initialRoute:Splash() ,
      );
    }
  }
}
