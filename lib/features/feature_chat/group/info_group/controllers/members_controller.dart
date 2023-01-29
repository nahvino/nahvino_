import 'package:Nahvino/features/feature_chat/group/info_group/controllers/info_group_controller.dart';
import 'package:Nahvino/features/feature_chat/group/info_group/model/InfoModel.dart';
import 'package:Nahvino/features/feature_chat/group/info_group/model/members_model.dart';
import 'package:Nahvino/features/feature_chat/group/info_group/model/re_action_request_join_model.dart';
import 'package:Nahvino/features/feature_chat/group/info_group/model/request_membres_model_group.dart';
import 'package:Nahvino/features/feature_chat/group/info_group/service/get_members_service.dart';
import 'package:Nahvino/features/feature_chat/group/info_group/service/re_action_request_join_group_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MembersListController extends GetxController {
  InfoGroupController members_list_controller = Get.put(InfoGroupController());

  RxInt ids = 0.obs;
  RxString name = "na".obs;
  RxString imageUrl = "".obs;
  RxString username = "".obs;
  RxBool isAdmin = false.obs;
  RxString userId= "".obs;
  GetMembersService? get;
 // MembersModel? memmodel;
  MembersModel? membersModel;
  RequestMembresModelGroup? requestmembresmodelgroup;
  ReActionRequestJoinModel? rememberrequstjoin;
  List<Data>? members;
  List<RequestData>? requestmembresmodel;

  // List members = [];
  var respane;
  @override
  void onInit() {
    super.onInit();
  }

  start_service(int id) async {
    membersModel = await GetMembersService.members_service(id);
    members =  membersModel?.data;
    requestmembresmodelgroup = await GetMembersService.reques_service(id);
    requestmembresmodel= requestmembresmodelgroup?.data;
    update();
  }

  reJoin(String userId)async{
    rememberrequstjoin = await ReActionRequestJoinGroupService.join_service(userId, members_list_controller.info?.data!.id!.toInt(),"true");
    print(members_list_controller.info?.data!.id!);
  }
  notreJoin()async{
    SharedPreferences preferences =
    await SharedPreferences.getInstance();
    userId.value=(await preferences.getString("userId"))!;
    rememberrequstjoin = await ReActionRequestJoinGroupService.join_service(userId.value, members_list_controller.info?.data!.id!, "false");
  }

}
