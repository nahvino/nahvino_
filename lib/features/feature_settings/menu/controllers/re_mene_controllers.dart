import 'package:Nahvino/features/feature_settings/menu/model/User_securtiy_menu_model.dart';
import 'package:Nahvino/features/feature_settings/menu/service/security_menu_service.dart';
import 'package:get/get.dart';

class REMenueController extends GetxController {
  UserSecurtiyMenuModel? userSecurtiyMenuModel;

  @override
  void onInit() {
    super.onInit();

    startService();
  }

  startService() async {
    userSecurtiyMenuModel = await MenuService.UserSecuritySttingMenus();
    update();
  }
}