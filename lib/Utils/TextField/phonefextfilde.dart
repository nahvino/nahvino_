import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextOtpPhone extends StatelessWidget {
  const TextOtpPhone({
    Key? key,
    this.hint,
    this.controller,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.inputFormatters,
  }) : super(key: key);

  final String? hint;
  final TextEditingController? controller;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    RegExp regex = new RegExp(r"^(\+98|0)?9\d{9}$");
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: TextFormField(
        maxLength: 11,
        textAlign: TextAlign.left,
        controller: controller,
        keyboardType: TextInputType.phone,
        validator: (value) {
          /*  if (value!.isEmpty) {
            return "شماره تلفن نباید خالی باشد.";
          }
          /*   if (value.startsWith("1")) {
            return "شماره تلفن معتبر نمی باشد";
          } else if (value.startsWith("2")) {
            return "شماره تلفن معتبر نمی باشد";
          } else if (value.startsWith("3")) {
            return "شماره تلفن معتبر نمی باشد";
          } else if (value.startsWith("4")) {
            return "شماره تلفن معتبر نمی باشد";
          } else if (value.startsWith("5")) {
            return "شماره تلفن معتبر نمی باشد";
          } else if (value.startsWith("6")) {
            return "شماره تلفن معتبر نمی باشد";
          } else if (value.startsWith("7")) {
            return "شماره تلفن معتبر نمی باشد";
          } else if (value.startsWith("8")) {
            return "شماره تلفن معتبر نمی باشد";
          }*/
          
          if (value.length < 11) {
            return "شماره تلفن نباید از 11 رقم کمتر باشد";
          }
          return null;*/
          if (value!.isEmpty) {
            return "شماره تلفن نباید خالی باشد.";
          }
          if (!regex.hasMatch(value))
            return 'شماره تلفن معتبر نمی باشد';
          else
            return null;
        },

        inputFormatters: inputFormatters,
        style: TextStyle(fontSize: 14, fontFamily: 'Vazirmatn_Medium'),
        decoration: InputDecoration(
            hintText: hint,
            icon: icon,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )),
      ),
    );
  }
}
