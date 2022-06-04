import 'package:Nahvino/Services/config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../Services/Login/ApiService.dart';
import '../../../Utils/Text/Text.dart';
import '../Caht/ChatPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ViewProfileUesr extends StatefulWidget {
  const ViewProfileUesr({Key? key, this.userid}) : super(key: key);
  final userid;

  @override
  State<ViewProfileUesr> createState() => _ViewProfileUesrState();
}

class _ViewProfileUesrState extends State<ViewProfileUesr> {
  bool isApiCallProgress = true;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  var resultResponseViewProfileUesr;
  late Map<String, dynamic> resultResponseGetLastOtherVisit;
  var resultResponseGetUserAbandon;
  late APIService apiService;
  String? imagePath;
  String tarikh = "تاریخ";
  String date = "1408/10/12 20:12:00";

  List<String> ranks = <String>[
    "مبتدی",
    "رهجو",
    "ره رو",
    "رهنورد",
    "راهنما",
    "راه بلد",
    "حامی",
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

  List<Widget> ranksadadA = <Widget>[
    Lottie.asset('assets/anim/phonix/level1.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level2.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level3.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level4.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level5.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level6.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level7.json', fit: BoxFit.cover),
    Lottie.asset('assets/anim/phonix/level8.json', fit: BoxFit.cover),
  ];

  @override
  void initState() {
    super.initState();
    apiService = APIService(context);
    Future.microtask(() {
      APIService.GetProfileOtherUser(widget.userid.toString()).then((response) {
        resultResponseViewProfileUesr = response;
        print("test-----------> $resultResponseViewProfileUesr");
        APIService.GetLastOtherVisit(widget.userid.toString()).then((response) {
          resultResponseGetLastOtherVisit = response;
          print(" قوقوی---------------------------- => $response");
          APIService.getuserabandonViewProfileUesr(widget.userid.toString())
              .then((response) {
            print("تاریخ ترک ------------- => $response");
            setState(() {
              isApiCallProgress = false;

              resultResponseGetUserAbandon = response;
            });
          });
        });
      });
    });
  }

  bool lang = false; // en => true / fa => false
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: //body(context)
            SafeArea(
                child: isApiCallProgress
                    ? Center(
                        child: Lottie.asset('assets/anim/loading/loading.json',
                            height: 300, width: 300),
                      )
                    : body(context)),
      ),
    );
  }

  Widget body(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.only(bottom: 6),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              textbold(
                                textAlign: TextAlign.right,
                                text: resultResponseViewProfileUesr['userName'],
                                color: Colors.black,
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  height: 30,
                                  child: BackButton(
                                    onPressed: (() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Chatpage()));
                                    }),
                                  ),
                                ),
                              ),
                            ]),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            /*   textbold(
                            textAlign: TextAlign.right,
                            text: resultResponseViewProfileUesr['userName'],
                            color: Colors.black,
                          ),*/
                            (resultResponseViewProfileUesr['imageUrl'] !=
                                        null &&
                                    resultResponseViewProfileUesr['imageUrl'] !=
                                        "")
                                ? Card(
                              shape: CircleBorder(),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: CachedNetworkImage(
                                height: 75,
                                width: 75,
                                cacheManager: CacheManager(Config('customCacheKey',
                                    stalePeriod: Duration(days: 7), maxNrOfCacheObjects: 100)),
                                imageUrl: configss.fileurl + resultResponseViewProfileUesr[
                                'imageUrl']!,
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ): Image.asset(
                              'assets/images/home/user.png',
                              fit: BoxFit.cover,
                              height: 75,
                              width: 75,
                            ),
                            /*Card(
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image.network(
                                      configss.fileurl +
                                          resultResponseViewProfileUesr[
                                              'imageUrl']!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const Icon(Icons.person);
                                      },
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
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
                                      height: 75,
                                      width: 75,
                                    ),
                                  )
                                : Image.asset(
                                    'assets/images/home/user.png',
                                    fit: BoxFit.cover,
                                    height: 75,
                                    width: 75,
                                  ),*/
                          ],
                        ),
                        Column(
                          children: [
                            textbold(
                              text:
                                  resultResponseViewProfileUesr['nameAlias'] ??
                                      "",
                              color: Colors.green,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 80,
                              height: 30,
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  border: Border.all(
                                      color: Colors.black26, width: 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.black26, width: 1)),
                                    child: textspan(
                                      text: ranksadad[
                                          resultResponseViewProfileUesr[
                                              'rank']],
                                      color: Colors.purpleAccent,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  textspan(
                                    text: ranks[
                                        resultResponseViewProfileUesr['rank']],
                                    color: Colors.black,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image(
                              height: 30,
                              image: AssetImage("assets/images/home/bbarg.png"),
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
                              height: 5,
                            ),
                            textspan(
                              text: resultResponseViewProfileUesr['score']
                                  .toString(),
                              color: Colors.black,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            (resultResponseViewProfileUesr['parentImageUrl'] !=
                                        null &&
                                    resultResponseViewProfileUesr[
                                            'parentImageUrl'] !=
                                        "")
                                ? Card(
                              shape: CircleBorder(),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: CachedNetworkImage(
                                height: 45,
                                width: 45,
                                cacheManager: CacheManager(Config('customCacheKey',
                                    stalePeriod: Duration(days: 7), maxNrOfCacheObjects: 100)),
                                imageUrl: configss.fileurl + resultResponseViewProfileUesr[
                                'parentImageUrl']!,
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ): Image.asset(
                              'assets/images/home/user.png',
                              fit: BoxFit.cover,
                              height: 45,
                              width: 45,
                            ),

                            /* Card(
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image.network(
                                      configss.fileurl +
                                          resultResponseViewProfileUesr[
                                              'parentImageUrl']!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const Icon(Icons.person);
                                      },
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
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
                                      height: 30,
                                      width: 30,
                                    ),
                                  )
                                : Image.asset(
                                    'assets/images/home/user.png',
                                    fit: BoxFit.cover,
                                    height: 30,
                                    width: 30,
                                  ),*/
                            /*    InkWell(
                              onTap: () {

                                showDialog<void>(
                                    context: context,
                                    builder: (context) => ArshadDialog());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black12),
                                height: 30,
                                width: 30,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/ram/man1.jpg")),
                              ),
                            ),*/
                            SizedBox(
                              height: 4,
                            ),
                            textspan(
                              text: resultResponseViewProfileUesr['parentName'],
                              color: Colors.black,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.height * 0.03,
                        bottom: MediaQuery.of(context).size.height * 0.02,
                        top: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: textspan(
                        text: resultResponseViewProfileUesr['bio'] ?? "",
                        color: Colors.black,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 150,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: const [
                            BoxShadow(color: Colors.cyan, spreadRadius: 2),
                          ],
                        ),
                        child:
                            ranksadadA[resultResponseGetLastOtherVisit['data']],
                      ),
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: const [
                          BoxShadow(color: Colors.cyan, spreadRadius: 2),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            Footnate(
                              textAlign: TextAlign.center,
                              color: Colors.cyan,
                              text: "مدت پاکی:",
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Footnate(
                                      textAlign: TextAlign.center,
                                      color: Colors.cyan,
                                      text: resultResponseGetUserAbandon['data']
                                          .split(" ")[0]
                                          .toString(),
                                    ),
                                    Caption2(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text: "سال"),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    Footnate(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text:
                                            resultResponseGetUserAbandon['data']
                                                .toString()
                                                .split(" ")[1]
                                                .toString()),
                                    Caption2(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text: "ماه"),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    Footnate(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text:
                                            resultResponseGetUserAbandon['data']
                                                .toString()
                                                .split(" ")[2]
                                                .toString()),
                                    Caption2(
                                        textAlign: TextAlign.center,
                                        color: Colors.cyan,
                                        text: "روز"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*   Body(
                textAlign: TextAlign.center,
                color: Colors.cyan,
                text: widget.userid.toString()),*/
          ],
        ),
      );
}
