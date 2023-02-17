import 'package:Nahvino/features/feature_profile/edit_profile/service/edit_profile_service.dart';
import 'package:Nahvino/features/feature_profile/view_profile/controllers/profile_controller.dart';
import 'package:Nahvino/features/feature_profile/view_profile/data/view_profial_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class EditProfileController extends GetxController {
  //import
  ViewProfileController databox = Get.put(ViewProfileController());
  ProfileController profile_Controller = Get.put(ProfileController());

  //Variable
  final ImagePicker picker = ImagePicker();

  RxBool isApiCallProcess = false.obs;
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameAliasController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController tarikhController = TextEditingController();
  String? error;
  RxString berlinWallFell = "تاریخ آغاز ترک  ".obs;

  RxString imagePath = "".obs;

  //String? imagePath;

  late EditProfileService? serpro;
  String? imageuri;
  RxString imageuris = "".obs;

  // controller

  @override
  void onInit() {
    super.onInit();
    userNameController = TextEditingController(
        text: profile_Controller.profileUserModelResponse!.userName);
    nameAliasController = TextEditingController(
        text: profile_Controller.profileUserModelResponse!.nameAlias);
    bioController = TextEditingController(
        text: profile_Controller.profileUserModelResponse!.bio);
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
    tarikhController =
        TextEditingController(text: picked.formatCompactDate().toString());
    update();
  }

  upimg() async {
    if (imagePath.value != "") {
      var response = await serpro!.uploadProfileImage(imagePath.value);
      if (response != false) {
        imageuris.value = response;
      } else {
        Get.snackbar(
          'آپلود عکس با خطا مواجه شد',
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
      } else {
        Get.snackbar(
          response['message'].toString(),
          '',
          icon: Icon(Icons.notifications, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }
}
