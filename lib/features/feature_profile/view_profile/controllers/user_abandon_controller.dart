import 'package:Nahvino/features/feature_profile/view_profile/model/get_user_abandon_model.dart';
import 'package:Nahvino/features/feature_profile/view_profile/service/profile_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAbandonController extends GetxController{

  GetUserAbandonModel? getUserAbandonModel;
  var resultResponseGetUserAbandon;
   RxInt day = 0.obs;
   RxInt month=0.obs;
   RxInt year=0.obs;
  var flag;
  RxString date = "0".obs;
  RxString mont = "0".obs;
  RxString yaer = "0".obs;
  ProfileService? ps;
  @override
  void onInit() {
    super.onInit();
    start_service();

  }


  start_service()async{
    getUserAbandonModel = await ProfileService.getabandon();
    receive();
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
    if (getUserAbandonModel!.data != false) {
      date.value = getUserAbandonModel!.data!.toString().split(" ")[2];
      mont.value = getUserAbandonModel!.data!.toString().split(" ")[1];
      yaer.value = getUserAbandonModel!.data!.toString().split(" ")[0];
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