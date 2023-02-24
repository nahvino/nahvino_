import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/shared/presentation/controllers/Utils/password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class TextPassReAndLog extends StatelessWidget {
  PasswordController passwordController = Get.put(PasswordController());

  TextPassReAndLog({Key? key,
    required this.hint,
    required this.controller,
    this.icon,
    this.prefixIcon,
    this.suffix,
    this.error, this.onChanged})
      : super(key: key);

  final String hint;
  final TextEditingController controller;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffix;
  final String? error;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final alphanumeric = RegExp("[A-Z a-z 0-9]");
    final alph = RegExp("-z]");
    final alpha = RegExp("[A-Z]");
    final alphaa = RegExp("[0-9]");
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(right: 39, left: 39),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onTap: () {
                controller.selection =
                    TextSelection.collapsed(offset: controller.text.length);
              },
              controller: controller,
              obscureText: passwordController.obscurePasswordVisibility.value,
              keyboardType: TextInputType.visiblePassword,
              onChanged: onChanged,
              /*
              onChanged: (val) {
                if (val.length <= 6) {
                  passwordController.lengthText.value = true;
                }
                if (val.length >= 6) {
                  passwordController.lengthText.value = false;
                }

                if (val == "") {
                  passwordController.errorText.value = false;
                  passwordController.lengthText.value = false;
                }
                if (alph.hasMatch(val) == true) {
                  passwordController.errorText.value = true;
                }
                if (alphaa.hasMatch(val) == true) {
                  passwordController.errorText.value = true;
                }
                if (alpha.hasMatch(val) == true) {
                  passwordController.errorText.value = false;
                }
                if (alph.hasMatch(val) &&
                    alpha.hasMatch(val) &&
                    alphaa.hasMatch(val) &&
                    val.length >= 6 == true) {
                  passwordController.verifyText.value = true;
                  passwordController.errorText.value = false;
                }
              },

               */
              validator: (value) {
                if (value!.length <= 6) {
                  return 'پسورد شما حداقل باید 6 کاراکتر داشته باشد';
                }
                if (value.isEmpty) {
                  return 'رمز عبور نمی تواند خالی باشد';
                }
                if (alphanumeric.hasMatch(value) == false) {
                  return "رمز عبور نمی تواند فارسی باشد.";
                }
                return null;
              },
              style: TextStyle(fontSize: 14,
                fontFamily: 'Vazirmatn_Medium',
                color: theme.secondaryHeaderColor,),
              decoration: InputDecoration(
                hintText: hint,
                suffix: suffix,
                errorText: error,
                label: Callout(text: hint),
                icon: icon,
                prefixIcon: IconButton(
                  icon: Icon(
                      passwordController.obscurePasswordVisibility.value == true
                          ? Icons.visibility_off
                          : Icons.visibility),
                  onPressed: () {
                    passwordController.obscurePasswordVisibility.value =
                    !passwordController.obscurePasswordVisibility.value;
                  },),
                suffixIcon: Icon(
                  Iconsax.lock,
                  color: Colors.cyan,
                ),
              ),
            ),

            /*
            Visibility(
                visible: passwordController.errorText.value,
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
                      Caption1(text: "پسورد نمی تواند فقط عدد حرف کوچک باشد."),
                    ],
                  ),
                )),
            Visibility(
                visible: passwordController.lengthText.value,
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
                      Caption1(text: "پسورد شما نباید کمتر از 6 کاراکتر باشد."),
                    ],
                  ),
                )),

             */

          ],
        ),
      );
    });
  }
}
