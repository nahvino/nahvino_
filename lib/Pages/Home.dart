import 'package:Nahvino/Pages/Account/User/editprofilescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/getx/user/viewprofial_controller.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  ViewProfileController databox = Get.put(ViewProfileController());

  @override
  void initState() {
    super.initState();
    databox.checkdata();
    print(databox.box.read('imageUrl'));
    print(databox.box.read('bio'));
    print(databox.box.read('rank'));
    print(databox.box.read('score'));
    print(databox.box.read('identifierCode'));
    print(databox.box.read('parentId'));
    print(databox.box.read('parentname'));
    print(databox.box.read('parentimageurl'));
  
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: Text("پروفایل"),
          onPressed: () {
            Get.to(EditProfileScreen());
          },
        )
      ],
    );
  }
}
