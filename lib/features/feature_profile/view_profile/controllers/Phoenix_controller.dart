import 'package:Nahvino/features/feature_profile/view_profile/model/Last_visit_model.dart';
import 'package:Nahvino/features/feature_profile/view_profile/service/profile_service.dart';
import 'package:get/get.dart';

class PhoenixController extends GetxController{
  var phoenixResponse;
  LastVisitModel? lastVisitModel;
  @override
  void onInit() {
    super.onInit();
    StartRequest();
  }
  StartRequest()async{
    lastVisitModel = await ProfileService.GetLastVisit();
    print(lastVisitModel!.data);
    // ProfileService.GetLastVisit().then((response) async {
    //   phoenixResponse = response;
    //   print(" -------------<GetLastVisit>-------------- => $response");
    // });
    update();
  }
}