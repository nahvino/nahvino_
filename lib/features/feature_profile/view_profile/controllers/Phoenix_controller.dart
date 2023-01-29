import 'package:Nahvino/features/feature_profile/view_profile/service/profile_service.dart';
import 'package:get/get.dart';

class PhoenixController extends GetxController{
  var phoenixResponse;

  @override
  void onInit() {
    super.onInit();
    StartRequest();
  }
  StartRequest(){
    ProfileService.GetLastVisit().then((response) async {
      phoenixResponse = response;
      print(" -------------<GetLastVisit>-------------- => $response");
    });
  }
}