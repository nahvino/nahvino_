import 'package:Nahvino/features/feature_profile/view_profile/data/view_profial_data.dart';
import 'package:Nahvino/features/feature_profile/view_profile/model/Profile_user_model_response.dart';
import 'package:Nahvino/features/feature_profile/view_profile/service/profile_service.dart';
import 'package:Nahvino/features/feature_profile/view_profile_uesr/controllers/view_profile_user_controller.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // ViewProfileController databox = Get.put(ViewProfileController());

  RxBool help = false.obs;
  ProfileUserModelResponse? profileUserModelResponse;
  static String? username;
  static String?  parantuserid;

  @override
  void onInit() {
    //databox.checkdata();
    super.onInit();
    startService();
  }

  startService() async {
    profileUserModelResponse = await ProfileService.userprofile();
    username = profileUserModelResponse!.userName!;
    parantuserid=profileUserModelResponse!.parentId!;
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
  // get_prant_view(){
  //    ViewProfileUserController().start(profileUserModelResponse!.parentId!);
  // }
}
