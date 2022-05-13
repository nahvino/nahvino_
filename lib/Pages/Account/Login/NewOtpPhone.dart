
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../App_localizations.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Utils/Button/Button.dart';
import '../../../Utils/Text/TextField.dart';
import 'CodeOtpPhoneNew.dart';
import 'SignUp.dart';

class OtpPhoneNew extends StatefulWidget {
  const OtpPhoneNew({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpPhoneNew> createState() => _OtpPhoneNewState();
}

class _OtpPhoneNewState extends State<OtpPhoneNew> {
  bool isApiCallProcess = false;
  TextEditingController OtpPhoneController = TextEditingController();
  late APIService apiService;
  String? phone="09";
  @override
  void initState() {
    super.initState();
    apiService = APIService(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        leading: BackButton(
          color: Colors.black,
          onPressed: (() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          }),
        ),
      ),
      body: isApiCallProcess
          ? Center(
              child: Lottie.asset('assets/anim/login/send-massage.json',
                  height: 300, width: 300),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Lottie.asset('assets/anim/login/send.json',
                          height: 150, width: 150),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 320,
                          child: TextOtpPhone(
                            icon: Icon(Icons.phone_android, size: 32),
                            suffixIcon: null,
                            prefixIcon: null,
                            hint: AppLocalizations.of(context)!.translate(
                              'phoneNumber',
                            )!,
                            controller: OtpPhoneController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 23),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black38, width: 0.9),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text("09"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Buttontest(
                        text: AppLocalizations.of(context)!.translate(
                          'OK',
                        )!,
                        onPressed: () {
                          if (OtpPhoneController.text.isEmpty) {
                            apiService.showSnackBar(text: "filed is empty!");
                            return;
                          }
                          setState(() {
                            isApiCallProcess = true;
                          });
                          apiService.OtpPhone(phone!+OtpPhoneController.text)
                              .then((response) async {
                            if (response != false) {
                              apiService.showSnackBar(
                                  text: response['message']);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CodeOtpPhoneNew(
                                          OtpCode: OtpPhoneController.text,phone: phone.toString(),
                                        )),
                                (route) => false,
                              );
                            } else {
                              apiService.showSnackBar(
                                  text: response['message'] ?? "sdd");
                            }
                          });
                        }),
                  ],
                ),
              ),
            ),
    );
  }
}
