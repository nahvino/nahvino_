import 'dart:convert';

import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/Chat/group/chat_group/model/add_request_join_group_model.dart';
import 'package:Nahvino/features/Chat/group/info_group/config/get_info_config.dart';
import 'package:Nahvino/features/Chat/group/info_group/model/re_action_request_join_model.dart';
import 'package:http/http.dart' as http;


class ReActionRequestJoinGroupService {
  static var client = http.Client();

  static join_service(String? userid, int? adad , String? status ) async {
    final response = await http.get(Uri.parse(MainConfig.baseURL +
  GetInfoConfig.re_action_request_join_group +
        "UserId=$userid" + "&GroupId=$adad" + "&Status=$status" ));
    print(response.body.toString());
    if (response.statusCode == 200) {
      ReActionRequestJoinModel re_action_request_join_model =
      ReActionRequestJoinModel.fromJson(json.decode(response.body));
      return re_action_request_join_model;
    }
    // else {
    //   throw Exception('Failed to load album');
    // }
  }
}
