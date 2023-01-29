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
  GroupsModel? group_model;
  RxInt idChat = 0.obs;
  //OtherGroupsModel?
  Group? other_group_model;

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

  List<GroupsModel> groups = [];
  List<Group> other_groups = [];

  Future<void> GroupConnection() async {
    await hub.connection.start();
    hub.connection.on('GetOtherGroups', (OtherGroups) {
      print("===========>GetOtherGroups<===========");
       printError(info:OtherGroups.toString());
      for (var item in OtherGroups![0]) {
        other_group_model = Group.fromJson(item);
        other_groups.add(other_group_model!);
       // print(OtherGroups.toString());
      }
      update();
    });
    hub.connection.on('GetMyGroups', (MyGroups) {
      print("===========>GetMyGroups<===========");
      print(MyGroups.toString());
      // var res = MyGroups![0];
      // group_model = GroupsModel.fromJson(res);
      // groups.add(group_model!);
      for (var item in MyGroups![0]) {
        other_group_model = Group.fromJson(item);
        other_groups.add(other_group_model!);
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