import 'package:flutter/material.dart';

class TextProfileEn extends StatefulWidget {
  const  TextProfileEn({
    Key? key,
    this.hint,
    this.controller,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  final String? hint;
  final TextEditingController? controller;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  State<TextProfileEn> createState() => _TextProfileEnState();
}

class _TextProfileEnState extends State<TextProfileEn> {
  String? error;
  final alphanumeric = RegExp("[A-Z a-z 0-9]");

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(right: 35,left: 39),
        child: TextFormField(
          textAlign: TextAlign.right,
          controller: widget.controller,
          keyboardType: TextInputType.text ,
          onChanged: (input){
            if(alphanumeric.hasMatch(input) == false){
              error = "نام کاربری نمی تواند فارسی باشد.";
            }else{
              error = null;
            }
            if((input).isEmpty){
              error = "نام کاربری نمی تواند خالی باشد.";
            }
            setState(() {

            });
          },
          style: TextStyle(fontSize: 16, fontFamily: 'vazirlight'),
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