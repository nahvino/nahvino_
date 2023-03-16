import 'package:Nahvino/features/feature_auth/main/screen/registration.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroController extends GetxController {
  SharedPreferences? save_intro;
  GetStorage intro = GetStorage();

  saveintro() async {
   // save_intro = await SharedPreferences.getInstance();
    //await save_intro?.setString("shouldShowIntro", "ok");
   // print(save_intro?.getString("shouldShowIntro"));
    intro.write("intro", true);
    print(intro.read("intro"));
    Get.offAll(()=>Registration());
  }
}
