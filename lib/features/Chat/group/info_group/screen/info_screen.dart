import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/Chat/group/Widget/public_group_widget.dart';
import 'package:Nahvino/features/Chat/group/info_group/Widget/appbar_group_widget.dart';
import 'package:Nahvino/features/Chat/group/info_group/Widget/details_group_widget.dart';
import 'package:Nahvino/features/Chat/group/info_group/Widget/members_list_group_widget.dart';
import 'package:Nahvino/features/Chat/group/info_group/Widget/membership_request_group_widget.dart';
import 'package:Nahvino/features/Chat/group/info_group/Widget/notification_group_widget.dart';
import 'package:Nahvino/features/Chat/group/info_group/controllers/info_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class InfoScreenGroup extends StatelessWidget {
  InfoScreenGroup({Key? key}) : super(key: key);

  InfoGroupController info_group_controller = Get.put(InfoGroupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: UIInfo(context),
    );
  }

  Widget UIInfo(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[AppBarInfo()];
          },
          body: SingleChildScrollView(
            child: Column(children: [
              DetailsGroupWidget(),
              SizedBox(
                height: 10,
              ),
              NotificationGroupWidget(),
              SizedBox(
                height: 10,
              ),
              Container(
                width: width,
                height: 51,
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50,
                    borderRadius: BorderRadius.circular(40)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                    ),
                    // controller: _tabController,
                    labelColor: Colors.black,
                    tabs: <Widget>[
                      SizedBox(
                        width: width * 0.42,
                        child: Tab(
                          text: AppLocalizations.of(context)!.translate(
                            'Members',
                          )!,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.40,
                        child: Tab(
                          text: AppLocalizations.of(context)!.translate(
                            'Membership_request',
                          )!,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height,
                child: TabBarView(
                  children: [MembersList(), MembershipRequestList()],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
