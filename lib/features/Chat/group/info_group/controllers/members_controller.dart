import 'dart:convert';
import 'package:Nahvino/features/Chat/group/info_group/model/members_model.dart';
import 'package:Nahvino/features/Chat/group/info_group/service/get_members_service.dart';
import 'package:get/get.dart';

class MembersListController extends GetxController {
  RxInt ids = 0.obs;
  RxString name = "na".obs;
  RxString imageUrl = "".obs;
  RxString username = "".obs;
  RxBool isAdmin = false.obs;
  GetMembersService? get;
 // MembersModel? memmodel;
  MembersModel? membersModel;
  List<Data>? members;
  // List members = [];
  var respane;
  @override
  void onInit() {
    super.onInit();
  }

  start_service(int id) async {
    membersModel = await GetMembersService.info_service(id);
    members =  membersModel?.data;
    update();
  }

}
