import 'package:Nahvino/features/profile/view_profile/service/profile_service.dart';
import 'package:get/get.dart';

class UserAbandonController extends GetxController{
  var resultResponseGetUserAbandon;
   RxInt day = 0.obs;
   RxInt month=0.obs;
   RxInt year=0.obs;
  var flag;
  RxString date = "0".obs;
  RxString mont = "0".obs;
  RxString yaer = "0".obs;
  @override
  void onInit() {
    super.onInit();
    start_service();

  }


  start_service(){
    ProfileService.getabandon().then((response) async {
      print("------<getuserabandon>------- => $response");
      resultResponseGetUserAbandon = response;
      receive();
    });
  }
  Day() {
    double dotabdel = day.toDouble();
    double range = 0.00;
    late double a = range;
    for (double i = 0.00; i <= dotabdel / 29.00; i += 0.037) {
      range = i;
    }
    return a;
  }

  Month() {
    double dotabdel = month.toDouble();
    double range = 0.00;
    late double a = range;
    for (double i = 0.00; i <= dotabdel / 12.00; i += 0.11) {
      range = i;
    }
    return a;
  }

  Year() {
    double dotabdel = year.toDouble();
    double range = 0.00;
    late double a = range;
    for (double i = 0.00; i <= dotabdel / 100.0; i += 2.0) {
      range = i;
    }
    return a;
  }
  receive(){
    if (resultResponseGetUserAbandon != false) {
      date.value = resultResponseGetUserAbandon['data'].split(" ")[2];
      mont.value = resultResponseGetUserAbandon['data'].split(" ")[1];
      yaer.value = resultResponseGetUserAbandon['data'].split(" ")[0];
    }
    day.value = int.parse(date.value);
    month.value = int.parse(mont.value);
    year.value = int.parse(yaer.value);
    if (day.value < 0) {
      day.value = 0;
    }
    if (year.value == 0 && month.value == 0 && day.value <= 21) {
      flag = true;
    } else {
      flag = false;
    }
  }

}