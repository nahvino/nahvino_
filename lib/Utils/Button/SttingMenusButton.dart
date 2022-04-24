import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SttingMenusButton extends StatelessWidget {
  SttingMenusButton({Key? key, required this.text, required this.onPressed, required this.icon, this.prefixIcon, this.suffixIcon, this.color})
      : super(key: key);

  VoidCallback onPressed;
  String text;
  final Widget icon;
  final Widget? color;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton(
        onPressed: onPressed,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        padding: EdgeInsets.all(0.0),
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
            constraints: BoxConstraints( minHeight: 50.0),
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
                  style: TextStyle(color: Colors.white, fontSize: 25 , fontFamily: 'byekan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}