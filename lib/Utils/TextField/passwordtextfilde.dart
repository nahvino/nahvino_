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
    final alphanumeric = RegExp("[A-Z a-z 0-9]");

    return Padding(
      padding: const EdgeInsets.only(right: 35, left: 39),
      child: TextFormField(
        textDirection: TextDirection.ltr,
        controller: controller,
        obscureText: passwordInVisible,
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value!.isEmpty) {
            return 'رمز عبور نمی تواند خالی باشد';
          }
          if (alphanumeric.hasMatch(value) == false) {
            return "رمز عبور نمی تواند فارسی باشد.";
          }
          return null;
        },
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
