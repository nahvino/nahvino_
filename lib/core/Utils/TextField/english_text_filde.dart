import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/shared/presentation/controllers/Utils/english_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class EnglishTextFilde extends StatelessWidget {
  EnglishTextFilde(
      {Key? key,
      this.hint,
      this.controller,
      this.icon,
      this.prefixIcon,
      this.suffixIcon,
      this.errorttext,
      this.suffix,
      this.onChanged,
      this.focusNode,})
      : super(key: key);
  EnglishController enController = Get.put(EnglishController());
  final String? hint;
  final TextEditingController? controller;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorttext;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  String? error;
  String? s;
  final alphanumeric = RegExp("[a-z 0-9]");

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final persian = RegExp(
        "[\u0600-\u0605 ؐ-ؚ\u061Cـ ۖ-\u06DD ۟-ۤ ۧ ۨ ۪-ۭ ً-ٕ ٟ ٖ-ٞ ٰ ، ؍ ٫ ٬ ؛ ؞ ؟ ۔ ٭ ٪ ؉ ؊ ؈ ؎ ؏ ۞ ۩ ؆ ؇ ؋ ٠۰ ١۱ ٢۲ ٣۳ ٤۴ ٥۵ ٦۶ ٧۷ ٨۸ ٩۹ ءٴ۽ آ أ ٲ ٱ ؤ إ ٳ ئ ا ٵ ٮ ب ٻ پ ڀ ة-ث ٹ ٺ ټ ٽ ٿ ج ڃ ڄ چ ڿ ڇ ح خ ځ ڂ څ د ذ ڈ-ڐ ۮ ر ز ڑ-ڙ ۯ س ش ښ-ڜ ۺ ص ض ڝ ڞ ۻ ط ظ ڟ ع غ ڠ ۼ ف ڡ-ڦ ٯ ق ڧ ڨ ك ک-ڴ ػ ؼ ل ڵ-ڸ م۾ ن ں-ڽ ڹ ه ھ ہ-ۃ ۿ ەۀ وۥ ٶ ۄ-ۇ ٷ ۈ-ۋ ۏ ى يۦ ٸ ی-ێ ې ۑ ؽ-ؿ ؠ ے ۓ \u061D]");
    final capital_letters = RegExp("[A-Z]");

    return Padding(
      padding: const EdgeInsets.only(right: 39, left: 39),
      child: Column(
        children: [
          TextFormField(
            onTap: () {
              controller!.selection =
                  TextSelection.collapsed(offset: controller!.text.length);
            },
            controller: controller,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.none,
            onChanged: onChanged,
            focusNode: focusNode,

            /*  onChanged: (val) {
                if (val.length <= 3) {
                  enController.lengthText.value = true;
                  enController.capitalLettersText.value = false;
                }
                if (val.length >= 3) {
                  enController.lengthText.value = false;
                  enController.verifyText.value = true;
                  enController.capitalLettersText.value = false;
                }

                if (val == "") {
                  enController.errorText.value = false;
                  enController.lengthText.value = false;
                  enController.capitalLettersText.value = false;
                }
                if (persian.hasMatch(val) == true) {
                  enController.errorText.value = true;
                  enController.capitalLettersText.value = false;
                }
                if (capital_letters.hasMatch(val) == true) {
                  enController.errorText.value = true;
                  enController.capitalLettersText.value = true;
                }
              },*/
            validator: (value) {
              if (value!.isEmpty) {
                return 'نام کاربری نمی تواند خالی باشد';
              } else if (value.length < 3) {
                return 'نام کاربری نمی تواند از 3 کاراکتر کمتر باشد';
              } else if (alphanumeric.hasMatch(value) == false) {
                return "نام کاربری نمی تواند فارسی و حرف بزرگ باشد.";
              }

              return null;
            },
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Vazirmatn_Medium',
              color: theme.secondaryHeaderColor,
            ),
            decoration: InputDecoration(
              hintText: hint,
              suffix: suffix,
              errorText: error,
              label: Callout(text: hint!),
              icon: icon,
              prefixIcon: prefixIcon,
              suffixIcon: Icon(
                Iconsax.user,
                color: Colors.cyan,
              ),
            ),
          ),
          /*
            Visibility(
                visible: enController.errorText.value,
                child: Padding(
                  padding: EdgeInsets.only(right: 10, top: 12),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.minus_square,
                        color: Colors.deepOrange,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Caption1(text: "مقدار نباید فارسی باشد."),
                    ],
                  ),
                )),
            Visibility(
                visible: enController.capitalLettersText.value,
                child: Padding(
                  padding: EdgeInsets.only(right: 10, top: 12),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.minus_square,
                        color: Colors.deepOrange,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Caption1(text: "مقدار نباید حروف بزرگ باشد."),
                    ],
                  ),
                )),
            Visibility(
                visible: enController.lengthText.value,
                child: Padding(
                  padding: EdgeInsets.only(right: 10, top: 12),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.minus_square,
                        color: Colors.deepOrange,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Caption1(text: "مقدار شما نباید کمتر از 3 کاراکتر باشد."),
                    ],
                  ),
                )),
            */
        ],
      ),
    );
  }
}
