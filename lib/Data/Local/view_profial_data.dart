import 'package:Nahvino/Pages/Account/Login/add_introduced.dart';
import 'package:Nahvino/Services/Users/User/profile_service.dart';
import 'package:Nahvino/tabs.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Model/User/user/viewprofile_response_model.dart';

class ViewProfileController extends GetxController {
  ServiceProfile? proser;
  var resultResponse;
  GetProfileUserResponseModel? resultResponseget;
  GetStorage box = GetStorage();
  RxBool canSend = false.obs;
  RxString username = "".obs;
  RxString namealias = "".obs;
  RxString bio = "".obs;
  RxInt rank = 0.obs;
  RxInt score = 0.obs;
  RxString imageUrl = "".obs;
  RxInt identifierCode = 0.obs;
  RxString parentId = "".obs;
  RxString parentname = "".obs;
  RxString parentimageurl = "".obs;
  RxString dateTimeAbandon = "".obs;
  @override
  void onInit() {
    super.onInit();
    GetStorage.init();
    //checkdata();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  checkdata() {
    if (box.read('username') == null || box.read('username') == "null") {
      profilerequest();
    } else {
      readDatas();
      update();
    }
  }

  profilerequest() {
    ServiceProfile.profileuser().then((response) {
      resultResponse = response;
      print("<=------------<GetProfileUser>--------------=> $response");
      box.write('username', resultResponse['userName']);
      box.write('namealias', resultResponse['nameAlias']);
      box.write('bio', resultResponse['bio']);
      box.write('rank', resultResponse['rank']);
      box.write('score', resultResponse['score']);
      box.write('imageUrl', resultResponse['imageUrl']);
      box.write('identifierCode', resultResponse['identifierCode']);
      box.write('parentId', resultResponse['parentId']);
      box.write('parentname', resultResponse['parentName']);
      box.write('parentimageurl', resultResponse['parentImageUrl']);
      box.write('dateTimeAbandon', resultResponse['dateTimeAbandon']);
      readDatas();
      update();
    });
    update();
  }

  readDatas() {
    username.value = box.read('username') ?? "";
    namealias.value = box.read('namealias') ?? "";
    bio.value = box.read('bio') ?? "";
    rank.value = box.read('rank') ?? 0;
    score.value = box.read('score') ?? 0;
    imageUrl.value = box.read('imageUrl') ?? "";
    identifierCode.value = box.read('identifierCode') ?? 0;
    parentId.value = box.read('parentId') ?? "";
    parentname.value = box.read('parentname') ?? "";
    parentimageurl.value = box.read('parentimageurl') ?? "";
    dateTimeAbandon.value = box.read('dateTimeAbandon') ?? "تاریخ ترک";
    update();
  }

  clerdata() {
    box.remove('username');
    box.remove('namealias');
    box.remove('bio');
    box.remove('rank');
    box.remove('score');
    box.remove('imageUrl');
    box.remove('identifierCode');
    box.remove('parentId');
    box.remove('parentname');
    box.remove('parentimageurl');
    box.remove('dateTimeAbandon');
    update();
  }

  check() {
    ServiceProfile.profileuser().then((response) {
      resultResponse = response;
      print(")))))))جهت تست))))))))==>$resultResponse");
      if (resultResponse['parentId'] == "" ||
          resultResponse['parentId'] == "null" ||
          resultResponse['parentId'] == null) {
        Get.offAll(AddIntroduced());
      } else {
        Get.offAll(MyTabs());
      }
    });
  }
}
