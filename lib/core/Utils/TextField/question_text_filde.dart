import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class QuestionTextFilde extends StatelessWidget {
  QuestionTextFilde(
      {Key? key,
      this.hint,
      this.controller,
      this.icon,
      this.prefixIcon,
      this.suffixIcon,
      this.errorttext,
      this.suffix})
      : super(key: key);

  final String? hint;
  final TextEditingController? controller;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorttext;
  final Widget? suffix;

  String? error;
  String? s;
  final alphanumeric = RegExp("[a-z 0-9]");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 39, left: 39),
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: controller,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.none,
        // autofocus: true,
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
            return 'سوال امنیتی نمی تواند خالی باشد';
          } else if (value.length < 3) {
            return 'سوال امنیتی نمی تواند از 3 کاراکتر کمتر باشد';
          } else if (alphanumeric.hasMatch(value) == false) {
            return "سوال امنیتی نمی تواند فارسی و حرف بزرگ باشد.";
          }

          return null;
        },
        style: TextStyle(fontSize: 14, fontFamily: 'Vazirmatn_Medium'),
        decoration: InputDecoration(
            hintText: hint,
            suffix: suffix,
            errorText: error,
            icon: icon,
            prefixIcon:  Icon(
              Iconsax.security,
            color: Colors.cyan,
            ),
            suffixIcon: suffixIcon,
            // border: UnderlineInputBorder(
            //   borderRadius: BorderRadius.circular(0),
            // )
    ),
      ),
    );
  }
}
