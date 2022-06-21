import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnglishTextFilde extends StatefulWidget {
  const EnglishTextFilde(
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

  @override
  State<EnglishTextFilde> createState() => _EnglishTextFildeState();
}

class _EnglishTextFildeState extends State<EnglishTextFilde> {
  String? error;
  final alphanumeric = RegExp("[A-Z a-z 0-9]");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 35, left: 39),
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: widget.controller,
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.deny(
              RegExp(r'[آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهیئ]')),
        ],
        onChanged: (input) {
          if (alphanumeric.hasMatch(input) == false) {
            error = "نام کاربری نمی تواند فارسی باشد.";
          } else {
            error = null;
          }
          if ((input).isEmpty) {
            error = "نام کاربری نمی تواند خالی باشد.";
          }
          setState(() {});
        },
        style: TextStyle(fontSize: 16, fontFamily: 'Vazirmatn_Medium'),
        decoration: InputDecoration(
          hintText: widget.hint,
          errorText: error,
          icon: widget.icon,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}
