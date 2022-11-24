import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:flutter/material.dart';

class AppBarInfo extends StatelessWidget {
  // AppBarInfo({Key? key}) : super(key: key);
  String? imagegrup;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                backgroundColor: Colors.cyan.shade800,
            flexibleSpace: FlexibleSpaceBar(
        //    title: Text('Available seats'),
            background: Image.network(
            'https://png.pngtree.com/background/20211215/original/pngtree-background-biru-keren-dan-kosong-abstract-untuk-template-desain-ppt-picture-image_1456303.jpg',
            fit: BoxFit.fitWidth,
            ),
            ),
                actions: [

                  SizedBox(
                    width: 10,
                  ),
                ],
                title: Subhead(
                  text: "چت نحوینو",
                ),
                leadingWidth: 60,
                pinned: true,
                floating: true,
                bottom: TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                        child: Row(
                      children: [
                        Icon(Icons.group),
                        SizedBox(
                          width: 3,
                        ),
                        Text("مدیران")
                      ],
                    )),
                    Tab(
                        child: Row(
                      children: [
                        Icon(Icons.group),
                        SizedBox(
                          width: 3,
                        ),
                        Text("اعضا")
                      ],
                    )), Tab(
                        child: Row(
                      children: [
                        Icon(Icons.group),
                        SizedBox(
                          width: 3,
                        ),
                        Text("در خواست عضویت ")
                      ],
                    )),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              Text("data"),
              Text("data"),
              Text("data"),
            ],
          ),
        ),
      ),
    );
  }
}
