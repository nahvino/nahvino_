import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class EnglishTextFilde extends StatelessWidget {
  EnglishTextFilde(
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
        //textAlign: TextAlign.left,
        controller: controller,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          if (value!.isEmpty) {
            return 'نام کاربری نمی تواند خالی باشد';
          } else if (value.length < 3) {
            return 'نام کاربری نمی تواند از 3 کاراکتر کمتر باشد';
          } else if (alphanumeric.hasMatch(value) == false) {
            return "نام کاربری نمی تواند فارسی و حرف بزرگ باشد.";
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
            Iconsax.user,
            color: Colors.cyan,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
