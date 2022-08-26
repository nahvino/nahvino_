import 'package:Nahvino/Utils/Button/Button.dart';
import 'package:Nahvino/Utils/Button/gradint_button.dart';
import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DialogTowButton extends StatelessWidget {
  DialogTowButton(
      {Key? key, this.onPressed, this.title, this.textbutton, this.titlecancel})
      : super(key: key);

  VoidCallback? onPressed;
  String? title;
  String? titlecancel;

  String? textbutton;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        width: 100,
        height: 100,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Footnate(text: title!),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 30,
                      width: 100,
                      child: GadintButton(
                        text: textbutton!,
                        onPressed: onPressed,
                      )),
                  Container(
                    height: 30,
                    width: 100,
                    child: Buttonfull(
                      text: titlecancel == "" || titlecancel == null
                          ? "انصراف"
                          : titlecancel!,
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ),
                ],
              ),
            ]),
      );
}
