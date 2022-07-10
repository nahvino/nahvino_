import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Model/User/user/viewprofile_response_model.dart';
import '../../Services/Login/ApiService.dart';

class ViewProfileController extends GetxController {
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
    checkdata();
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
    if (box.read('username') == null) {
      profilerequest();
    } else {
      username.value = box.read('username');
      namealias.value = box.read('namealias') ?? "مهمان";
      bio.value = box.read('bio') ?? "";
      rank.value = box.read('rank');
      score.value = box.read('score');
      imageUrl.value = box.read('imageUrl');
      if (imageUrl.value == "null") {
        imageUrl.value = "/Images/UserProfile/user.png";
      }
      identifierCode.value = box.read('identifierCode');
      parentId.value = box.read('parentId');
      parentname.value = box.read('parentname');
      parentimageurl.value =
          box.read('parentimageurl') ?? "/Images/UserProfile/user.png";
      dateTimeAbandon.value = box.read('dateTimeAbandon') ?? "تاریخ ترک";
    }
    update();
  }

  profilerequest() {
    Future.microtask(() {
      APIService.getprofileuser().then((response) {
        print("getprofileuser-------------------------- => $response");
        resultResponse = response;
        // resultResponseget = response;
        box.write('username', resultResponse!.userName);
        box.write('namealias', resultResponse!.nameAlias);
        box.write('bio', resultResponse!.bio);
        box.write('rank', resultResponse!.rank);
        box.write('score', resultResponse!.score);
        box.write('imageUrl', resultResponse!.imageUrl);
        box.write('identifierCode', resultResponse!.identifierCode);
        box.write('parentId', resultResponse!.parentId);
        box.write('parentname', resultResponse!.parentName);
        box.write('parentimageurl', resultResponse!.parentImageUrl);
        box.write('dateTimeAbandon', resultResponse!.dateTimeAbandon);
        username.value = box.read('username');
        namealias.value = box.read('namealias');
        bio.value = box.read('bio');
        rank.value = box.read('rank');
        score.value = box.read('score');
        imageUrl.value = box.read('imageUrl');
        identifierCode.value = box.read('identifierCode');
        parentId.value = box.read('parentId');
        parentname.value = box.read('parentname');
        parentimageurl.value = box.read('parentimageurl');
        dateTimeAbandon.value = box.read('dateTimeAbandon');
        print(box.read('username'));
      });
    }).onError((error, stackTrace) {
      print(error);
    });
    update();
  }
}
