class ChatModel{

  String UserId;
  String? ParentMessageId;
  String Message;

  ChatModel(this.UserId, this.ParentMessageId, this.Message);


  factory ChatModel.fromJson(var item) => ChatModel(item['UserId'], item['ParentMessageId'], item['Message']);
}