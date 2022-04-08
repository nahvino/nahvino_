
import 'package:flutter/material.dart';
import '../../app_localizations.dart';

TextSpan textsall({
  required String label,
  Color color = Colors.black87,
  required BuildContext context,
}) {
  return TextSpan(
    text:  AppLocalizations.of(context)!.translate(label)!,
    style: TextStyle(
        color: color,
        fontSize: 14, fontFamily: 'byekan'),
  );
}
