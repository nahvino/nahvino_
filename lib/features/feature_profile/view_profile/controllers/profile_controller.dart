import 'package:Nahvino/features/feature_profile/view_profile/data/view_profial_data.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  ViewProfileController databox = Get.put(ViewProfileController());

  RxBool help = false.obs;

  @override
  void onInit() {
   databox.checkdata();
    super.onInit();
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
