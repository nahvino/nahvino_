import 'package:Nahvino/Services/Users/User/profile_service.dart';
import 'package:Nahvino/Data/Local/view_profial_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class EditProfileController extends GetxController {
  //import
  ViewProfileController databox = Get.put(ViewProfileController());

  //Variable
  final ImagePicker picker = ImagePicker();

  RxBool isApiCallProcess = false.obs;
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameAliasController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController tarikhController = TextEditingController();
  String? error;
  RxString berlinWallFell = "تاریخ ترک".obs;

  RxString imagePath = "".obs;
  //String? imagePath;

  late ServiceProfile? serpro;
  String? imageuri;
  RxString imageuris = "".obs;

  // controller

  @override
  void onInit() {
    super.onInit();
    userNameController = TextEditingController(text: databox.username.value);
    nameAliasController = TextEditingController(text: databox.namealias.value);
    bioController = TextEditingController(text: databox.bio.value);
    serpro = ServiceProfile();
    imageuris.value = databox.imageUrl.value;
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

  upimg() async {
    if (imagePath.value != "") {
      var response = await serpro!.uploadProfileImage(imagePath.value);
      if (response != false) {
        imageuris.value = response;
        profilerequest();
        print("-=-=-=-=-=-======== $response");
      } else {
        Get.snackbar(
          'آپلود عکس با خطا مواجه شد',
          //response['message'],
          '',
          icon: Icon(Icons.notifications, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );

        return;
      }
    }
  }

  profilerequest() {
    serpro!
        .editprofileuser(
      userNameController.text,
      nameAliasController.text,
      bioController.text,
      imageuris.value,
    )
        .then((value) {
      databox.profilerequest();
      //isApiCallProcess.value = true;
      Get.snackbar(
        value['message'],
        '',
        icon: Icon(Icons.notifications, color: Colors.white),
        snackPosition: SnackPosition.TOP,
      );
    });
    update();
  }

  date() {
    serpro!.AddOrEditUserAbandon(berlinWallFell.value).then((response) async {
      if (response != false) {
        //apiService.showSnackBar(text: response['message']);
        databox.profilerequest();

        Get.snackbar(
          response['message'],
          '',
          icon: Icon(Icons.notifications, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
      } else {
        // Get.snackbar(
        //   response['message'].toString(),
        //   '',
        //   icon: Icon(Icons.notifications, color: Colors.white),
        //   snackPosition: SnackPosition.TOP,
        // );
      }
    });
  }
}
