import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

// ignore: must_be_immutable
class LargeTitle extends StatelessWidget {
  const LargeTitle({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(color: color, fontSize: 34, fontFamily: 'Vazirmatn_Black'),
    );
  }
}

// ignore: must_be_immutable
class Title1 extends StatelessWidget {
  const Title1({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(color: color, fontSize: 28, fontFamily: 'Vazirmatn_Black'),
    );
  }
}

// ignore: must_be_immutable
class Title2 extends StatelessWidget {
  const Title2({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          color: color, fontSize: 22, fontFamily: 'Vazirmatn_SemiBold'),
    );
  }
}

// ignore: must_be_immutable
class Title3 extends StatelessWidget {
  Title3({
    required this.text,
    this.color,
    this.textAlign,
  });
  final Color? color;
  final TextAlign? textAlign;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(color: color, fontSize: 20, fontFamily: 'Vazirmatn_Black'),
    );
  }
}

// ignore: must_be_immutable
class HeadLine extends StatelessWidget {
  const HeadLine({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          color: color,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          fontFamily: 'Vazirmatn_ExtraBold'),
    );
  }
}

// ignore: must_be_immutable
class Body extends StatelessWidget {
  const Body({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  final String? text;
  final double fontsize = 17;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          color: color, fontSize: fontsize, fontFamily: 'Vazirmatn_Regular'),
    );
  }
}

// ignore: must_be_immutable
class Callout extends StatelessWidget {
  const Callout({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          color: color, fontSize: 16, fontFamily: 'Vazirmatn_Regular'),
    );
  }
}

// ignore: must_be_immutable
class Subhead extends StatelessWidget {
  const Subhead({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style:
          TextStyle(color: color, fontSize: 15, fontFamily: 'Vazirmatn_Medium'),
    );
  }
}

// ignore: must_be_immutable
class Footnate extends StatelessWidget {
  const Footnate({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          color: color, fontSize: 13, fontFamily: 'Vazirmatn_Regular'),
    );
  }
}

// ignore: must_be_immutable
class Caption1 extends StatelessWidget {
  const Caption1({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      style:
          TextStyle(color: color, fontSize: 12, fontFamily: 'Vazirmatn_Light'),
    );
  }
}

// ignore: must_be_immutable
class Caption2 extends StatelessWidget {
  const Caption2({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color, fontSize: 11, fontFamily: 'Vazirmatn_ExtraLight'),
    );
  }
}

// ignore: must_be_immutable
class ChatTextMassgae extends StatelessWidget {
  ChatTextMassgae(
      {required this.text,
      this.color,
      this.textAlign,
      this.fontsize,
      this.fonts});
  final Color? color;
  final TextAlign? textAlign;
  final String? text;
  String? fonts;
  double? fontsize = 20;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(color: color, fontSize: fontsize, fontFamily: fonts),
    );
  }
}
