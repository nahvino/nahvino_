import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/OtherUtils/imagedialog.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/feature_profile/edit_profile/screen/edit_profile_screen.dart';
import 'package:Nahvino/features/feature_profile/view_profile/controllers/profile_controller.dart';
import 'package:Nahvino/features/feature_profile/view_profile/data/view_profial_data.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/controllers/view_profile_user_controller.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/screen/view_profile_user_screen.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/screen/view_profile_uesr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

class UserAcconutProfile extends StatelessWidget {
  UserAcconutProfile({Key? key}) : super(key: key);
  ProfileController profile_Controller = Get.put(ProfileController());
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

    return Obx(() {
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
                        (profile_Controller.profileUserModelResponse!
                            .imageUrl == "null" ||
                            profile_Controller.profileUserModelResponse!
                                .imageUrl == "" ||
                            profile_Controller.profileUserModelResponse!
                                .imageUrl == null)
                            ? img.imageAssetProfile(flag: false)
                            : InkWell(
                            child: img.imageProfile(
                                Img: profile_Controller
                                    .profileUserModelResponse!.imageUrl
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
                            profile_Controller.profileUserModelResponse!
                                .nameAlias == null ||
                                profile_Controller.profileUserModelResponse!
                                    .nameAlias == ""
                                ? Callout(
                              text: "مهمان",
                              color: theme.secondaryHeaderColor,
                              textAlign: TextAlign.start,
                            )
                                : Subhead(
                              text: profile_Controller.profileUserModelResponse!
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
                                            profile_Controller
                                                .profileUserModelResponse!.rank!
                                                .toInt()],
                                            color: Colors.purpleAccent,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Callout(
                                          text: ranks[profile_Controller
                                              .profileUserModelResponse!.rank!
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
                              text: profile_Controller.profileUserModelResponse!
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

                            InkWell(
                                onTap: () {
                                  /*showDialog<void>(
                                  context: context,
                                  builder: (context) => /*ArshadDialog()*/ ViewProfileUesr(userid: resultResponse!.parentId,));*/
                                  /*    showDialog<void>(
                                  context: context,
                                  builder: (context) => ViewProfileUesrArshed(
                                        userid: resultResponse!.parentId,
                                      ));*/
                                 // ViewProfileUserController().start(profile_Controller.profileUserModelResponse!.parentId.toString());

                                  //profile_Controller.get_prant_view();
                                  Get.to(() => ViewProfileUserScreen());

                                  /*
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewProfileUesr(
                                                userid: profile_Controller
                                                    .profileUserModelResponse!
                                                    .parentId /*resultResponse!.parentId*/,
                                              )));*/
                                },
                                child: Column(
                                  children: [
                                    /* (resultResponse!.parentImageUrl != null &&
                                        resultResponse!.parentImageUrl != "")*/
                                    (profile_Controller
                                        .profileUserModelResponse!
                                        .parentImageUrl !=
                                        "null" &&
                                        profile_Controller
                                            .profileUserModelResponse!
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
                                        profile_Controller
                                            .profileUserModelResponse!
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
                                      text: profile_Controller
                                          .profileUserModelResponse!.parentName,
                                      color: theme.secondaryHeaderColor,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                    //tooltip
                    Positioned(
                      bottom: width * 0.04,
                      right: width * 0.44,
                      child: Visibility(
                          visible: profile_Controller.help.value,
                          child: PopupMenuButton<int>(
                              color: Colors.deepOrange,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15)),
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
                                          text: AppLocalizations.of(context)!
                                              .translate(
                                            'Ranks_start',
                                          )!,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ])),
                    ),
                    Positioned(
                      bottom: width * 0.09,
                      right: width * 0.63,
                      child: Visibility(
                          visible: profile_Controller.help.value,
                          child: PopupMenuButton<int>(
                              color: Colors.deepOrange,
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15)),
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
                                          text:
                                          AppLocalizations.of(context)!
                                              .translate(
                                            'privilege_in_the_world',
                                          )!,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ])),
                    ),
                    Positioned(
                      top: width * 0.08,
                      right: width * 0.83,
                      child: Visibility(
                          visible: profile_Controller.help.value,
                          child: PopupMenuButton<int>(
                              elevation: 1,
                              color: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15)),
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
                                          text:
                                          AppLocalizations.of(context)!
                                              .translate(
                                            'senior_person',
                                          )!,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ])),
                    ),
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
                    child: profile_Controller
                        .profileUserModelResponse!.bio == null ||
                        profile_Controller
                            .profileUserModelResponse!.bio == ""
                        ? Callout(
                      text: AppLocalizations.of(context)!.translate(
                        'Your_biography',
                      )!,
                      color: theme.secondaryHeaderColor,
                      textAlign: TextAlign.start,
                    )
                        : Callout(
                      text: profile_Controller
                          .profileUserModelResponse!.bio,
                      color: theme.secondaryHeaderColor,
                      textAlign: TextAlign.start,
                    )),
                SizedBox(
                  height: 1,
                ),
                Buttonfull(
                  text: AppLocalizations.of(context)!.translate(
                    'Edit Profile',
                  )!,
                  onPressed: () => Get.to(() => EditProfileScreen()),
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ],);
    });
  }
}
