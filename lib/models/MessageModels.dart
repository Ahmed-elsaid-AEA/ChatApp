class MessageModels {
  final String message;
  final String id;

  MessageModels(this.message,this.id);

  factory MessageModels.fromJson(  jsonData) {
    return MessageModels(jsonData['message'],jsonData['id']);
  }
}
