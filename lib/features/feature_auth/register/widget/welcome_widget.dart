import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_auth/register/controllers/register_controller.dart';
import 'package:Nahvino/features/feature_profile/view_profile/data/view_profial_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

class WelcomeWedget extends StatelessWidget {
  WelcomeWedget({Key? key}) : super(key: key);
  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.height * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Callout(
                            color: Colors.green,
                            textAlign: TextAlign.center,
                            text: registerController
                                .profileUserModelResponse!.userName),
                      ),
                      SizedBox(
                        width: 02,
                      ),
                      Footnate(
                        color: Colors.black,
                        textAlign: TextAlign.center,
                        text: AppLocalizations.of(context)!.translate(
                          'nahvinoismaslk',
                        )!,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    (registerController
                                    .profileUserModelResponse!.parentImageUrl !=
                                null &&
                            registerController
                                    .profileUserModelResponse!.parentImageUrl !=
                                "")
                        ? Card(
                            shape: CircleBorder(),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: CachedNetworkImage(
                              height: 75,
                              width: 75,
                              cacheManager: CacheManager(Config(
                                  'customCacheKey',
                                  stalePeriod: Duration(days: 7),
                                  maxNrOfCacheObjects: 100)),
                              imageUrl: registerController.profileUserModelResponse!.parentImageUrl.toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          )
                        : Image.asset(
                            'assets/images/home/user.png',
                            fit: BoxFit.cover,
                            height: 75,
                            width: 75,
                          ),
                    SizedBox(
                      width: 30,
                    ),
                    Subhead(
                      color: Colors.black,
                      text: registerController
                          .profileUserModelResponse!.parentName
                          .toString(),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Subhead(
                        color: Colors.green,
                        text: registerController
                            .profileUserModelResponse!.parentName
                            .toString(),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        width: 02,
                      ),
                      Footnate(
                        color: Colors.black,
                        textAlign: TextAlign.center,
                        text: AppLocalizations.of(context)!.translate(
                          'valad',
                        )!,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 02,
                      ),
                      Footnate(
                        color: Colors.black,
                        textAlign: TextAlign.center,
                        text: AppLocalizations.of(context)!.translate(
                          'rankwellcomemani',
                        )!,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Subhead(
                      color: Colors.green,
                      text: registerController
                          .profileUserModelResponse!.parentName
                          .toString(),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      width: 02,
                    ),
                    Footnate(
                      color: Colors.black,
                      textAlign: TextAlign.right,
                      text: AppLocalizations.of(context)!.translate(
                        'maslkamtiz',
                      )!,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Buttonfull(
                  text: AppLocalizations.of(context)!.translate(
                    'next',
                  )!,
                  onPressed: () => registerController.welcome_btn(),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      );
  }
}
