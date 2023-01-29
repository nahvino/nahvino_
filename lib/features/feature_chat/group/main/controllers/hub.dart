import 'package:Nahvino/features/feature_chat/config/chat_config.dart';
import 'package:signalr_core/signalr_core.dart';

class HubConnectionn{
  //con
  final connection = HubConnectionBuilder()
      .withUrl(
    ChatConfig.mainisurl,
    HttpConnectionOptions(
      logging: (level, message) => print(message),
    ),
  )
      .withAutomaticReconnect()
      .build();

  Future<void> openSignalRConnection() async {
    await connection.start();
  }

}