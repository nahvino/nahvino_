import 'package:flutter/material.dart';
import 'package:nahvino/Pages/Account/login/Login.dart';
import 'package:nahvino/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Sign_up_nahvino extends StatefulWidget {
  const Sign_up_nahvino({Key? key}) : super(key: key);

  @override
  State<Sign_up_nahvino> createState() => _Sign_up_nahvinoState();

  getResponse() {
    var url = "https://api.nahvino.ir/api/v1/Account​/SignIn";
    http.post(Uri.parse(url)).then((value) {});
  }
}

class _Sign_up_nahvinoState extends State<Sign_up_nahvino> {
  String selectedValue = "از لیست یک سوال به دلخواه انتخاب کنید";
  final formKey = GlobalKey<FormState>();
  String name = "";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("از لیست یک سوال به دلخواه انتخاب کنید"), value: "1"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }

  @override
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    var doregister = () {
      print("دکمه ی ثبت نام");
      final form = formKey.currentState;
    };

    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
                right: 10,
                left: 10),
            child: BackButton(
              onPressed: (() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              }),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                right: 35,
                left: 35),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.translate(
                    'SignUp_top_text',
                  )!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontFamily: 'byekan'),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.17,
                right: 35,
                left: 35),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('نام کاربری'),
                    hintText: 'یک نام کاربری برای خود انتخاب کنید',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "نام کاربری نمی تواند خالی باشد";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    label: Text('رمز عبور'),
                    hintText: 'یک رمز عبور حداقل هشت کاراکتری انتخاب کنید',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    label: Text('تکرار رمز عبور'),
                    hintText: 'یک رمز عبور حداقل هشت کاراکتری انتخاب کنید',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 244, 244, 245),
                    ),
                    dropdownColor: Color.fromARGB(255, 255, 255, 255),
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: dropdownItems),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    label: Text('پاسخ سوال'),
                    hintText: 'به سوال انتخابی خود پاسخ دهید',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                  onPressed: (() {
                    doregister();
                  }),
                  child: Text(
                    AppLocalizations.of(context)!.translate(
                      'Signup_nahvi_btn',
                    )!,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'byekan',
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    primary: Color.fromARGB(255, 221, 63, 63),
                    fixedSize: const Size(308, 50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
