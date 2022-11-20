import 'package:Nahvino/config/typography.dart';
import 'package:flutter/material.dart';
class CustomTheme {
  // light
  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black)),
    textTheme: textTheme,
    //   const TextTheme(
    //     labelMedium: TextStyle(color: Colors.black),
    //     headlineLarge: TextStyle(color: Colors.black),
    //     bodyText1: TextStyle(color: Colors.black),
    // ),
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      disabledBorder: InputBorder.none,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(15))),
    ),
    hintColor: Colors.grey.shade200,
    hoverColor: Colors.white,
    errorColor: Colors.red,
    secondaryHeaderColor: Colors.black,
    backgroundColor: Colors.white,
    listTileTheme: const ListTileThemeData(
      textColor: Colors.black,
      iconColor: Colors.black,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  );

  // dark
  static final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white)),
    textTheme: textTheme,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.black,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      disabledBorder: InputBorder.none,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(15))),
    ),
    hintColor: Colors.grey,
    hoverColor: Colors.grey.shade900,
    errorColor: Colors.red,
    secondaryHeaderColor: Colors.white,
    backgroundColor: Colors.black,
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
      iconColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
/*
  //reDDark
  static final redDarkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.red,
        titleTextStyle: TextStyle(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white)),
    textTheme: textTheme,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.black54,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      disabledBorder: InputBorder.none,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(15))),
    ),
    primaryColor: PaletteDark.primaryColor,
    hintColor: Colors.grey,
    errorColor: Colors.red,
    secondaryHeaderColor: Colors.white,
    backgroundColor: Colors.black,
    listTileTheme: const ListTileThemeData(
      textColor: Colors.red,
      iconColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
*/
  //textTheme
  static final textTheme = TextTheme(
    headline1: MyTypography.headline1,
    headline2: MyTypography.headline2,
    headline3: MyTypography.headline3,
    headline4: MyTypography.headline4,
    headline5: MyTypography.headline5,
    headline6: MyTypography.headline6,
    subtitle1: MyTypography.subtitle1,
    subtitle2: MyTypography.subtitle2,
    bodyText1: MyTypography.bodyText1,
    bodyText2: MyTypography.bodyText2,
    button: MyTypography.button,
    caption: MyTypography.caption,
    overline: MyTypography.overline,
  );
}
