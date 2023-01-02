import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DrapDoonButton extends StatelessWidget {
  DrapDoonButton({Key? key, this.onChanged,  this.value}) : super(key: key);
  final ValueChanged? onChanged;
  final String? value;

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

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    securityQuestion(context);
    return Padding(
      padding: EdgeInsets.only(right: 39, left: 39),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          icon: const Icon(
            Iconsax.arrow_down,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.black54,
          iconDisabledColor: Colors.grey,
          buttonHeight: 58,
         // buttonWidth: 160,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            // border: Border.all(
            //   color: Colors.black26,
            // ),
            color: theme.inputDecorationTheme.hoverColor,
          ),
         // buttonElevation: 2,
          itemHeight: 58,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 365,
          dropdownWidth: 270,
          dropdownPadding: null,
          // dropdownDecoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(14),
          //   color: Colors.redAccent,
          // ),
         // dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
          isExpanded: true,
          style: TextStyle(
              color: theme.secondaryHeaderColor, fontSize: 14, fontFamily: 'Vazirmatn_Medium'),
          hint: Row(
            children: [
              Icon(
                Iconsax.arrow_circle_down,
                color: Colors.cyan,
              ),
              SizedBox(
                width: 6,
              ),
              Expanded(
                child: Body(
                  text:
                  AppLocalizations.of(context)!.translate(
                    'sAnswer',
                  )!,
                ),
              ),
            ],
          ),
          items: listDrap,
          onChanged: onChanged,
          value: value,
        ),
      ),
    );
  }
}
