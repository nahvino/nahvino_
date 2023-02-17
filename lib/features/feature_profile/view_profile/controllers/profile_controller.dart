import 'package:Nahvino/features/feature_profile/view_profile/data/view_profial_data.dart';
import 'package:Nahvino/features/feature_profile/view_profile/model/Profile_user_model_response.dart';
import 'package:Nahvino/features/feature_profile/view_profile/service/profile_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  ViewProfileController databox = Get.put(ViewProfileController());

  RxBool help = false.obs;
  ProfileUserModelResponse? profileUserModelResponse;

  @override
  void onInit() {
   //databox.checkdata();
    super.onInit();
    startService();
  }

  startService()async{
    profileUserModelResponse = await ProfileService.userprofile();
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  help_vizi() {
    help.value = true;
    print(help.value);
  }
}
