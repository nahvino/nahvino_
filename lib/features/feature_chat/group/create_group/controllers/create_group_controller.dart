
import 'package:Nahvino/features/feature_chat/group/create_group/service/create_group.dart';
import 'package:Nahvino/features/feature_my_tabs/main/screen/tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupController extends GetxController {
  final ImagePicker picker = ImagePicker();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController rulscontroller = TextEditingController();
  TextEditingController gholghrarcontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  GroupService? serviceGroup;
  RxString imagePath = "".obs;
  RxString imageUrl = "".obs;
  RxString moderator1 = "".obs;
  RxString moderator2 = "".obs;
  RxInt puls = 0.obs;

  @override
  void onInit() {
    super.onInit();
    serviceGroup = GroupService();
  }

  //upload img
  uploadImage() async {
    if (imagePath.value != "") {
      var response = await serviceGroup!.uploadProfileImage(imagePath.value);
      if (response != false) {
        imageUrl.value = response;
        // profilerequest();
        Get.snackbar(
          'درسته',
          //response['message'],
          '',
          icon: Icon(Icons.notifications, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
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

  createGroup() {
    print(namecontroller.text);
    serviceGroup?.createGroup(namecontroller.text, rulscontroller.text,gholghrarcontroller.text,imageUrl.value
          )
        .then((value) {
          print(value);

      // Get.snackbar(
      //   value["message"],
      //   '',
      //   icon: Icon(Icons.notifications, color: Colors.white),
      //   snackPosition: SnackPosition.TOP,
      // );

      if(value != false){
        Get.to(MyTabs(tabIndex: 2,));
        Get.snackbar(
          value['message'],
          '',
          icon: Icon(Icons.notifications, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
        //Get.to(Page3Group());
      }else{
       /* Get.snackbar(
          value['message'],
          '',
          icon: Icon(Icons.notifications, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );*/
        print("مشکل");
      }

    });
    update();
  }

  create() {
    print(rulscontroller);
    if (!formKey.currentState!.validate()) {
    } else {
      uploadImage();
      if (!formKey1.currentState!.validate()) {
        print("1");
      } else {
        createGroup();
        namecontroller.clear();
        rulscontroller.clear();
        gholghrarcontroller.clear();

      }
    }

  }
  // nextOne() {
  //   print(rulscontroller);
  //   if (!formKey.currentState!.validate()) {
  //     print("1");
  //   } else {
  //     Get.to(Page2Group());
  //   }
  // }
  nextTow(){
  //  Get.to(Page3Group());
    // if(moderator1.value == "" && moderator2.value == ""){
    //   Get.snackbar("", "معاون ها نمی تواند خالی باشد",snackPosition: SnackPosition.TOP);
    // }else{
    //   Get.to(Page3Group());
    //
    // }
  }


}
