import 'dart:convert';

import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/Chat/group/info_group/model/members_model.dart';
import 'package:Nahvino/features/Chat/group/info_group/model/request_membres_model_group.dart';
import 'package:http/http.dart' as http;

import '../config/get_info_config.dart';

class GetMembersService {
  static var client = http.Client();

  static members_service(int? adad) async {
    final response = await http.get(Uri.parse(MainConfig.baseURL +
        GetInfoConfig.members_list_group +
        "GroupId=$adad"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      MembersModel membersModel =
          MembersModel.fromJson(json.decode(response.body));
      return membersModel;
    } else {
      throw Exception('Failed to load album');
    }
  }

  static reques_service(int? adad) async {
    final response = await http.get(Uri.parse(MainConfig.baseURL +
        GetInfoConfig.requset_list_group +
        "GroupId=$adad"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      RequestMembresModelGroup requestmembresmodelgroup =
          RequestMembresModelGroup.fromJson(json.decode(response.body));
      return requestmembresmodelgroup;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
