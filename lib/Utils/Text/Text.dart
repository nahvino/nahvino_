import 'package:flutter/material.dart';

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

class LargeTitle extends StatelessWidget {
  LargeTitle(
      {required this.text, required this.color, required TextAlign textAlign});

  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 34, fontFamily: 'vazirlight'),
    );
  }
}

class Title1 extends StatelessWidget {
  Title1(
      {required this.text, required this.color, required TextAlign textAlign});

  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 28, fontFamily: 'vazirlight'),
    );
  }
}

class Title2 extends StatelessWidget {
  Title2(
      {required this.text, required this.color, required TextAlign textAlign});

  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color, fontSize: 22, fontFamily: 'Vazirmatn_SemiBold'),
    );
  }
}

class Title3 extends StatelessWidget {
  Title3(
      {required this.text, required this.color, required TextAlign textAlign});

  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 20, fontFamily: 'vazirlight'),
    );
  }
}

class Headline extends StatelessWidget {
  Headline(
      {required this.text, required this.color, required TextAlign textAlign});

  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          fontFamily: 'vazirlight'),
    );
  }
}

class Body extends StatelessWidget {
  Body({required this.text, required this.color, required TextAlign textAlign});

  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color, fontSize: 17, fontFamily: 'Vazirmatn_Regular'),
    );
  }
}

class Callout extends StatelessWidget {
  Callout(
      {required this.text, required this.color, required TextAlign textAlign});

  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color, fontSize: 16, fontFamily: 'Vazirmatn_Regular'),
    );
  }
}

class Subhead extends StatelessWidget {
  Subhead(
      {required this.text, required this.color, required TextAlign textAlign});

  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: 15, fontFamily: 'Vazirmatn_Medium'),
    );
  }
}

class Footnate extends StatelessWidget {
  Footnate({required this.text, this.color, TextAlign? textAlign});

  String? text;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          color: color, fontSize: 13, fontFamily: 'Vazirmatn_Regular'),
    );
  }
}

class Caption1 extends StatelessWidget {
  Caption1({required this.text, this.color, this.textAlign});

  String? text;
  Color? color;
  TextAlign? textAlign;

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

class Caption2 extends StatelessWidget {
  Caption2(
      {required this.text, required this.color, required TextAlign textAlign});

  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color, fontSize: 11, fontFamily: 'Vazirmatn_ExtraLight'),
    );
  }
}
