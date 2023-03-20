class Chats {
  final String receiverId;
  final String senderId;
  final String message;
  final String dateTime;
  final bool isUser;
  final String senderName;

  Chats({
    required this.receiverId,
    required this.senderId,
    required this.message,
    required this.dateTime,
    required this.isUser,
    required this.senderName,
  });
}
