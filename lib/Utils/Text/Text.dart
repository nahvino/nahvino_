import 'package:flutter/material.dart';

// ignore: must_be_immutable
class textspan extends StatelessWidget {
  textspan(
      {required this.text, required this.color, required TextAlign textAlign});

  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: 16, fontFamily: 'Vazirmatn_Light'),
    );
  }
}

// ignore: must_be_immutable
class textbold extends StatelessWidget {
  textbold(
      {required this.text, required this.color, required TextAlign textAlign});
  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: 18, fontFamily: 'Vazirmatn_Light'),
    );
  }
}

// ignore: must_be_immutable
class LargeTitle extends StatelessWidget {
  LargeTitle({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(color: color, fontSize: 34, fontFamily: 'vazirlight'),
    );
  }
}

// ignore: must_be_immutable
class Title1 extends StatelessWidget {
  Title1({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(color: color, fontSize: 28, fontFamily: 'vazirlight'),
    );
  }
}

// ignore: must_be_immutable
class Title2 extends StatelessWidget {
  Title2({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  String? text;

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
  Title3({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(color: color, fontSize: 20, fontFamily: 'vazirlight'),
    );
  }
}

// ignore: must_be_immutable
class HeadLine extends StatelessWidget {
  HeadLine({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          color: color,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          fontFamily: 'vazirlight'),
    );
  }
}

// ignore: must_be_immutable
class Body extends StatelessWidget {
  Body({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  String? text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          color: color, fontSize: 17, fontFamily: 'Vazirmatn_Regular'),
    );
  }
}

// ignore: must_be_immutable
class Callout extends StatelessWidget {
  Callout({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  String? text;
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
  Subhead({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  String? text;

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
  Footnate({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  String? text;

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
  Caption1({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  String? text;

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
  Caption2({required this.text, this.color, this.textAlign});
  final Color? color;
  final TextAlign? textAlign;
  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color, fontSize: 11, fontFamily: 'Vazirmatn_ExtraLight'),
    );
  }
}
