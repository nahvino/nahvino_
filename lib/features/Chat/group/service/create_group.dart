import 'dart:convert';
import 'package:Nahvino/config/main_config.dart';
import 'package:Nahvino/features/Chat/group/config/group_confing.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GroupService {
  static var client = http.Client();

  Future uploadProfileImage(String imagePath) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(MainConfig.baseURL + GroupConfig.create_image_group),
    );
    var multipartFile =
        await http.MultipartFile.fromPath('ImageFile', imagePath);
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    if (response.statusCode == 200) {
      print(response);
      return respStr;
    } else {
      return false;
    }
  }

   Future createGroup(
      String? groupName,
      String? rules,
      String? promise,
      String? imageUrl,
      ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      // 'Authorization': "Bearer ${await preferences.getString("token")}"
    };
    var url = Uri.parse(MainConfig.baseURL + GroupConfig.create_group);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "ownerId": await preferences.getString("userId"),
        "name": groupName,
        "rules": rules,
        "promise": promise,
        "imageUrl" : imageUrl
      }),
    );
    if (response.statusCode == 200) {
      print("****==< Add Group >==****");
      print(response);
      return json.decode(response.body);
    } else {
      return false;
    }
  }
}
