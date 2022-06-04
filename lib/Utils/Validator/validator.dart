
import 'package:Nahvino/controllers/getx/edit_text_validator_controller.dart';
import 'package:flutter/material.dart';

class Validator {
  final alphanumeric = RegExp("[A-Z a-z 0-9]");
    void zaban({required String? error, required  dynamic input}) {
    if (alphanumeric.hasMatch(input) == false) {
      error = "نام کاربری نمی تواند فارسی باشد.";
    } else {
      error = null;
    }
    if ((input).isEmpty) {
      error = "نام کاربری نمی تواند خالی باشد.";
    }
  }
}
