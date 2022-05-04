import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'Pages/Account/User/ViewProfile.dart';
import 'Pages/Account/login/SignIn.dart';
import 'Pages/Home.dart';
import 'App_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash.dart';

import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

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


Future<void> main() async {

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



  runApp(MyApp());
}

class MyApp extends StatelessWidget {


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
      locale: Locale('fa', 'IR'),
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
      routes: {
        '/home': (context) => HomeScren(),
        '/login': (context) => SignIn(),
        '/viewprofile': (context) => ViewProfile()
      },
    );
  }
}
