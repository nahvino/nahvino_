import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/features/splash/screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


ShowError({required String title}){
     return
     Get.defaultDialog(
    barrierDismissible: false,
    title: title,
    titleStyle: TextStyle(
        color: Colors.black, fontSize: 16, fontFamily: 'Vazirmatn_Light'),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 120,
              child: Buttonfull(
                text: "تلاش مجدد",
                onPressed: () {
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Splash()));
                  Get.offAll(Splash());
                },
              ),

              /*TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Splash()));
                        },
                        child: Caption1(
                          color: Colors.cyan,
                          textAlign: TextAlign.center,
                          text: "تلاش مجدد",
                        ),
                      ),*/
            ),
            SizedBox(width: 10),
            Container(
              width: 120,
              child: Buttonfull(
                text: "خروج",
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
