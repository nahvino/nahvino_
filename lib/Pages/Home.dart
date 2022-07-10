import 'package:Nahvino/Pages/Account/User/editprofilescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../App_localizations.dart';
import '../Utils/TextField/englishtextfilde.dart';
import '../Utils/TextField/phonefextfilde.dart';
import '../Utils/TextField/publictextfilde.dart';
import '../Data/Local/viewprofial_data.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PublicTextFilde(
              hint: "نام کاربری",
              /*   validator: (value) {
                /* if (value.isEmpty) {
                  return 'نام کاربری نیم تواند خالی باشد';
                }*/
                Validator.empty(value);
              //  Validator.em(value);
              },*/
            ),
            TextOtpPhone(
              icon: Icon(Icons.phone_android, size: 32),
              suffixIcon: null,
              prefixIcon: null,
              hint: AppLocalizations.of(context)!.translate(
                'phoneNumber',
              )!,
            ),
            ElevatedButton(
              child: Text("ثبت"),
              onPressed: () {
                if (!_formKey.currentState!.validate()) ;
              },
            )
          ],
        ),
      ),
    );
  }
}
