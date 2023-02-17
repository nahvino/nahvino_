import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:flutter/material.dart';

class PublicTextFilde extends StatelessWidget {
  const PublicTextFilde({
    Key? key,
    this.hint,
    this.controller,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.ontap,
  }) : super(key: key);

  final String? hint;
  final TextEditingController? controller;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? ontap;
  final FormFieldValidator? validator;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 35, left: 39),
      child: TextFormField(

        textAlign: TextAlign.right,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'مقدار نمی تواند خالی باشد';
          }

          return null;
          // Validator().empty(value!);
        },
        onTap: ontap,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 14, fontFamily: 'Vazirmatn_Medium',color: theme.secondaryHeaderColor,),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hint,
          label:Callout(text:hint!) ,
        ),
      ),
    );
  }
}
