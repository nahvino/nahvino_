import 'package:Nahvino/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../App_localizations.dart';
import '../../../LanguageConstants.dart';
import '../../../Services/login/ApiService.dart';
import '../../../Utils/Button/SttingMenusButton.dart';
import '../../../Utils/Text/Text.dart';
import '../../../language.dart';
import '../Login/SignUp.dart';
import 'ChangePhoneNumber.dart';
import 'ChangePasswrod.dart';
import 'Notifications.dart';
import 'SetPhoneNumber.dart';
import 'ViewProfile.dart';


class UserSecuritySttingMenus extends StatefulWidget {
  const UserSecuritySttingMenus({Key? key}) : super(key: key);

  @override
  State<UserSecuritySttingMenus> createState() =>
      _UserSecuritySttingMenusState();
}

class _UserSecuritySttingMenusState extends State<UserSecuritySttingMenus> {
  bool isApiCallProgress = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  var resultResponse;
  var resultResponsepro;
  late bool phoneNumber;
  late bool password;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
           APIService.UserSecuritySttingMenus().then((response) {
        print("APIService.UserSecuritySttingMenus => $response");
        setState(() {
          isApiCallProgress = false;
          resultResponse = response;
        });
      });

    }).onError((error, stackTrace) {
      print(error);
    });

    APIService.profilleall().then((response) {
      print("APIService.profilleall => $response");
    /*  setState(() {
        isApiCallProgress = false;
        resultResponsepro = response;
      });*/
      if (response != null) {
        resultResponsepro = response ?? "اطلاعات یافت نشد";
      } else {
        setState(() {
          isApiCallProgress = false;
          resultResponsepro = response;
        });
      }
    });

  }

  bool lang = false; // en => true / fa => false
  void changeLanguage(Language language) async {
    Locale locale = (await setLocale(language.languageCode)) as Locale;
    MyApp.setLocale(context, locale);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
            child: isApiCallProgress
                ? Center(
                    child: Lottie.asset('assets/anim/data.json',
                        height: 300, width: 300),
                  )
                : body(context)),
      ),
    );
  }

  Widget body(BuildContext context) => Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Container(
                      child: BackButton(
                        onPressed: (() {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => ViewProfile()));
                        }),
                      ),
                    ),
                   Container(
                     alignment: Alignment.topRight,
                     padding: EdgeInsets.only(
                        bottom: 4),
                     child: textbold(
                       textAlign: TextAlign.right,
                       text: resultResponsepro['userName'] ?? "",
                       color: Colors.black,
                     ),
                   ),
                 ],
               ),


                    Container(
                      height: 30,
                      child: PopupMenuButton<int>(
                        icon: Icon(Icons.menu ,),
                        itemBuilder: (context) =>
                        [
                       /*   PopupMenuItem(
                            value: 0,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.security,
                                  color: Colors.cyan,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                textspan(
                                  textAlign: TextAlign.start,
                                  text: AppLocalizations.of(context)!
                                      .translate(
                                    'Security_settings',
                                  )!,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),*/
                         /* PopupMenuDivider(height: 4),
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.notifications,
                                  color: Colors.cyan,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                textspan(
                                  textAlign: TextAlign.end,
                                  color: Colors.black,
                                  text: AppLocalizations.of(context)!
                                      .translate(
                                    'Notifications',
                                  )!,
                                ),
                              ],
                            ),
                          ),*/
                       //   PopupMenuDivider(height: 1),
                          PopupMenuItem(
                            value: 4,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Caption1(
                                  textAlign: TextAlign.center,
                                  color: Colors.black,
                                  text: AppLocalizations.of(context)!
                                      .translate(
                                    'YCTIANM',
                                  )!,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.share,
                                  color: Colors.cyan,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                textspan(
                                  textAlign: TextAlign.center,
                                  text:resultResponsepro['identifierCode']
                                      .toString(),
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                              ],
                            ),
                          ),
                          PopupMenuDivider(),
                          PopupMenuItem(
                            value: 3,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                              Image.asset('assets/images/icon/pngwing.com.png',height: 24,width: 24,color: Colors.cyan),
                            //Image(image: AssetImage('graphics/background.png')),
                                SizedBox(
                                  width: 8,
                                ),
                                textspan(
                                  textAlign: TextAlign.center,
                                  color: Colors.black,
                                  text: AppLocalizations.of(context)!
                                      .translate(
                                    'Eixt',
                                  )!,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (item) => onSelected(context, item),
                      ),
                    ),
              ]),
              Container(
                alignment: Alignment.topCenter,

                child: Column(
                  children: [
                    Title2(
                      textAlign: TextAlign.center,
                      text: AppLocalizations.of(context)!.translate(
                        'Security_settings',
                      )!,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Visibility(
                visible: resultResponse['password'],
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(
                          Icons.lock,
                          color: Colors.blue,
                        ),
                        MenusSttingButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangePasswrod()));
                            },
                            text: 'تغییر رمز عبور'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30,left: 30),
                      child: Divider(
                        height: 0,
                        thickness: 0.3,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Visibility(
                visible: resultResponse['password'],
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10,),

                        Icon(
                          Icons.phone_android,
                          color: Colors.blue,
                        ),
                        MenusSttingButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SetPhoneNumber()));
                            },

                            text: 'موبایل'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30,left: 30),
                      child: Divider(
                        height: 0,
                        thickness: 0.3,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5,),
              Visibility(
                visible: resultResponse['phoneNumber'],
                child:
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(
                          Icons.phonelink_setup,
                          color: Colors.blue,
                        ),
                        MenusSttingButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangePhoneNumber()));
                            },
                            text: 'تغییر شماره تلفن'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30,left: 30),
                      child: Divider(
                        height: 0,
                        thickness: 0.3,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
              ),

             /* SttingMenusButton(
                  onPressed: () => AppLocalizations.of(context)?.setLocale(Locale.fromSubtags(languageCode: 'en')),
                  icon: Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  text: 'تغییر زبان'),*/
          /*    DropdownButton<Language>(
                underline: SizedBox(),
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                onChanged: (Language? language) {
                  changeLanguage(language!);
                },
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                    value: e,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          e.flag,
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(e.name)
                      ],
                    ),
                  ),
                )
                    .toList(),
              ),*/
            ],
          )
        ],
      );

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Notifications()));
        break;
      case 2:
        Share.share(resultResponsepro['identifierCode'].toString() +" \n این عدد کد معرف من در نحوینو می باشد. اگر هنگام ثبت نام از این کد استفاده کنید ده شاهپر به شما اهدا میکنم و راهنمای شما در این مسلک زیبا خواهم بود");

        break;
      case 3:
        showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                  title: Text(AppLocalizations.of(context)!.translate(
                    'apptitle',
                  )!),
                  content: Text(AppLocalizations.of(context)!.translate(
                    'quExit',
                  )!),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(
                              context,
                              AppLocalizations.of(context)!.translate(
                                'Cancel',
                              )!),
                      child: Text(
                        AppLocalizations.of(context)!.translate(
                          'Cancel',
                        )!,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final preferences = await SharedPreferences
                            .getInstance();
                        await preferences.clear();
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          //exit(0);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>SignUp()),
                                (route) => false,
                          );
                        });
                      },
                      child: Text(AppLocalizations.of(context)!.translate(
                        'OK',
                      )!),
                    ),
                  ]),
        );
        break;
      case 4:
        Share.share(resultResponsepro['identifierCode'].toString() +" \n این عدد کد معرف من در نحوینو می باشد. اگر هنگام ثبت نام از این کد استفاده کنید ده شاهپر به شما اهدا میکنم و راهنمای شما در این مسلک زیبا خواهم بود");

        break;
    }
  }
}
