import 'package:Nahvino/features/Chat/group/info_group/model/members_model.dart';
import 'package:Nahvino/features/Chat/group/info_group/model/request_membres_model_group.dart';
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
  RequestMembresModelGroup? requestmembresmodelgroup;
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

}
