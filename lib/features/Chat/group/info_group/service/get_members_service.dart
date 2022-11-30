import 'dart:convert';

import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/Chat/group/info_group/model/members_model.dart';
import 'package:http/http.dart' as http;

import '../config/get_info_config.dart';

class GetMembersService {
  static var client = http.Client();
  Future<MembersModel> info_service(int? adad) async {
   // var url = Uri.parse( MainConfig.baseURL+ GetInfoConfig.members_list_group + "GroupId=$adad");
   // var response = await client.get(url,);
    final response = await http
        .get(Uri.parse(MainConfig.baseURL+ GetInfoConfig.members_list_group + "GroupId=$adad"));
//   print(response.body.toString());
    if (response.statusCode == 200) {
      return MembersModel.fromJson(json.decode(response.body));
        //response.body;
    }else{
      throw Exception('Failed to load album');
    }

  }
}