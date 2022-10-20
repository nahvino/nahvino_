import 'dart:math';

import 'package:Nahvino/features/Chat/group/main/model/Group.dart';
import 'package:Nahvino/features/Chat/group/main/model/groups_model.dart';
import 'package:Nahvino/features/Chat/group/main/model/other_groups_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hub.dart';

class GroupController extends GetxController {
  final ImagePicker picker = ImagePicker();
  TextEditingController search_controller = TextEditingController();
  HubConnectionn hub = HubConnectionn();
  RxBool isInSearchMode = false.obs;
  RxBool InSearchMode = true.obs;
  RxString serchtext = "".obs;
  String? UserId;
  RxString img = "".obs;
  GroupsModel? group_model;
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
  List<Group>? other_groups = [];
  Future<void> GroupConnection() async {
    await hub.connection.start();
   hub.connection.on('GetOtherGroups', (OtherGroups) {
      print("===========>GetOtherGroups<===========");
      print( " =======index=======< $OtherGroups![0]");
     // var res = OtherGroups![0];
     //  other_group_model = OtherGroupsModel.fromJson(res);
     //  other_groups?.add(other_group_model!);
     //  //print(OtherGroups.toString());
     //  defaultLogWriterCallback(OtherGroups.toString());
     // debugPrint(OtherGroups.toString());
      for (var item in OtherGroups![0]) {
        other_group_model = Group.fromJson(item);
        other_groups?.add(other_group_model!);
        print(OtherGroups.toString());
      }
    });
    hub.connection.on('GetMyGroups', (MyGroups) {
      print("===========>GetMyGroups<===========");
      print(MyGroups.toString());
      var res = MyGroups![0];
      group_model = GroupsModel.fromJson(res);
      groups.add(group_model!);

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
    ); await hub.connection.invoke(
      'OtherGroups',
      args: [UserId],
    );

  }


}
