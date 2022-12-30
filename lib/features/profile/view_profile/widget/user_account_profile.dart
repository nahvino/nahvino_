import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/OtherUtils/imagedialog.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/profile/edit_profile/screen/edit_profile_screen.dart';
import 'package:Nahvino/features/profile/view_profile/controllers/profile_controller.dart';
import 'package:Nahvino/features/profile/view_profile/data/view_profial_data.dart';
import 'package:Nahvino/features/profile/view_profile_uesr/screen/view_profile_uesr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

class UserAcconutProfile extends StatelessWidget {
   UserAcconutProfile({Key? key}) : super(key: key);
  ViewProfileController databox = Get.put(ViewProfileController());
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ViewProfileController databox = Get.put(ViewProfileController());
    ProfileController profile_Controller = Get.put(ProfileController());

    return Obx(() {
  return Column(children: [
      Card(
        margin: EdgeInsets.only(bottom: 6),
        elevation: 0,
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
                      (databox.imageUrl.value == "null" ||
                          databox.imageUrl.value == ""||
                          databox.imageUrl.value == null)
                          ? img.imageAssetProfile(flag: false)
                          : InkWell(
                          child: img.imageProfile(
                              Img: databox.imageUrl.value,
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
                          databox.namealias.value == "null" ||
                              databox.namealias.value == ""
                              ? Callout(
                            text: "مهمان",
                          //  color: Colors.black38,
                            textAlign: TextAlign.start,
                          )
                              : Subhead(
                            text: databox.namealias.value,
                           // color: Colors.teal,
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
                                        color: Colors.black26,
                                        width: 1)),
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
                                              color: Colors.black26,
                                              width: 1)),
                                      child: Callout(
                                        text: ranksadad[
                                        databox.rank.value],
                                        color: Colors.purpleAccent,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Callout(
                                      text: ranks[databox.rank.value],
                                      color: Colors.black,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
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
                            text: databox.score.value
                                .toString() /*resultResponse!.score.toString()*/,
                            color: Colors.black,
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewProfileUesr(
                                              userid: databox.parentId
                                                  .value /*resultResponse!.parentId*/,
                                            )));
                              },
                              child: Column(
                                children: [
                                  /* (resultResponse!.parentImageUrl != null &&
                                        resultResponse!.parentImageUrl != "")*/
                                  (databox.parentimageurl.value !=
                                      "null" &&
                                      databox.parentimageurl
                                          .value !=
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
                                          databox.parentimageurl
                                              .value /*resultResponse!.parentImageUrl!*/,
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
                                    text: databox.parentname.value,
                               //     color: Colors.teal,
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
                            itemBuilder: (context) => [
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
                                        text:AppLocalizations.of(context)!.translate(
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
                            itemBuilder: (context) => [
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
                                        AppLocalizations.of(context)!.translate(
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
                            itemBuilder: (context) => [
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
                                       AppLocalizations.of(context)!.translate(
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
                    right: MediaQuery.of(context).size.height * 0.03,
                    left: MediaQuery.of(context).size.height * 0.03,
                    bottom: MediaQuery.of(context).size.height * 0.02,
                    top: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: databox.bio.value == "null" ||
                      databox.bio.value == ""
                      ? Callout(
                    text: AppLocalizations.of(context)!.translate(
                      'Your_biography',
                    )!,
                    color: Colors.black38,
                    textAlign: TextAlign.start,
                  )
                      : Callout(
                    text: databox.bio.value,
                    color: Colors.black,
                    textAlign: TextAlign.start,
                  )),
              SizedBox(
                height: 1,
              ),
              Buttonfull(
                text: AppLocalizations.of(context)!.translate(
                  'Edit Profile',
                )!,
                onPressed: () => Get.to(EditProfileScreen()),
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
