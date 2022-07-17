import 'package:Nahvino/Utils/OtherUtils/rules.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static rules(context) =>
      showDialog(context: context, builder: (context) => RulesDialog());
}
