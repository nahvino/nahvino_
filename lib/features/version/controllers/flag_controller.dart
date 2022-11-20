import 'dart:convert';

import 'package:Nahvino/features/version/service/flag_service.dart';
import 'package:get/get.dart';

class FlagController extends GetxController {

  var fetch;
  RxString country = "Iran".obs;
  RxString countryCode = "IR".obs;
  @override
  void onInit() {
    super.onInit();
    start_service();


  }


  start_service() {
    FlagService.fetchFlags().then((res){
      country.value= json.decode(res)['country'].toString();
      countryCode.value= json.decode(res)['countryCode'].toString() ;
      update();
    });

  }
}