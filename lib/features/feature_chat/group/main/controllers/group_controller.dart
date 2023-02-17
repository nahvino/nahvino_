import 'dart:async';
import 'dart:math';
import 'package:Nahvino/features/feature_chat/group/info_group/controllers/info_group_controller.dart';
import 'package:Nahvino/features/feature_chat/group/main/model/other_groups_model.dart';
import 'package:Nahvino/features/feature_chat/group/main/model/groups_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../chat_group/screen/chat_group_screen.dart';
import 'hub.dart';

class GroupController extends GetxController {

  InfoGroupController infoGroupController = Get.put(InfoGroupController());

  final ImagePicker picker = ImagePicker();
  TextEditingController search_controller = TextEditingController();
  HubConnectionn hub = HubConnectionn();
  RxBool isInSearchMode = false.obs;
  RxBool InSearchMode = true.obs;
  RxString serchtext = "".obs;
  String? UserId;
  RxString img = "".obs;
  MyGroupsModel? my_groups_model;
  RxInt idChat = 0.obs;
  //OtherGroupsModel?
  OrherGroupsMpdel? other_group_model;

  @override
  void onInit() {
    super.onInit();
    GroupConnection();
    getMyData();

  }

  Future getMyData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserId = (await preferences.getString("userId"))!;
  }

  List<MyGroupsModel> myGroups_list = [];
  List<OrherGroupsMpdel> other_groups_list = [];

  Future<void> GroupConnection() async {
    await hub.connection.start();
    hub.connection.on('GetOtherGroups', (OtherGroups) {
      print("===========>GetOtherGroups<===========");
       printError(info:OtherGroups.toString());
      for (var item in OtherGroups![0]) {
        other_group_model = OrherGroupsMpdel.fromJson(item);
        other_groups_list.add(other_group_model!);
       // print(OtherGroups.toString());
      }
      update();
    });
    hub.connection.on('GetMyGroups', (MyGroups) {
      print("===========>GetMyGroups<===========");
      //print(MyGroups.toString());
      printError(info:MyGroups.toString());
      // var res = MyGroups![0];
      // group_model = GroupsModel.fromJson(res);
      // groups.add(group_model!);
      for (var item in MyGroups![0]) {
        my_groups_model = MyGroupsModel.fromJson(item);
        myGroups_list.add(my_groups_model!);
        // print(OtherGroups.toString());
      }

/*
      for (var res in MyGroups![0]) {
        group_model = GroupsModel.fromJson(res);
        groups.add(group_model!);
      }
      */

      update();
    });
    await hub.connection.invoke(
      'MyGroups',
      args: [UserId],
    );
    await hub.connection.invoke(
      'OtherGroups',
      args: [UserId],
    );
  }


}

