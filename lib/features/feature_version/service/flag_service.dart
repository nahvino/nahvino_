import 'dart:convert';
import 'package:Nahvino/features/feature_version/config/flag_config.dart';
import 'package:Nahvino/features/feature_version/model/FlagModel.dart';
import 'package:http/http.dart' as http;

class FlagService {
  static var client = http.Client();

  static Future fetchFlags() async {
    var url = Uri.parse(FlagConfig.flag);
    var response = await client.get(
      url,
    );
    //print(response.body.toString());
    if (response.statusCode == 200) {
      FlagModel flagmodel =
      FlagModel.fromJson(json.decode(response.body));
      print("%%%%%%%%%%%%%%%%%");
      print(flagmodel.country);
      print("%%%%%%%%%%%%%%%%%");

      return flagmodel;
    } else {
      throw Exception('Failed to load album');
    }
  }

}