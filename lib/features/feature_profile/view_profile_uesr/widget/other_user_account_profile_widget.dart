import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/OtherUtils/imagedialog.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/controllers/view_profile_user_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

class UserOtherAccountProfileWidget extends StatelessWidget {
  UserOtherAccountProfileWidget({Key? key}) : super(key: key);
  ViewProfileUserController vpu_Controller =
  Get.put(ViewProfileUserController());
  Imageview img = Imageview();
  List<String> ranks = <String>[
    "جوینده",
    "عاشق",
    "عارف",
    "غنی",
    "موحد",
    "خردمند",
    "جاوید",
    "ناجی",
    "نحوینو"
  ];
  List<String> ranksadad = <String>[
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9"
  ];

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


      return Column(children: [
        Container(
          margin: EdgeInsets.only(bottom: 6),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [],
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ( vpu_Controller
                            .userProfileModel!
                            .imageUrl == "null" ||
                            vpu_Controller
                                .userProfileModel!
                                .imageUrl == "" ||
                            vpu_Controller
                                .userProfileModel!
                                .imageUrl == null)
                            ? img.imageAssetProfile(flag: false)
                            : InkWell(
                            child: img.imageProfile(
                                Img:  vpu_Controller
                                    .userProfileModel!.imageUrl
                                    .toString(),
                                flag: false
                              //flag
                            ),
                            onTap: () {
                              showDialog<void>(
                                  context: context,
                                  builder: (context) =>
                                      ImageDialog());
                            }),
                        Column(
                          children: [
                            vpu_Controller
                                .userProfileModel!
                                .nameAlias == null ||
                                vpu_Controller
                                    .userProfileModel!
                                    .nameAlias == ""
                                ? Callout(
                              text: "مهمان",
                              color: theme.secondaryHeaderColor,
                              textAlign: TextAlign.start,
                            )
                                : Subhead(
                              text:  vpu_Controller
                                  .userProfileModel!
                                  .nameAlias,
                              color: theme.secondaryHeaderColor,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 30,
                                  decoration: new BoxDecoration(
                                      borderRadius:
                                      new BorderRadius.circular(8.0),
                                      border: Border.all(
                                          color: theme.secondaryHeaderColor,
                                          width: 1)),
                                  child: InkWell(
                                    onTap: ()=>Get.defaultDialog(title:"مقام",content:Callout(
                                      text: AppLocalizations.of(context)!
                                          .translate(
                                        'Ranks_start',
                                      )!,),),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          padding: EdgeInsets.only(
                                            right: 6,
                                            left: 1,
                                            bottom: 2,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: theme
                                                      .secondaryHeaderColor,
                                                  width: 1)),
                                          child: Callout(
                                            text: ranksadad[
                                            vpu_Controller
                                                .userProfileModel!.rank!
                                                .toInt()],
                                            color: Colors.purpleAccent,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Callout(
                                          text: ranks[ vpu_Controller
                                              .userProfileModel!.rank!
                                              .toInt()],
                                          color: theme.secondaryHeaderColor,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image(
                              height: 30,
                              image: AssetImage(
                                  "assets/images/home/bbarg.png"),
                            ),
                            /*
                          InkWell(
                              child: Image(
                                height: 30,
                                image: AssetImage(
                                    "assets/images/home/bbarg.png"),
                              ),
                              onTap: () {
                                showDialog<void>(
                                    context: context,
                                    builder: (context) => BargDialog(
                                          test: resultResponse!.score
                                              .toString(),
                                        ));
                              }),*/
                            SizedBox(
                              height: 4,
                            ),
                            Callout(
                              text:  vpu_Controller
                                  .userProfileModel!
                                  .score
                                  .toString() /*resultResponse!.score.toString()*/,
                              color: theme.secondaryHeaderColor,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            /*Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.1,
                            ),
                          ),*/

                            Column(
                              children: [
                                /* (resultResponse!.parentImageUrl != null &&
                                    resultResponse!.parentImageUrl != "")*/
                                ( vpu_Controller
                                    .userProfileModel!
                                    .parentImageUrl !=
                                    "null" &&
                                    vpu_Controller
                                        .userProfileModel!
                                        .parentImageUrl !=
                                        "")
                                    ? Card(
                                  shape: CircleBorder(),
                                  clipBehavior: Clip
                                      .antiAliasWithSaveLayer,
                                  child: CachedNetworkImage(
                                    height: 45,
                                    width: 45,
                                    cacheManager: CacheManager(
                                        Config(
                                            'customCacheKey',
                                            stalePeriod:
                                            Duration(
                                                days: 7),
                                            maxNrOfCacheObjects:
                                            100)),
                                    imageUrl:
                                    vpu_Controller
                                        .userProfileModel!
                                        .parentImageUrl.toString(),
                                    imageBuilder: (context,
                                        imageProvider) =>
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    placeholder: (context,
                                        url) =>
                                        CircularProgressIndicator(),
                                    errorWidget:
                                        (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )
                                    : Image.asset(
                                  'assets/images/home/user.png',
                                  fit: BoxFit.cover,
                                  height: 45,
                                  width: 45,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Callout(
                                  text: vpu_Controller
                                      .userProfileModel!.parentName,
                                  color: theme.secondaryHeaderColor,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    //tooltip
                  ],
                ),
                SizedBox(
                  height: 0.5,
                ),
                Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,
                      left: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,
                      bottom: MediaQuery
                          .of(context)
                          .size
                          .height * 0.02,
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.01,
                    ),
                    child:  vpu_Controller
                        .userProfileModel!.bio == null ||
                        vpu_Controller
                            .userProfileModel!.bio == ""
                        ? Callout(
                      text: AppLocalizations.of(context)!.translate(
                        'Your_biography',
                      )!,
                      color: theme.secondaryHeaderColor,
                      textAlign: TextAlign.start,
                    )
                        : Callout(
                      text: vpu_Controller
                          .userProfileModel!.bio,
                      color: theme.secondaryHeaderColor,
                      textAlign: TextAlign.start,
                    )),


              ],
            ),
          ),
        ),
      ],);
  }
}
