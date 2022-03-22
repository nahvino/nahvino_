import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nahvino/Pages/Account/login/Login.dart';
import 'package:nahvino/Pages/home.dart';
import 'package:nahvino/app_localizations.dart';
import 'package:provider/provider.dart';
import 'Services/login/google/google_sign_in.dart';
import 'app_localizations.dart';
import 'splash.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ChangeNotifier())
        ],
        child: MaterialApp(
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
            '/login': (context) => SignIn()
          },
        ));
  }
}
