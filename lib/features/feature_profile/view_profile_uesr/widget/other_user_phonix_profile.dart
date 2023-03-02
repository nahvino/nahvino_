import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/controllers/view_profile_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OtherUserPhonixProfile extends StatelessWidget {
  OtherUserPhonixProfile({Key? key}) : super(key: key);
  ViewProfileUserController vpu_Controller =
  Get.put(ViewProfileUserController());
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
    if (vpu_Controller.otherLastVisitModel!.data! > 6) {
      Lottie.asset('assets/anim/phonix/level7.json');
    } else {
      ghoghnos[vpu_Controller.otherLastVisitModel!.data!];
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return GetBuilder<ViewProfileUserController>(builder: (logic) {
      return (vpu_Controller.otherLastVisitModel == null)
          ? Container(
              color: Colors.white,
              child: Center(
                child: Lottie.asset('assets/anim/loading/loading.json',
                    height: 200, width: 200),
              ),
            )
          : Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            (vpu_Controller.otherLastVisitModel!.data! > 6)
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Lottie.asset(
                                        'assets/anim/phonix/level7.json'),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: ghoghnos[vpu_Controller.otherLastVisitModel!.data!],
                                  ),
                            (vpu_Controller.otherLastVisitModel!.data! > 6)
                                ? Container(
                                    width: 150,
                                    child: Image.asset(
                                        'assets/images/hart/hart-lave8.png'))
                                : Container(
                                    alignment: Alignment.center,
                                    child: hart[vpu_Controller.otherLastVisitModel!.data!],
                                  ),
                          ],
                        ),
                      ),
                    ),
                    //tooltip to Obx
                  ],
                ),
              ],
            );
    });
  }
}
