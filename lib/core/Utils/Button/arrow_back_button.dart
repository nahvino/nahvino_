import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ArrowBackBotton extends StatelessWidget {
  const ArrowBackBotton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Icon(Iconsax.arrow_circle_right,size: 30,)),
    );
  }
}
