import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AboutGroupController extends GetxController {
  RxBool requestnotificationapi = true.obs;
  RxBool isSwitched = false.obs;
  RxBool notfi = false.obs;
  GetStorage reqtokenapi = GetStorage();
  @override
  void onInit() {
    GetStorage.init();
    super.onInit();
  }
}
