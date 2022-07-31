import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';

import '../../App_localizations.dart';
import '../Button/Button.dart';

// ignore: must_be_immutable
class RulesDialog extends StatelessWidget {
  var size;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 480,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Text("سنت های نحوینو"),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                  "به سنت عشق گرد هم می آئیم . آنجا که دوست داشتن خداوند قادر تنها کلام زندگیست. سنت، چنانچه که از نامش برمی آید عهدی است  که شخص با خود و خدای خود میبندد.این عهد تا زمانی كه نشکند خدا و انسان را بهم وصل می‌دارد . در این مسیر قوانینی تبیین گشته، که در ادامه به آنها میپردازیم."),
            ),
            Accordion(
              maxOpenSections: 1,
              leftIcon: Icon(Icons.book, color: Colors.white),
              children: [
                AccordionSection(
                  isOpen: true,
                  header: Text('سنت یک'),
                  content: Text(
                      'کاربران نحوینویی، در این مسیر باید بدانید و بتوانید که خودپسندی را کنار بگذارید،هرآنچه که به منفعت شما ختم بشود. یک قدم به سوی لغزش، برای شماست ،شما در این راه باید آگاه شوید ک منفعت شما در این است که با جمع همراه و همسو باشید. شما باید بدانید که برای ناجی شدن  پا بر حق و حقوق دیگران نگذارید ،از تهمت و تخریب کردن شخصیت افراد برحذر باشید و  احساس تملک را کناربگذارند. و درنهایت از منافع خود در هر زمینه  صرف نظر کرده و منافع گروه و جمعی که در آن حضور دارید را راستای پاک ماندن و پاک زیستن در اولویت قراردهید'),
                ),
              ],
            ),
            // OutlinedButton(
            //   onPressed: () {},
            //   child: Text("مطالعه کردم"),
            // )
            Buttonfull(
              text:
                  AppLocalizations.of(context)!.translate('Date_of_departure')!,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              color: Colors.white,
            ),
          ]),
        ),
      );
}
