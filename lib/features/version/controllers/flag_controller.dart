import 'package:Nahvino/features/version/service/flag_service.dart';
import 'package:get/get.dart';

class FlagController extends GetxController {

  var fetch;
  @override
  void onInit() {
    super.onInit();
    start_service();
  }


  start_service() {
    FlagService.fetchFlags().then((value){
      fetch =value;
      print("====<>====");
      print(fetch);
    });

  }
}