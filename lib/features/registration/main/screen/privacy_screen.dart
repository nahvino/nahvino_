import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade800,
        title: Callout(text: AppLocalizations.of(context)!.translate(
          'Privacy_policy',
        )!,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Callout(
                color: Colors.black,
                textAlign: TextAlign.right,
                text:
                AppLocalizations.of(context)!.translate(
                  'choose_whether',
                )!,),
          ),
        ),
      ),
    );
  }
}
