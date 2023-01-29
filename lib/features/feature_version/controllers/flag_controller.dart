
import 'package:Nahvino/features/feature_version/model/FlagModel.dart';
import 'package:Nahvino/features/feature_version/service/flag_service.dart';
import 'package:get/get.dart';

class FlagController extends GetxController {
  FlagModel? flagmodel;

  @override
  void onInit() {
    super.onInit();
    start_service();
  }

  start_service() async {
    flagmodel = await FlagService.fetchFlags();
    update();
  }
}
