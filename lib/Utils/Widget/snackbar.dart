import 'package:flutter/material.dart';

showSnackBar({required BuildContext context,required String text,required Color color}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      action: SnackBarAction(
        label: 'بستن',
        onPressed: () {},
        textColor: Color(0xFF5D0A0A),
      ),
      content: Text(
        text,
        style: TextStyle(fontFamily: 'vazir', fontSize: 18),
      )));
}
