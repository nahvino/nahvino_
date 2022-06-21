import 'package:Nahvino/Utils/Validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Validator/validator.dart';

class TextProfile extends StatelessWidget {
  const TextProfile({
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
    return Padding(
      padding: const EdgeInsets.only(right: 35, left: 39),
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: controller,
        onTap: ontap,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 16, fontFamily: 'Vazirmatn_Medium'),
        decoration: InputDecoration(
          hintText: hint,
        ),
        /* decoration: InputDecoration(
            hintText: hint,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            )),*/
      ),
    );
  }
}

class TextProfileEn extends StatefulWidget {
  const TextProfileEn({
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
  late Validator validators = Validator();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 35, left: 39),
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: widget.controller,
        keyboardType: TextInputType.text,
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
      padding: const EdgeInsets.only(right: 35, left: 39),
      child: TextFormField(
        maxLength: 200,
        maxLines: 3,
        minLines: 1,
        textAlign: TextAlign.right,
        controller: controller,
        keyboardType: TextInputType.multiline,
        style: TextStyle(fontSize: 16, fontFamily: 'Vazirmatn_Medium'),
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

class TextRegister extends StatelessWidget {
  const TextRegister({
    Key? key,
    required this.hint,
    required this.controller,
    required this.icon,
    required this.prefixIcon,
    required this.suffixIcon,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;
  final Widget icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: controller,
        style: TextStyle(fontSize: 12, fontFamily: 'vazirlight'),
        decoration: InputDecoration(
            hintText: hint,
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

class TextAll extends StatelessWidget {
  const TextAll({
    Key? key,
    required this.hint,
    required this.controller,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 40),
      child: TextFormField(
        textAlign: TextAlign.start,
        controller: controller,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 14, fontFamily: 'Vazirmatn_Medium'),
        decoration: InputDecoration(
            hintText: hint,
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
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: TextFormField(
        maxLength: 11,
        textAlign: TextAlign.left,
        controller: controller,
        keyboardType: TextInputType.phone,
        validator: validator,
        inputFormatters: inputFormatters,
        // [
        //   FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        // ],
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
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 40),
      child: TextFormField(
        textDirection: TextDirection.ltr,
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

class TextSearch extends StatelessWidget {
  const TextSearch({
    Key? key,
    required this.hint,
    this.controller,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  final String hint;
  final TextEditingController? controller;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: controller,
        style: TextStyle(fontSize: 12, fontFamily: 'vazirlight'),
        decoration: InputDecoration(
            hintText: hint,
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
