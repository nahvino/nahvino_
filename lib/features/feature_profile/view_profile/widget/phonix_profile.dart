import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_profile/view_profile/controllers/Phoenix_controller.dart';
import 'package:Nahvino/features/feature_profile/view_profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PhonixProfile extends StatelessWidget {
  PhonixProfile({Key? key}) : super(key: key);
  ProfileController profile_Controller = Get.put(ProfileController());
  PhoenixController phoenix_Controller = Get.put(PhoenixController());

  List<Widget> ghoghnos = <Widget>[
    Lottie.asset('assets/anim/phonix/level1.json'),
    Lottie.asset('assets/anim/phonix/level2.json'),
    Lottie.asset('assets/anim/phonix/level3.json'),
    Lottie.asset('assets/anim/phonix/level4.json'),
    Lottie.asset('assets/anim/phonix/level5.json'),
    Lottie.asset('assets/anim/phonix/level6.json'),
    Lottie.asset('assets/anim/phonix/level7.json'),
  ];
  List<Widget> hart = <Widget>[
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave1.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave2.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave3.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave4.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave5.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave6.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave7.png')),
    Container(
        width: 100, child: Image.asset('assets/images/hart/hart-lave8.png')),
  ];

  ghgoghnos() {
    if (phoenix_Controller.phoenixResponse['data'] > 6) {
      Lottie.asset('assets/anim/phonix/level7.json');
    } else {
      ghoghnos[phoenix_Controller.phoenixResponse['data']];
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Obx(() {
      return Column(
        children: [
          Stack(
            children: [
              if (phoenix_Controller.phoenixResponse == null)
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Lottie.asset('assets/anim/phonix/level1.json'),
                    ),
                    Container(
                        width: 100,
                        child: Image.asset(
                            'assets/images/hart/hart-lave1.png')),
                  ],
                ),
              if (phoenix_Controller.phoenixResponse != null)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        if (phoenix_Controller.phoenixResponse['data'] > 6)
                          Container(
                            alignment: Alignment.center,
                            child: Lottie.asset(
                                'assets/anim/phonix/level7.json'),
                          ),
                        Container(
                          alignment: Alignment.center,
                          child: ghoghnos[phoenix_Controller
                              .phoenixResponse['data']],
                        ),
                        if (phoenix_Controller.phoenixResponse['data'] > 6)
                          Container(
                              width: 150,
                              child: Image.asset(
                                  'assets/images/hart/hart-lave8.png')),
                        Container(
                          alignment: Alignment.center,
                          child: hart[phoenix_Controller
                              .phoenixResponse['data']],
                        ),
                      ],
                    ),
                  ),
                ),
              //tooltip
              Positioned(
                top: width * 0.09,
                right: width * 0.71,
                child: Visibility(
                    visible: profile_Controller.help.value,
                    child: PopupMenuButton<int>(
                        elevation: 1,
                        color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        splashRadius: 50,
                        icon: Image.asset(
                            width: 40,
                            height: 40,
                            'assets/images/icon/tooltip.png'),
                        itemBuilder: (context) =>
                        [
                          PopupMenuItem(
                            value: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 240,
                                  child: Callout(
                                    textAlign: TextAlign.center,
                                    color: Colors.white,
                                    text:
                                    "این ققنوس نمادی از شما در مسلک نحوینو است.\n شما با قدم گذاشتن در این سرزمین و اراده بر کنار گذاشتن عادات بد مانند یک ققنوس از خاکستر خود جوان و شاداب متولد شده اید \n در نحوینو هر کاربر یک ققنوس متخص به خود دارد که باید هر روز شما را در نحوینو ملاقات کند.\n او با فعالیت های مثبت شما سرزنده خواهد ماند.",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ])),
              ),
              Positioned(
                top: width * 0.50,
                right: width * 0.59,
                child: Visibility(
                    visible: profile_Controller.help.value,
                    child: PopupMenuButton<int>(
                        color: Colors.deepOrange,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        splashRadius: 50,
                        icon: Image.asset(
                            width: 40,
                            height: 40,
                            'assets/images/icon/tooltip.png'),
                        itemBuilder: (context) =>
                        [
                          PopupMenuItem(
                            value: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 240,
                                  child: Callout(
                                    textAlign: TextAlign.center,
                                    color: Colors.white,
                                    text:
                                    "این هفت قلب نماد شادابی و سلامت ققنوس شماست. \n ققنوستان اگر هرروز شما را ملاقات نکند سلامت خود را از دست میدهد.\n اگر ققنوس به کامل بمیرد به دادن شاهپر برای احیای او خواهید بود.\n برای مراقبت از ققنوستان باید هرروز در نحوینو حاضر شده و نشان دهید به عهدی که برای تغییر سبک زندگی خود و دیگران بسته اید وفادارید.",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ])),
              ),
            ],
          ),
        ],
      );
    });
  }
}
