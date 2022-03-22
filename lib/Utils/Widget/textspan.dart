import 'package:flutter/material.dart';

TextSpan textSpan({
    required String label,
    Color color = Colors.black87,
    required String data,
  }) {
    return TextSpan(
        text: label,
        style: TextStyle(
            color: color,
            fontSize: 18,
            fontFamily: 'vazir',
            fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: data,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          )
        ]);
  }