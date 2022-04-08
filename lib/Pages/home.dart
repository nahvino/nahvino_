import 'package:flutter/material.dart';

import '../Services/login/api_service.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({Key? key}) : super(key: key);

  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  var resultResponsee;
  bool isApiCallProgress = true;

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
    return Container(
        child: Text("dd")
    );
  }
}


  
