import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/profile/view_profile/controllers/profile_controller.dart';
import 'package:Nahvino/features/profile/view_profile/controllers/user_abandon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class UserAbandonProfile extends StatelessWidget {
  UserAbandonProfile({Key? key}) : super(key: key);
  ProfileController profile_Controller = Get.put(ProfileController());
  UserAbandonController user_abandon_Controller = Get.put(
      UserAbandonController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Obx(() {
      return Stack(
        children: [
          Card(
            elevation: 0,
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Body(
                    textAlign: TextAlign.center,
                    color: Colors.black87,
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
                          percent: user_abandon_Controller.Year(),
                          animation: true,
                          center: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Footnate(
                                  textAlign: TextAlign.center,
                               //   color: Colors.cyan,
                                  text: user_abandon_Controller.yaer.toString(),
                                ),
                                Caption2(
                                    textAlign: TextAlign.center,
                               //     color: Colors.cyan,
                                    text: AppLocalizations.of(context)!.translate(
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
                          percent: user_abandon_Controller.Month(),
                          animation: true,
                          center: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Footnate(
                                    textAlign: TextAlign.center,
                                 //   color: Colors.cyan,
                                    text: user_abandon_Controller.month
                                        .toString()),
                                Caption2(
                                    textAlign: TextAlign.center,
                                 //   color: Colors.cyan,
                                    text: AppLocalizations.of(context)!.translate(
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
                          percent: user_abandon_Controller.Day(),
                          animation: true,
                          center: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Footnate(
                                    textAlign: TextAlign.center,
                               //     color: Colors.cyan,
                                    text: user_abandon_Controller.day
                                        .toString()),
                                Caption2(
                                    textAlign: TextAlign.center,
                                 //   color: Colors.cyan,
                                    text:  AppLocalizations.of(context)!.translate(
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
          Positioned(
            top: width * 0.07,
            right: width * 0.75,
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
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 240,
                              child: Callout(
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                text: AppLocalizations.of(context)!.translate(
                                  'clean_days',
                                )!
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),
          ),
        ],
      );
    });
  }
}
