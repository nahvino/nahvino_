import 'package:flutter/material.dart';

class GadintButton extends StatelessWidget {
  GadintButton({Key? key, this.onPressed, required this.text})
      : super(key: key);
  VoidCallback? onPressed;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.red,
            padding: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0))),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  //radius: 5,
                  colors: [
                    Colors.cyan.shade300,
                    Colors.cyan.shade800,
                    Colors.cyan.shade900,
                  ], end: Alignment(7.0, 6.0)),
              borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 380.0, minHeight: 180.0),
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Vazirmatn_Light'),
            ),

            // Buttonfull(
            //   text: "ثبت",
            //   color: Colors.white,
            //   onPressed: () => onPressed,
            // ),
          ),
        ),
      ),
    );
  }
}
