import 'package:flutter/material.dart';
import '../Services/login/ApiService.dart';


class HomeScren extends StatefulWidget {
  const HomeScren({Key? key}) : super(key: key);

  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  var resultResponsee;
  bool isApiCallProgress = true;
  String messageTitle = "Empty";
  String notificationAlert = "alert";
 // late final FirebaseMessaging _messaging;
//  late int _totalNotifications;



  @override
  void initState() {
    super.initState();
    APIService.GetLastVisit().then((response) {
      setState(() {
        isApiCallProgress = false;
        resultResponsee = response;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            notificationAlert,
          ),
          Text(
            messageTitle,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
