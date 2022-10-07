import 'dart:math';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/double_back_content.dart';
import 'package:Nahvino/features/Chat/chat_page_controller.dart';
import 'package:Nahvino/features/my_tabs/tabs/chat/screen/chat_tab.dart';
import 'package:Nahvino/features/my_tabs/tabs/chats/screen/chats_tab.dart';
import 'package:Nahvino/features/my_tabs/tabs/developer/screen/developer_tab.dart';
import 'package:Nahvino/features/my_tabs/tabs/profile/screen/profile_tab.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nahvino/App_localizations.dart';
import 'package:once/once.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MyTabs extends StatefulWidget {
  const MyTabs({Key? key, this.tabIndex}) : super(key: key);
  final int? tabIndex;
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  late PersistentTabController _controller;
  ChatPageController chatPageController = Get.put(ChatPageController());
  String currentValue = 'Hello World';

  @override
  void initState() {
    super.initState();
    chatPageController.openSignalRConnection();
    _controller = PersistentTabController(initialIndex: widget.tabIndex ?? 0);
    Once.runOnce(
      'my-app-widget',
      callback: () => set('Once Started'),
    );
    Once.runOnEveryNewVersion(
      callback: () {
        /* What's new in 2.3.2 version? dialog */
        Get.defaultDialog(
          title: "قابلیت های جدید نحوینو",
          titleStyle: TextStyle(
              color: Colors.black, fontSize: 16, fontFamily: 'Vazirmatn_Light'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Caption1(
                text: "- با کشیدن پیام به سمت چپ ریپلای زده میشه ",
              ),
              Caption1(
                text: "- با کشیدن پیام به سمت راست ، متن پیام کپی میشه",
              ),
              Caption1(
                text: "- بالا رفتن سرعت ارسال پیام ",
              ),
              Caption1(
                text:
                    "- اضافه شدن قابلیت ریپورت پیام ها جهت حفظ حرمت در گروه ها",
              ),
              Caption1(
                text: "- اضافه شدن قابلیت اپدیت",
              ),
              SizedBox(
                height: 20,
              ),
              Buttonfull(
                text: "بزن بریم",
                color: Colors.white,
                onPressed: (() {
                  Navigator.of(context, rootNavigator: true).pop();
                }),
              )
            ],
          ),
        );
      },
      fallback: () {
        /* Navigate to new screen */
        //SystemNavigator.pop();
      },
    );
    super.initState();
  }

  void set(String newOnce) {
    setState(
      () {
        currentValue = newOnce + ' ${Random().nextInt(100)}';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      onFirstBackPress: (context) {
        var snackBar = SnackBar(
            elevation: 0,
            padding: EdgeInsets.all(10),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: DoubleBackContent());

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: PersistentTabView(
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
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
       PersistentBottomNavBarItem(
        title: "توسعه",
        iconSize: 20,
        icon: Icon(CupertinoIcons.infinite),
        textStyle: TextStyle(fontSize: 12, fontFamily: 'Vazirmatn_Light'),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
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
        title: "چت",
        iconSize: 20,
        icon: Icon(CupertinoIcons.chat_bubble),
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
      DeveloperTab(),
      ProfileTab(),
      ChatsTab(),
      ChatTab(),
    ];
  }
}
