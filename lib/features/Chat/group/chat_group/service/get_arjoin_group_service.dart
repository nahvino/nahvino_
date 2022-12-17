import 'dart:convert';

import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/Chat/group/chat_group/config/chat_config.dart';
import 'package:Nahvino/features/Chat/group/chat_group/model/add_request_join_group_model.dart';
import 'package:http/http.dart' as http;


class GetAddRequestJoinGroupService {
  static var client = http.Client();

  static join_service(String? userid, int? adad) async {
    final response = await http.get(Uri.parse(MainConfig.baseURL +
        ChatGroupConfig.add_request_join_group +
        "UserId=$userid" + "&GroupId=$adad"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      AddRequestJoinGroupModel add_request_join_group_model =
      AddRequestJoinGroupModel.fromJson(json.decode(response.body));
      return add_request_join_group_model;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
