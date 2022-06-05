import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';

import '../../App_localizations.dart';
import '../Button/Button.dart';

// ignore: must_be_immutable
class PrivacyDialog extends StatelessWidget {
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
        child: Column(
          children: [
            Column(
              children: [

                Accordion(
                  maxOpenSections: 1,
                  leftIcon: Icon(Icons.book, color: Colors.white),
                  children: [
                    AccordionSection(
                      isOpen: true,
                      header: Text('مالکیت'),
                      content: Text(
                          'مالکیت شبکه جتماعی نحوینو انحصارا در اختیار شرکت آله می باشد .توهین به اشخاص حقیقی و حقوقی باعث حذف حساب کاربری می شود.'),
                    ),
                    AccordionSection(
                      isOpen: true,
                      header: Text('مالکیت'),
                      content: Text(
                          'مالکیت شبکه جتماعی نحوینو انحصارا در اختیار شرکت آله می باشد .توهین به اشخاص حقیقی و حقوقی باعث حذف حساب کاربری می شود.'),
                    ),
                    AccordionSection(
                      isOpen: true,
                      header: Text('مالکیت'),
                      content: Text(
                          'مالکیت شبکه جتماعی نحوینو انحصارا در اختیار شرکت آله می باشد .توهین به اشخاص حقیقی و حقوقی باعث حذف حساب کاربری می شود.'),
                    ),AccordionSection(
                      isOpen: true,
                      header: Text('مالکیت'),
                      content: Text(
                          'مالکیت شبکه جتماعی نحوینو انحصارا در اختیار شرکت آله می باشد .توهین به اشخاص حقیقی و حقوقی باعث حذف حساب کاربری می شود.'),
                    ),AccordionSection(
                      isOpen: true,
                      header: Text('مالکیت'),
                      content: Text(
                          'مالکیت شبکه جتماعی نحوینو انحصارا در اختیار شرکت آله می باشد .توهین به اشخاص حقیقی و حقوقی باعث حذف حساب کاربری می شود.'),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Buttonfull(
              text: AppLocalizations.of(context)!.translate('Cancel')!,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              color: Colors.white,
            ),
          ],
        ),
      );
}
