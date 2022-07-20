import 'package:Nahvino/Pages/Caht/chat_page.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nahvino/App_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'Pages/Account/User/view_profile.dart';
import 'App_localizations.dart';

class MyTabs extends StatefulWidget {
  const MyTabs({Key? key, this.tabIndex}) : super(key: key);
  final int? tabIndex;
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  late PersistentTabController _controller;
  //ChatPageController chatPageController = Get.put(ChatPageController());

  @override
  void initState() {
    super.initState();
    //chatPageController.openSignalRConnection();
    _controller = PersistentTabController(initialIndex: widget.tabIndex ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.cyan.shade800,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(2.0),
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
          NavBarStyle.style14, // Choose the nav bar style with this property.
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      // PersistentBottomNavBarItem(
      //   title: AppLocalizations.of(context)!.translate(
      //     'Home',
      //   ),
      //   iconSize: 20,
      //   icon: Icon(CupertinoIcons.home),
      //   textStyle: TextStyle(fontSize: 12, fontFamily: 'Vazirmatn_Light'),
      //   activeColorPrimary: CupertinoColors.white,
      //   inactiveColorPrimary: CupertinoColors.white,
      // ),

      /*  PersistentBottomNavBarItem(
        title: AppLocalizations.of(context)!.translate(
          'Blog',
        ),
        iconSize: 20,
        icon: Icon(CupertinoIcons.text_badge_star),
        textStyle: TextStyle(fontSize: 12, fontFamily: 'Vazirmatn_Light'),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),*/
      PersistentBottomNavBarItem(
        title: AppLocalizations.of(context)!.translate(
          'Profile',
        ),
        iconSize: 20,
        icon: Icon(CupertinoIcons.person),
        textStyle: TextStyle(fontSize: 12, fontFamily: 'Vazirmatn_Light'),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        title: AppLocalizations.of(context)!.translate(
          'Chat',
        ),
        iconSize: 20,
        icon: Icon(CupertinoIcons.chat_bubble),
        textStyle: TextStyle(fontSize: 12, fontFamily: 'Vazirmatn_Light'),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      //HomeScren(),
      // SettingScreen(),
      ViewProfile(),
      Chatpage(),
    ];
  }
}
