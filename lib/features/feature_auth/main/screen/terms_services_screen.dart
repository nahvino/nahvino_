import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:flutter/material.dart';

class TermsservicesScreen extends StatelessWidget {
  const TermsservicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CalloutFullTexts(
        color: Colors.black,
        textAlign: TextAlign.right,
        text: AppLocalizations.of(context)!.translate(
          'development_team',
        )!,
      ),
    );
  }
}

