import 'package:Nahvino/features/feature_my_tabs/main/controller/mytab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar_v2/motion-badge.widget.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

class MyTab extends StatelessWidget {
  MyTab({Key? key}) : super(key: key);
  MyTabController mytab_controller = Get.put(MyTabController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTabController>(
      builder: (logic) {
        return Scaffold(
          backgroundColor: Colors.grey,
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
            controller: mytab_controller.tabController,
            children: <Widget>[
              const Center(
                child: Text("Dashboard"),
              ),
              const Center(
                child: Text("Home"),
              ),
              const Center(
                child: Text("Profile"),
              ),
              const Center(
                child: Text("Settings"),
              ),
            ],
          ),
          bottomNavigationBar: MotionTabBar(
            initialSelectedTab: "Home",
            labels: const ["Dashboard", "Home", "Profile", "Settings"],
            icons: const [Icons.dashboard, Icons.home, Icons.people_alt, Icons.settings],

            // optional badges, length must be same with labels
            badges: [
              // Default Motion Badge Widget
              const MotionBadgeWidget(
                text: '99+',
                textColor: Colors.white, // optional, default to Colors.white
                color: Colors.red, // optional, default to Colors.red
                size: 18, // optional, default to 18
              ),

              // custom badge Widget
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(2),
                child: const Text(
                  '48',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),

              // allow null
              null,

              // Default Motion Badge Widget with indicator only
              const MotionBadgeWidget(
                isIndicator: true,
                color: Colors.red, // optional, default to Colors.red
                size: 5, // optional, default to 5,
                show: true, // true / false
              ),
            ],
            tabSize: 50,
            tabBarHeight: 55,
            textStyle: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            tabIconColor: Colors.blue[600],
            tabIconSize: 28.0,
            tabIconSelectedSize: 26.0,
            tabSelectedColor: Colors.blue[900],
            tabIconSelectedColor: Colors.white,
            tabBarColor: const Color(0xFFAFAFAF),
            onTabItemSelected: (int value) {

              mytab_controller.tabController!.index = value;

            },
          ),
        );
      },
    );
  }
}
