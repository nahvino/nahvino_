import 'package:Nahvino/profile/edit_profile/service/edit_profile_service.dart';
import 'package:Nahvino/profile/view_profile/service/profile_service.dart';
import 'package:Nahvino/profile/view_profile/data/view_profial_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

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

  late EditProfileService? serpro;
  String? imageuri;
  RxString imageuris = "".obs;

  // controller

  @override
  void onInit() {
    super.onInit();
    userNameController = TextEditingController(text: databox.username.value);
    nameAliasController = TextEditingController(text: databox.namealias.value);
    bioController = TextEditingController(text: databox.bio.value);
    serpro = EditProfileService();
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

  selectDate(BuildContext context) async {
    Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1320, 1),
      lastDate: Jalali.now(),
    );
    print(picked!.formatCompactDate());
    berlinWallFell.value = picked.formatCompactDate();
    tarikhController = TextEditingController(text: picked.formatCompactDate().toString());
    update();
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
