class ChatModel {
  final String chat;
  final String userName;
  final String time;
  final bool isUser;

  ChatModel({
    required this.chat,
    required this.userName,
    required this.time,
    required this.isUser,
  });

  // factory ChatModel.fromJson(Map<String, dynamic> json) {
  //   return ChatModel(
  //     chat: json['CHAT'],
  //     time: json['TIME'],
  //     isUser: json['ISUSER'],
  //   );
  // }
}
