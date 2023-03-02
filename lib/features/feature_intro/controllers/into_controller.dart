import 'package:Nahvino/features/feature_auth/main/screen/registration.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroController extends GetxController{

  Future<void> saveInSharedPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("shouldShowIntro", false);
    Get.offAll(Registration());
  }

}