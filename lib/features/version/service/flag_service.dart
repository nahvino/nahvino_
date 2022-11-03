import 'dart:convert';
import 'package:Nahvino/features/version/config/flag_config.dart';
import 'package:Nahvino/features/version/model/flagmodel.dart';
import 'package:http/http.dart' as http;

class FlagService {
  static var client = http.Client();
  FlagModel? flagModel;
  static Future<FlagModel> fetchFlags() async {
    var url = Uri.parse(FlagConfig.flag);
    var response = await client.get(
      url,
    );
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return FlagModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}