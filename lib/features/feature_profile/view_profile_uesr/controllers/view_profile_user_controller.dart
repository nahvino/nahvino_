import 'package:Nahvino/features/feature_profile/view_profile/controllers/profile_controller.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/model/Other_user_get_abandon_model.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/model/User_profile_model.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/model/other_last_visit_model.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/screen/view_profile_user_screen.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/service/visit_user_service.dart';
import 'package:get/get.dart';

class ViewProfileUserController extends GetxController {
  UserProfileModel? userProfileModel;
  OtherLastVisitModel? otherLastVisitModel;
  OtherUserGetAbandonModel? otherUserGetAbandonModel;
  @override
  void onInit() {
    super.onInit();
    start();
  }

  ///[input]///[String]///[userId]
  start() async {
    userProfileModel = await VisetUserService.getprofileotheruser(ProfileController.parantuserid.toString());
    otherLastVisitModel = await VisetUserService.GetLastOtherVisit(ProfileController.parantuserid.toString());
    otherUserGetAbandonModel = await VisetUserService.getuserotherabandon(ProfileController.parantuserid.toString());
    print(userProfileModel!.nameAlias);
    print(otherLastVisitModel!.data);
    print(otherUserGetAbandonModel!.data);
    receive();
    update();
  }
  ///[INPUT]///[ABANDDON]
  RxInt day = 0.obs;
  RxInt month=0.obs;
  RxInt year=0.obs;
  var flag;
  RxString date = "0".obs;
  RxString mont = "0".obs;
  RxString yaer = "0".obs;
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
    for (double i = 0.365; i <= dotabdel / 12.0; i += 1.0) {
      range = i;
    }
    return a;
  }
  receive(){
    if (otherUserGetAbandonModel!.data != false) {
      date.value = otherUserGetAbandonModel!.data!.toString().split(" ")[2];
      mont.value = otherUserGetAbandonModel!.data!.toString().split(" ")[1];
      yaer.value = otherUserGetAbandonModel!.data!.toString().split(" ")[0];
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
