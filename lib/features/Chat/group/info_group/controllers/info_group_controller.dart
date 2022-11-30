import 'dart:convert';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/Chat/group/info_group/service/get_info_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoGroupController extends GetxController {
  RxBool join = false.obs;
  RxString name = "na".obs;
  RxString description = "as".obs;
  RxString imageUrl = "".obs;
  RxString audience = "".obs;
  RxString link = "".obs;
  RxString flagearers = "".obs;
  RxString conquests = "".obs;
  RxString rules = "".obs;
  RxString promise = "".obs;
  RxString count = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  start_service(int id) {
    GetInfoService.info_service(id).then((res) {
      name.value = json.decode(res)['data']['name'].toString();
      description.value = json.decode(res)['data']['description'].toString();
      imageUrl.value = json.decode(res)['data']['imageUrl'].toString();
      audience.value = json.decode(res)['data']['audience'].toString();
      link.value = json.decode(res)['data']['link'].toString();
      flagearers.value = json.decode(res)['data']['flagearers'].toString();
      conquests.value = json.decode(res)['data']['conquests'].toString();
      rules.value = json.decode(res)['data']['rules'].toString();
      promise.value = json.decode(res)['data']['promise'].toString();
      count.value = json.decode(res)['data']['count'].toString();
      update();
    });
  }

  sendrequsetjoin() {
    join.value = false;
  }

  leavegroup() {
    join.value = true;
  }
}
