import 'package:Nahvino/features/Chat/group/info_group/Widget/appbar.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
   InfoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: UIInfo(context),
    );
  }

  Widget UIInfo(BuildContext context) {
    return SafeArea(
      child: AppBarInfo()


    );
  }

}

