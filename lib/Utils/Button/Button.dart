// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../Text/Text.dart';

// ignore: must_be_immutable
class Buttontest extends StatelessWidget {
  Buttontest({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  VoidCallback onPressed;
  String text;

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      //  padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  radius: 5,
                  colors: [
                    Colors.cyan.shade300,
                    Colors.cyan.shade800,
                    Colors.cyan.shade900,
                  ],
                  center: Alignment(0.0, 0.11)),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 180.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontFamily: 'byekan'),
            ),
          ),
        ),
    );
  }
}

// ignore: must_be_immutable
class Buttonfull extends StatelessWidget {
  Buttonfull(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.color})
      : super(key: key);

  VoidCallback onPressed;
  String text;
  Color color;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: 58,
      width: width*2,
      child: FloatingActionButton(
          elevation: 0,
          onPressed: onPressed,
         // shape:
           //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          //padding: EdgeInsets.all(0.0),
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    //radius: 5,
                    colors: [
                      Colors.cyan.shade300,
                      Colors.cyan.shade800,
                      Colors.cyan.shade900,
                    ], end: Alignment(7.0, 6.0)),
                borderRadius: BorderRadius.circular(15.0)),
            child: Container(
                //padding: EdgeInsets.all(10.0),
              constraints: BoxConstraints(maxWidth: 380.0, minHeight: 180.0),
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: color, fontSize: 17, fontFamily: 'Vazirmatn_Light'),
              ),
            ),
          ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ButtonSignUP extends StatelessWidget {
  ButtonSignUP(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.icon,
      this.prefixIcon,
      this.suffixIcon,
      this.color})
      : super(key: key);

  VoidCallback onPressed;
  String text;
  final Widget? icon;
  final Widget? color;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
       // padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  //radius: 5,
                  colors: [
                    Colors.cyan.shade300,
                    Colors.cyan.shade800,
                    Colors.cyan.shade900,
                  ], end: Alignment(7.0, 6.0)),
              borderRadius: BorderRadius.circular(45.0)),
          child: Container(
            constraints: BoxConstraints(minHeight: 50.0 ,maxWidth: 380),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 30, alignment: Alignment.center, child: icon!),
                Container(
                  width: 250,
                  alignment: Alignment.center,
                  child: Callout(
                    textAlign: TextAlign.center,
                    text: text,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
