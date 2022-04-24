import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'Pages/Account/User/ViewProfile.dart';
import 'Pages/Account/login/SignIn.dart';
import 'Pages/Home.dart';
import 'App_localizations.dart';
import 'splash.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      textDirection: TextDirection.rtl,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('fa', 'IR'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
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
      routes: {
        '/home': (context) => HomeScren(),
        '/login': (context) => SignIn(),
        '/viewprofile': (context) => ViewProfile()
      },
    );
  }
}
