import 'package:Nahvino/controllers/getx/user/viewprofial_controller.dart';
import 'package:Nahvino/tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Services/Login/ApiService.dart';
import '../../../Services/Login/User/service_profile.dart';

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
  //RxString imagePath = "".obs;
  String? imagePath;

  late ServiceProfile? serpro;
  String? imageuri;
  late APIService apiService;

  // controller

  @override
  void onInit() {
    super.onInit();
    userNameController = TextEditingController(text: databox.username.value);
    nameAliasController = TextEditingController(text: databox.namealias.value);
    bioController = TextEditingController(text: databox.bio.value);
    serpro = ServiceProfile();
    imageuri = databox.imageUrl.value;
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

  validatoreditprofile() {
    GetUtils.isUsername(userNameController.text)
        ? print("صحبح نیست")
        : print("صحبح ");
    GetUtils.isLengthGreaterThan(userNameController.text, 6);
  }

  upimg() async {
    if (imagePath != null) {
      var response = await serpro!.uploadProfileImage(imagePath!);
      if (response != false) {
        // editcontroller.databox.imageUrl.value = response;
        imageuri = response;
        //   Get.offAll(MyTabs());
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
      imageuri.toString(),
    )
        .then((value) {
      Get.snackbar(
        value['message'],
        '',
        icon: Icon(Icons.notifications, color: Colors.white),
        snackPosition: SnackPosition.TOP,
      );
      databox.profilerequest();
    });
  }

  date() {
    serpro!.AddOrEditUserAbandon(berlinWallFell.value).then((response) async {
      if (response != false) {
        //apiService.showSnackBar(text: response['message']);
        Get.snackbar(
          response['message'],
          '',
          icon: Icon(Icons.notifications, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
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
