
import 'package:Nahvino/features/Chat/group/chat_group/model/add_request_join_group_model.dart';
import 'package:Nahvino/features/Chat/group/chat_group/service/get_arjoin_group_service.dart';
import 'package:Nahvino/features/Chat/group/info_group/controllers/info_group_controller.dart';
import 'package:Nahvino/features/Chat/group/info_group/controllers/members_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatJoinGroupController extends GetxController {
  InfoGroupController members_list_controller = Get.put(InfoGroupController());
  AddRequestJoinGroupModel? add_request_join_group_model;
  RxString userId= "".obs;
  RxString messge = "".obs;
  @override
  void onInit() {
    super.onInit();
  }

  start_service(String userid,int id) async {
    add_request_join_group_model = await GetAddRequestJoinGroupService.join_service(userid,id);
    update();
  }
  get_rquset( ) async{
  SharedPreferences preferences =
      await SharedPreferences.getInstance();
  userId.value=(await preferences.getString("userId"))!;
    start_service(userId.value, members_list_controller.idgrup.value);


  }
}