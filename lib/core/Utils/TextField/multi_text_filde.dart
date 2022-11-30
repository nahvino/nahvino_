import 'package:flutter/material.dart';

class TextProfileBio extends StatelessWidget {
  const TextProfileBio({
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
    return Padding(
      padding: const EdgeInsets.only(right: 35,left: 39),
      child: TextFormField(
        maxLength: 110,
        maxLines: 3,
        minLines: 3,
        textAlign: TextAlign.right,
        controller: controller,
        keyboardType: TextInputType.multiline,
        style: TextStyle(fontSize: 14, fontFamily: 'Vazirmatn_Medium'),
        decoration: InputDecoration(

          hintText: hint,
          icon: icon,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}