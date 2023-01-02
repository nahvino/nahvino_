import 'package:flutter/material.dart';

class BorderTextFilde extends StatelessWidget {
  const BorderTextFilde({
    Key? key,
    this.hint,
    this.controller,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);

  final String? hint;
  final TextEditingController? controller;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator? validator;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return TextFormField(
      maxLines: 3,
      minLines: 3,
      textAlign: TextAlign.right,
      maxLength: 255,
      controller: controller,
      keyboardType: TextInputType.multiline,
      style: TextStyle(fontSize: 14, fontFamily: 'Vazirmatn_Medium',color: theme.secondaryHeaderColor,),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hint,
        icon: icon,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
