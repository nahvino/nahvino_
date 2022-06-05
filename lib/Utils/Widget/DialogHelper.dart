import 'package:flutter/material.dart';
import 'package:Nahvino/Utils/Other/rules.dart';

class DialogHelper {
  static rules(context) =>
      showDialog(context: context, builder: (context) => RulesDialog());
}
