import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroController extends GetxController{

  Future<void> saveInSharedPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("shouldShowIntro", false);
  }

}