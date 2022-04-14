
import 'package:flutter/material.dart';
import '../../app_localizations.dart';

TextSpan textsall(String text, {
  required String label,
  Color color = Colors.black87,
  required BuildContext context,
}) {
  return TextSpan(
    text:  text,
    style: TextStyle(
        color: color,
        fontSize: 14, fontFamily: 'vazirlight'),
  );
}


class textspan extends StatelessWidget{
  textspan({ required this.text , required this.color, required TextAlign textAlign});
   String text;
   Color color;
  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(
        color: color,
        fontSize: 16, fontFamily: 'vazirlight'),);
  }


}

class textbold extends StatelessWidget{
  textbold({ required this.text , required this.color, required TextAlign textAlign});
  String text;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
          color: color,
          fontSize: 18, fontFamily: 'vazirlight'),);
  }


}