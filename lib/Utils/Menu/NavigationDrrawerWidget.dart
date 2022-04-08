import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget{
  final padding = EdgeInsets.symmetric(horizontal: 5);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.cyan.shade900,
        child: ListView(children: <Widget>[
          const SizedBox(height: 20,)
        ],)
      ),
    );
  }
}