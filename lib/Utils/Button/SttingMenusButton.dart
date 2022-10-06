// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SttingMenusButton extends StatelessWidget {
  SttingMenusButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.icon,
      this.prefixIcon,
      this.suffixIcon,
      this.color})
      : super(key: key);

  VoidCallback onPressed;
  String text;
  final Widget icon;
  final Widget? color;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
     //   padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  radius: 0,
                  colors: [
                    Colors.cyan.shade800,
                    Colors.cyan.shade300,
                  ],
                  center: Alignment(0.0, 0.0)),
              borderRadius: BorderRadius.circular(0.0)),
          child: Container(
            constraints: BoxConstraints(minHeight: 50.0),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: icon,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 25, fontFamily: 'byekan'),
                ),
              ],
            ),
          ),
        ),

    );
  }
}

// ignore: must_be_immutable
class MenusSttingButton extends StatelessWidget {
  MenusSttingButton(
      {Key? key,
      this.text,
      this.onPressed,
      this.iconn,
      this.prefixIcon,
      this.suffixIcon,
      this.color})
      : super(key: key);

  VoidCallback? onPressed;
  String? text;
  Widget? iconn;
  Widget? color;
  Widget? prefixIcon;
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 60,
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Text(
              text!,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.black, fontSize: 25, fontFamily: 'byekan'),
            ),
          ],
        ),
      ),
    );
  }
}
