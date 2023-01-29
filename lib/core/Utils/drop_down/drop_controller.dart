import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropController extends GetxController{
  RxnString? values = null;
  RxString Questionselectedv = "0".obs;
  String? securityQuestionselected = null;

  List<DropdownMenuItem<String>> listDrap = [];
  void securityQuestion(BuildContext context) {
    listDrap = [];
    listDrap.add(new DropdownMenuItem(
        child: Text(
          AppLocalizations.of(context)!.translate(
            'first_teacher',
          )!,
        ),
        value: "0"));
    listDrap.add(new DropdownMenuItem(
        child: Text(
          AppLocalizations.of(context)!.translate(
            'your_first_school',
          )!,
        ),
        value: "1"));
    listDrap.add(new DropdownMenuItem(
        child: Text(
          AppLocalizations.of(context)!.translate(
            'city_where_you_were_born',
          )!,
        ),
        value: "2"));
    listDrap.add(new DropdownMenuItem(
        child: Text(
          AppLocalizations.of(context)!.translate(
            'model_do_you_like',
          )!,
        ),
        value: "3"));
    listDrap.add(new DropdownMenuItem(
        child: Text(
          AppLocalizations.of(context)!.translate(
            'school_friend',
          )!,
        ),
        value: "4"));
    listDrap.add(new DropdownMenuItem(
        child: Text(
          AppLocalizations.of(context)!.translate(
            'good_movie',
          )!,
        ),
        value: "5"));
  }
}