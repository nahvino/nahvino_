import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_profile/view_profile/controllers/profile_controller.dart';
import 'package:Nahvino/features/feature_profile/view_profile/controllers/user_abandon_controller.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/controllers/view_profile_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OtherUserAbandonProfile extends StatelessWidget {
  OtherUserAbandonProfile({Key? key}) : super(key: key);
  ViewProfileUserController vpu_Controller =
      Get.put(ViewProfileUserController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return (vpu_Controller.otherUserGetAbandonModel == null)
        ? Container(
            color: Colors.white,
            child: Center(
              child: Lottie.asset('assets/anim/loading/loading.json',
                  height: 200, width: 200),
            ),
          )
        : Obx(() {
            return Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Body(
                          textAlign: TextAlign.center,
                          color: theme.secondaryHeaderColor,
                          text: AppLocalizations.of(context)!.translate(
                            'Your_purity_until_this_moment',
                          )!,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: CircularPercentIndicator(
                                radius: 35.0,
                                lineWidth: 5.0,
                                percent: vpu_Controller.Year(),
                                animation: true,
                                center: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Footnate(
                                        textAlign: TextAlign.center,
                                        color: theme.secondaryHeaderColor,
                                        text: vpu_Controller.yaer.toString(),
                                      ),
                                      Caption2(
                                          textAlign: TextAlign.center,
                                          color: theme.secondaryHeaderColor,
                                          text: AppLocalizations.of(context)!
                                              .translate(
                                            'Year',
                                          )!),
                                    ],
                                  ),
                                ),
                                progressColor: Colors.cyanAccent,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: CircularPercentIndicator(
                                radius: 35.0,
                                lineWidth: 5.0,
                                percent: vpu_Controller.Month(),
                                animation: true,
                                center: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Footnate(
                                          textAlign: TextAlign.center,
                                          color: theme.secondaryHeaderColor,
                                          text:
                                              vpu_Controller.month.toString()),
                                      Caption2(
                                          textAlign: TextAlign.center,
                                          color: theme.secondaryHeaderColor,
                                          text: AppLocalizations.of(context)!
                                              .translate(
                                            'Month',
                                          )!),
                                    ],
                                  ),
                                ),
                                progressColor: Colors.cyanAccent,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              child: CircularPercentIndicator(
                                radius: 35.0,
                                lineWidth: 5.0,
                                percent: vpu_Controller.Day(),
                                animation: true,
                                center: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Footnate(
                                          textAlign: TextAlign.center,
                                          color: theme.secondaryHeaderColor,
                                          text: vpu_Controller.day.toString()),
                                      Caption2(
                                          textAlign: TextAlign.center,
                                          color: theme.secondaryHeaderColor,
                                          text: AppLocalizations.of(context)!
                                              .translate(
                                            'Day',
                                          )!),
                                    ],
                                  ),
                                ),
                                progressColor: Colors.cyanAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //tooltip
              ],
            );
          });
  }
}
