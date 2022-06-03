import 'package:flutter/material.dart';

class TextPassReAndLog extends StatelessWidget {
  const TextPassReAndLog(
      {Key? key,
        required this.hint,
        required this.controller,
        required this.icon,
        this.prefixIcon,
        this.suffixIcon,
        this.passwordInVisible = true,
        this.suffix})
      : super(key: key);

  final String hint;
  final TextEditingController controller;
  final Widget icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool passwordInVisible;
  final Widget? suffix;
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(right: 20, left: 40),
        child: TextFormField(
          textDirection:TextDirection.ltr ,
          controller: controller,
          obscureText: passwordInVisible,
          keyboardType: TextInputType.visiblePassword,
          style: TextStyle(fontSize: 14, fontFamily: 'Vazirmatn_Medium'),
          decoration: InputDecoration(
              hintText: hint,
              suffix: suffix,
              icon: icon,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              )),
        ),
      );
  }
}