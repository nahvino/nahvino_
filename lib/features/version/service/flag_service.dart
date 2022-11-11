import 'dart:convert';
import 'package:Nahvino/features/version/config/flag_config.dart';
import 'package:Nahvino/features/version/model/flagmodel.dart';
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
     // return FlagModel.fromJson(jsonDecode(response.body));
      return response.body;
    } else {
      throw Exception('Failed to load album');
    }
  }

 /* static fetchFlags()async{
    var res = await http.get(Uri.parse(FlagConfig.flag));
    //final flagm= FlagModel.fromJson(jsonDecode(res.body));
    if(res.statusCode == 200){
      return res.body;
    }
  }*/
}