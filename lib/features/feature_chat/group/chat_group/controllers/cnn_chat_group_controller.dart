import 'package:Nahvino/features/feature_chat/group/main/controllers/hub.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionChatGroupController extends GetxController{
  RxString userid = "".obs;
  RxInt id= 0.obs;
  HubConnectionn hub = HubConnectionn();

  @override
  void onInit() {
    super.onInit();
  //  openSignalRConnection();
    hub.openSignalRConnection();
    getMyData();
   // getMessageGroup()

  }

  Future getMyData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userid.value = (await preferences.getString("userId"))!;
  }





  getMessageGroup(int ids)async{
    hub.connection.on('GetMessageGroup', (GetMessageGroup) {
      print("===========>GetMyGroups<===========");
      print(GetMessageGroup.toString());
    });

    await hub.connection.invoke(
      'AllMessage',
      args: [ids],
    );
  }

  sendMessage()async{
  //  var replay = MyRepledMessage == null ? null : MyRepledMessage!.id;
    await hub.connection.invoke(
      'SendMessageGroup',
      args: [
        id.value,
        userid.value,
        0,
        "asaa",
      ],
    );
  }



}