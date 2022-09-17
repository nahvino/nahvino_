import 'package:Nahvino/Chat/Screen/group/create_group/page2_group.dart';
import 'package:Nahvino/Chat/Screen/group/create_group/page3_group.dart';
import 'package:Nahvino/Chat/service/group/create_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupController extends GetxController {
  final ImagePicker picker = ImagePicker();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController rulscontroller = TextEditingController();
  TextEditingController gholghrarcontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
    serviceGroup?.createGroup(namecontroller.text, rulscontroller.text,gholghrarcontroller.text,
          )
        .then((value) {
          print(value);
      // Get.snackbar(
      //   value["message"],
      //   '',
      //   icon: Icon(Icons.notifications, color: Colors.white),
      //   snackPosition: SnackPosition.TOP,
      // );
      /*
      if(value != false){
        Get.snackbar(
          value['message'],
          '',
          icon: Icon(Icons.notifications, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
      }else{
        Get.snackbar(
          value['message'],
          '',
          icon: Icon(Icons.notifications, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
      }
*/
    });
    update();
  }

  nextOne() {
    print(rulscontroller);
    if (!formKey.currentState!.validate()) {
      print("1");
    } else {
      Get.to(Page2Group());
    }
  }
  nextTow(){
    Get.to(Page3Group());
    // if(moderator1.value == "" && moderator2.value == ""){
    //   Get.snackbar("", "معاون ها نمی تواند خالی باشد",snackPosition: SnackPosition.TOP);
    // }else{
    //   Get.to(Page3Group());
    //
    // }
  }
}
