import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:flutter/material.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Caption1(
            text: "مرام نامه",
          ),
          backgroundColor: Colors.cyan.shade800),
      body: SafeArea(child: Text("")),
    );
  }
}
