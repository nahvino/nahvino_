import 'package:flutter/material.dart';

class EnglishTextFilde extends StatelessWidget {
   EnglishTextFilde(
      {Key? key,
      this.hint,
      this.controller,
      this.icon,
      this.prefixIcon,
      this.suffixIcon,
      this.errorttext})
      : super(key: key);

  final String? hint;
  final TextEditingController? controller;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorttext;

  String? error;
  final alphanumeric = RegExp("[A-Z a-z 0-9]");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 35, left: 39),
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: controller,
        keyboardType: TextInputType.text,
        /*     inputFormatters: [
          FilteringTextInputFormatter.deny(
              RegExp(r'[آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهیئ]')),
        ],*/
 /*       onChanged: (input) {
          if (alphanumeric.hasMatch(input) == false) {
            error = "نام کاربری نمی تواند فارسی باشد.";
          } else {
            error = null;
          }
          if ((input).isEmpty) {
            error = "نام کاربری نمی تواند خالی باشد.";
          }
        },*/
         validator: (value) {
          if (value!.isEmpty) {
            return 'مقدار نمی تواند خالی باشد';
          }
          if (alphanumeric.hasMatch(value) == false) {
            return "نام کاربری نمی تواند فارسی باشد.";
          }
          return null;
        },
        style: TextStyle(fontSize: 16, fontFamily: 'Vazirmatn_Medium'),
        decoration: InputDecoration(
          hintText: hint,
          errorText: error,
          icon: icon,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
