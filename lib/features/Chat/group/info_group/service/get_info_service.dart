import 'dart:convert';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/Chat/group/info_group/model/InfoModel.dart';
import 'package:http/http.dart' as http;

import '../config/get_info_config.dart';

class GetInfoService {
  static var client = http.Client();
  static Future info_service(int? adad) async {
      var url = Uri.parse( MainConfig.baseURL+ GetInfoConfig.info_group + "GroupId=$adad");
      var response = await client.get(
        url,
    );
    print(response.body.toString());
    if (response.statusCode == 200) {
      InfoModel info =
      InfoModel.fromJson(json.decode(response.body));
      return info;
    }
    // else{
    //   return Error();
    // }

  }
}