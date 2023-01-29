import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/drop_down/drop_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DrapDoonButton extends StatelessWidget {
  DrapDoonButton({Key? key, this.onChanged, this.value,}) : super(key: key);

  final ValueChanged? onChanged;
  final String? value;

  DropController dropController = Get.put(DropController());


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    dropController.securityQuestion(context);


    return GetBuilder<DropController>(builder: (logic) {
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
              border: Border.all(
                color: Colors.black26,
              ),
              color: theme.inputDecorationTheme.hoverColor,
            ),
            // buttonElevation: 2,
            itemHeight: 58,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 365,
            dropdownWidth: 270,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.grey,
            ),
            //  dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
            offset: const Offset(-20, 0),
            isExpanded: true,
            style: TextStyle(
              color: theme.backgroundColor,
              fontSize: 14,
              fontFamily: 'Vazirmatn_Medium',),
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
                    )!, color: theme.hintColor,
                  ),
                ),
              ],
            ),
            items: dropController.listDrap,
            onChanged: onChanged,
            value: value,
          ),
        ),


      );
    });
  }
}
