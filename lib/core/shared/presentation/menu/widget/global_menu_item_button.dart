import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:flutter/material.dart';
class GlobalMenuItemButton extends StatelessWidget {
  GlobalMenuItemButton({Key? key, required this.icon, required this.text, required this.ontop}) : super(key: key);
  final Widget icon;
  final String text;
  final VoidCallback ontop;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: ontop,
      child: Padding(
        padding: EdgeInsets.only(right: 20,left: 20),
        child: SizedBox(
          height: height * 0.065,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Body(text: text,color: theme.secondaryHeaderColor,),
                icon,

          ]),
        ),
      ),
    );
  }
}
