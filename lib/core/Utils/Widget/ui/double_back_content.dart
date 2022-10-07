import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:flutter/material.dart';

class DoubleBackContent extends StatelessWidget {
  const DoubleBackContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            topLeft: Radius.circular(5)),
        shape: BoxShape.rectangle,
        color: Colors.grey.shade800,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Icon(Icons.exit_to_app, color: Colors.white),
          SizedBox(
            width: 5,
          ),
          Footnate(
            text: "برای خارج شدن دوبار بزنید",
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
