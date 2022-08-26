import 'package:get/get.dart';

class InfoGroupController extends GetxController {
  RxBool join = false.obs;

  sendrequsetjoin() {
    join.value = false;
  }

  leavegroup() {
    join.value = true;
  }
}
