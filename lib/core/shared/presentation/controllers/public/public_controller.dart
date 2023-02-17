import 'package:Nahvino/features/feature_chat/service/notification_service.dart';
import 'package:Nahvino/features/feature_profile/view_profile/data/view_profial_data.dart';
import 'package:Nahvino/features/feature_auth/main/screen/registration.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicController extends GetxController{
  ViewProfileController databox = Get.put(ViewProfileController());

  allclear()async{
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    ServiceNotification.deletetokennotificationapi()
        .then((response) {
      print(
          "deletetokenapi---------------------------- => $response");
    });
    await DefaultCacheManager().emptyCache();
    databox.clerdata();
    _deleteCacheDir();
    _deleteAppDir();
    Future.delayed(const Duration(milliseconds: 1000), () {
      // exit(0);
       Get.offAll(() =>Registration());
    });
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }
  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationDocumentsDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }
}