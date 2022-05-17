import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../App_localizations.dart';
import '../../../Model/User/SignalR/GroupModel.dart';
import '../../../Services/Login/User/Config.dart';
import '../../../Utils/Text/Text.dart';
import 'ChatPage.dart';

class AboutGroup extends StatefulWidget {

  final GroupModel model;
  const AboutGroup({Key? key, required this.model}) : super(key: key);

  @override
  State<AboutGroup> createState() => _AboutGroupState();
}

class _AboutGroupState extends State<AboutGroup> {
  bool isApiCallProgress = true;
  bool lang = false; // en => true / fa => false
  bool isSwitched = false;



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
                                image: AssetImage(
                                    "assets/images/ram/gorp.png"),
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
                        text: widget.model.name?? AppLocalizations.of(context)!.translate(
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
                                Column(
                                  children: [
                                  /*  Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "assets/images/ram/man1.jpg"),
                                          ),
                                          shape: BoxShape.circle,
                                          color: Colors.redAccent),
                                      height: 50,
                                      width: 50,
                                    ),*/

                                    (widget.model.adminImageurl != null &&
                                        widget.model.adminImageurl != "")
                                        ? Card(
                                      shape: CircleBorder(),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image.network(
                                        Config.fileurl + widget.model.adminImageurl!,
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
                                    ),
                                    Callout(color: Colors.black, textAlign: TextAlign.center, text:widget.model.adminName!)

                                  ],
                                ),
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
                              Column(
                                children: [
                                  (widget.model.supervisor1Imageurl != null &&
                                      widget.model.supervisor1Imageurl != "")
                                      ? Card(
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image.network(
                                      Config.fileurl + widget.model.supervisor1Imageurl!,
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
                                  ),
                                  Callout(color: Colors.black, textAlign: TextAlign.center, text:widget.model.supervisor1Name!)

                                ],
                              ),
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
                                Column(
                                  children: [
                                    (widget.model.supervisor2Imageurl != null &&
                                        widget.model.supervisor2Imageurl != "")
                                        ? Card(
                                      shape: CircleBorder(),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image.network(
                                        Config.fileurl + widget.model.supervisor2Imageurl!,
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
                                    ),
                                    Callout(color: Colors.black, textAlign: TextAlign.center, text:widget.model.supervisor2Name!)
                                  ],
                                ),
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
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
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
