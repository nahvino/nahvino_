import 'dart:convert';
import 'package:Nahvino/features/Chat/group/info_group/model/member_models.dart';
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
  MemberModels? memmodel;
  List<MemberModels> members = [];
 // List members = [];
  var respane;
  @override
  void onInit() {
    super.onInit();
  }

  start_service(int id) {
    get?.info_service(id).then((response) {
  //  members.add((json.decode(response.body)));
     // respane = response;
   //  print("$respane *---------------respane-------respane----------*");
/*
      members.add((json.decode(response.body) as List)
          .map((data) => MembersModel.fromJson(data))
          .toList());*/
      ///print(memmodel?.data?.map((e) => e.userame.toString()));
      print("*---------------respane-------respane----------*");
      print(memmodel?.message);

     // print(members.toString());
      update();
    });
  }

}
