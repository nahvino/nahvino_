import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../App_localizations.dart';
import '../../../Model/User/SignalR/GroupModel.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Services/config.dart';
import '../../../Utils/Text/Text.dart';
import '../../../controllers/getx/aboutgroupcontroller.dart';
import '../User/ViewProfileUesr.dart';
import 'ChatPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AboutGroup extends StatefulWidget {
  final GroupModel model;
  const AboutGroup({Key? key, required this.model}) : super(key: key);

  @override
  State<AboutGroup> createState() => _AboutGroupState();
}

class _AboutGroupState extends State<AboutGroup> {
  bool isApiCallProgress = true;
  bool lang = false; // en => true / fa => false
  bool? isSwitched = false;
  late APIService apiService;
  AboutGroupController noti = Get.put(AboutGroupController());
  GetStorage reqtokenapi = GetStorage();

  @override
  void initState() {
    GetStorage.init();
    super.initState();
    apiService = APIService(context);
    getSwitchValues();
  }

  getSwitchValues() async {
    isSwitched = (await getSwitchState())!;
    setState(() {});
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);
    print('Switch Value saved $value');
    return prefs.setBool("switchState", value);
  }

  Future<bool?> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("switchState") == null) {
      isSwitched = false;
    }
    if (prefs.getBool("switchState") != null) {
      isSwitched = prefs.getBool("switchState");
    }
    print(isSwitched);

    return isSwitched;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(child: body(context)),
        /*isApiCallProgress
                ? Center(
                    child: Lottie.asset('assets/anim/phonix_storok.json',
                        height: 300, width: 300),
                  )
                : body(context)),*/
      ),
    );
  }

  Widget body(BuildContext context) => Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/ram/gorp.png"),
                              ),
                              shape: BoxShape.circle,
                              color: Colors.transparent),
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Title2(
                        textAlign: TextAlign.end,
                        color: Colors.black,
                        text: widget.model.name ??
                            AppLocalizations.of(context)!.translate(
                              'GroupAboutName',
                            )!,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: BackButton(
                          onPressed: (() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Chatpage()));
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Subhead(
                                  textAlign: TextAlign.end,
                                  color: Colors.purpleAccent,
                                  text: AppLocalizations.of(context)!.translate(
                                    'GroupOower',
                                  )!,
                                ),
                                InkWell(
                                    child: Column(
                                      children: [
                                        (widget.model.adminImageurl != null &&
                                                widget.model.adminImageurl !=
                                                    "")
                                            ? Card(
                                                shape: CircleBorder(),
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                child: CachedNetworkImage(
                                                  height: 50,
                                                  width: 50,
                                                  cacheManager: CacheManager(
                                                      Config(
                                                          'customCacheKey',
                                                          stalePeriod:
                                                              Duration(days: 7),
                                                          maxNrOfCacheObjects:
                                                              100)),
                                                  imageUrl: configss.fileurl +
                                                      widget
                                                          .model.adminImageurl!,
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
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              )
                                            : Image.asset(
                                                'assets/images/home/user.png',
                                                fit: BoxFit.cover,
                                                height: 50,
                                                width: 50,
                                              ),

                                        /*Card(
                                        shape: CircleBorder(),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        child: Image.network(
                                          configss.fileurl + widget.model.adminImageurl!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return const Icon(Icons.person);
                                          },
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                    .expectedTotalBytes !=
                                                    null
                                                    ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                          height: 50,
                                          width: 50,
                                        ),
                                      )
                                          : Image.asset(
                                        'assets/images/home/user.png',
                                        fit: BoxFit.cover,
                                        height: 50,
                                        width: 50,
                                      ),*/
                                        Callout(
                                            color: Colors.teal,
                                            textAlign: TextAlign.center,
                                            text: widget.model.adminName!)
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewProfileUesr(
                                                      userid: widget
                                                          .model.adminId)));
                                    }),
                              ],
                            ),
                            Column(children: [
                              Subhead(
                                textAlign: TextAlign.end,
                                color: Colors.purpleAccent,
                                text: AppLocalizations.of(context)!.translate(
                                  'GroupAdmin1',
                                )!,
                              ),
                              InkWell(
                                  child: Column(
                                    children: [
                                      (widget.model.supervisor1Imageurl !=
                                                  null &&
                                              widget.model
                                                      .supervisor1Imageurl !=
                                                  "")
                                          ? Card(
                                              shape: CircleBorder(),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              child: CachedNetworkImage(
                                                height: 50,
                                                width: 50,
                                                cacheManager: CacheManager(
                                                    Config('customCacheKey',
                                                        stalePeriod:
                                                            Duration(days: 7),
                                                        maxNrOfCacheObjects:
                                                            100)),
                                                imageUrl: configss.fileurl +
                                                    widget.model
                                                        .supervisor1Imageurl!,
                                                imageBuilder:
                                                    (context, imageProvider) =>
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
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            )
                                          : Image.asset(
                                              'assets/images/home/user.png',
                                              fit: BoxFit.cover,
                                              height: 50,
                                              width: 50,
                                            ),
                                      /*Card(
                                      shape: CircleBorder(),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image.network(
                                        configss.fileurl + widget.model.supervisor1Imageurl!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return const Icon(Icons.person);
                                        },
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                  .expectedTotalBytes !=
                                                  null
                                                  ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                        height: 50,
                                        width: 50,
                                      ),
                                    )
                                        : Image.asset(
                                      'assets/images/home/user.png',
                                      fit: BoxFit.cover,
                                      height: 50,
                                      width: 50,
                                    ),*/
                                      Callout(
                                          color: Colors.teal,
                                          textAlign: TextAlign.center,
                                          text: widget.model.supervisor1Name!)
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewProfileUesr(
                                                    userid: widget
                                                        .model.supervisor1Id)));
                                  }),
                            ]),
                            Column(
                              children: [
                                Subhead(
                                  textAlign: TextAlign.end,
                                  color: Colors.purpleAccent,
                                  text: AppLocalizations.of(context)!.translate(
                                    'GroupAdmin2',
                                  )!,
                                ),
                                InkWell(
                                    child: Column(
                                      children: [
                                        (widget.model.supervisor2Imageurl !=
                                                    null &&
                                                widget.model
                                                        .supervisor2Imageurl !=
                                                    "")
                                            ? Card(
                                                shape: CircleBorder(),
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                child: CachedNetworkImage(
                                                  height: 50,
                                                  width: 50,
                                                  cacheManager: CacheManager(
                                                      Config(
                                                          'customCacheKey',
                                                          stalePeriod:
                                                              Duration(days: 7),
                                                          maxNrOfCacheObjects:
                                                              100)),
                                                  imageUrl: configss.fileurl +
                                                      widget.model
                                                          .supervisor2Imageurl!,
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
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              )
                                            : Image.asset(
                                                'assets/images/home/user.png',
                                                fit: BoxFit.cover,
                                                height: 50,
                                                width: 50,
                                              ),
                                        /*Card(
                                        shape: CircleBorder(),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        child: Image.network(
                                          configss.fileurl + widget.model.supervisor2Imageurl!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return const Icon(Icons.person);
                                          },
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                    .expectedTotalBytes !=
                                                    null
                                                    ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                          height: 50,
                                          width: 50,
                                        ),
                                      )
                                          : Image.asset(
                                        'assets/images/home/user.png',
                                        fit: BoxFit.cover,
                                        height: 50,
                                        width: 50,
                                      ),*/
                                        Callout(
                                            color: Colors.teal,
                                            textAlign: TextAlign.center,
                                            text: widget.model.supervisor2Name!)
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewProfileUesr(
                                                      userid: widget.model
                                                          .supervisor2Id)));
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Subhead(
                            textAlign: TextAlign.end,
                            color: Colors.purpleAccent,
                            text: AppLocalizations.of(context)!.translate(
                              'Groupmembers',
                            )!,
                          ),
                          SizedBox(width: 2),
                          Text(widget.model.userCount.toString()),
                          SizedBox(width: 2),
                          Subhead(
                            textAlign: TextAlign.end,
                            color: Colors.purpleAccent,
                            text: AppLocalizations.of(context)!.translate(
                              'GroupPerson',
                            )!,
                          ),
                        ],
                      ),
                      SizedBox(height: 17),
                      Divider(
                        height: 0,
                        thickness: 2,
                        color: Colors.black,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Footnate(
                            textAlign: TextAlign.end,
                            color: Colors.black,
                            text: AppLocalizations.of(context)!.translate(
                              'GroupMute',
                            )!,
                          ),
                          Switch(
                              value: isSwitched!,
                              onChanged: (bool values) {
                                setState(() {
                                  if (isSwitched = values) {
                                    isSwitched = values;
                                    APIService.deletetokenapi()
                                        .then((response) {
                                      print(
                                          "deletetokenapi---------------------------- => $response");
                                    });
                                    saveSwitchState(values);
                                  } else {
                                    values = false;
                                    APIService.notificationaApi()
                                        .then((response) {
                                      print(
                                          "Notfiiiiiiiiiiiiiiiii---------------------------- => $response");
                                    });
                                    saveSwitchState(values);
                                  }
                                });
                              }),
                        ],
                      ),
                      Divider(
                        height: 0,
                        thickness: 2,
                        color: Colors.black,
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Footnate(
                            textAlign: TextAlign.end,
                            color: Colors.black,
                            text: AppLocalizations.of(context)!.translate(
                              'GroupShare',
                            )!,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: Icon(
                              Icons.share,
                              color: Colors.cyan,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Divider(
                        height: 0,
                        thickness: 2,
                        color: Colors.black,
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Subhead(
                            textAlign: TextAlign.end,
                            color: Colors.purpleAccent,
                            text: AppLocalizations.of(context)!.translate(
                              'GroupRules',
                            )!,
                          ),
                          SizedBox(width: 3),
                          Caption1(
                            textAlign: TextAlign.end,
                            color: Colors.black,
                            text: AppLocalizations.of(context)!.translate(
                              'GroupRulesText',
                            )!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [],
              ),
            ],
          ),
        ],
      );
}
