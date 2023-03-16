import 'package:Nahvino/config/generated/assets.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

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
    this.onChanged,
  }) : super(key: key);

  final String? hint;
  final TextEditingController? controller;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator? validator;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    RegExp regex = new RegExp(r"^(\+98|0)?9\d{9}$");
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*
            Padding(
              padding: EdgeInsets.only(bottom: 23),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://cdn.britannica.com/22/1722-004-EAD033D8/Flag-Iran.jpg")),
                ),
              ),
            ),
            SizedBox(width: 3,),
            //Body(text: "98"),
*/
            SizedBox(
              width: width * 0.80,
              child: TextFormField(
                maxLength: 11,
                controller: controller,
                keyboardType: TextInputType.phone,
                onChanged: onChanged,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "شماره تلفن نباید خالی باشد.";
                  }
                  if (!regex.hasMatch(value))
                    return 'شماره تلفن معتبر نمی باشد';
                  else
                    return null;
                },
                inputFormatters: inputFormatters,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Vazirmatn_Medium',
                  color: theme.secondaryHeaderColor,
                ),
                decoration: InputDecoration(
                  // fillColor: Colors.grey.shade200,
                  // filled: true,
                  // border: InputBorder.none,
                  // focusedBorder: UnderlineInputBorder(
                  //     borderSide: BorderSide(
                  //       color: Colors.grey.shade200,
                  //       width: 0,
                  //     ),
                  //     borderRadius: BorderRadius.all(Radius.circular(15))),
                  // enabledBorder: UnderlineInputBorder(
                  //     borderSide: BorderSide(
                  //       color: Colors.grey.shade200,
                  //       width: 0,
                  //     ),
                  //     borderRadius: BorderRadius.all(Radius.circular(15))),

                  hintText: hint,
                  icon: icon,
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Callout(text: "شماره موبایل"),
                    ],
                  ),
                  prefixIcon: Image.asset(
                    height: 0.01,
                    width: 0.01,
                    Assets.phone_icon_textfild,
                  ),
                  suffixIcon: suffixIcon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
