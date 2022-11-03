import 'package:Nahvino/features/Chat/group/info_group/service/get_info_service.dart';
import 'package:get/get.dart';

class InfoGroupController extends GetxController {
  RxBool join = false.obs;

  @override
  void onInit() {
    super.onInit();
    GetInfoService.info_service();
  }



  sendrequsetjoin() {
    join.value = false;
  }

  leavegroup() {
    join.value = true;
  }
}
