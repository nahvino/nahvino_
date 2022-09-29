import 'dart:io';

import 'package:flutter/material.dart';
class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key , required this.img}) : super(key: key);
  final String img;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _build(context),
    );
  }
  Widget _build (BuildContext context){
    return SafeArea(child: 
        Column (children: [
         Image.file(File(img))
        ],)
    );
  }
}
