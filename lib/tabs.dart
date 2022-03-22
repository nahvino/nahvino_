import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nahvino/Pages/home.dart';
import 'package:nahvino/app_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'Pages/settings.dart';
import 'app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyTabs extends StatefulWidget {
  const MyTabs({Key? key}) : super(key: key);
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.yellow.shade800, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.black,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: AppLocalizations.of(context)!.translate(
          'Home',
        ),
        textStyle: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'byekan'),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.text_badge_star),
        title: AppLocalizations.of(context)!.translate(
          'Blog',
        ),
        textStyle: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'byekan'),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.text_badge_star),
        title: AppLocalizations.of(context)!.translate(
          'Profile',
        ),
        textStyle: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'byekan'),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      HomeScren(),
      SettingScreen(),
    ];
  }
}
