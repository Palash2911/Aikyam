import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final String name;
  final String message;
  final bool isOnline;
  final String imageUrl;

  const ChatListItem({
    Key? key,
    required this.name,
    required this.message,
    required this.isOnline,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          radius: 25.0,
          backgroundImage: AssetImage(imageUrl),
        ),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(message),
        trailing: isOnline
            ? Icon(Icons.circle, color: Colors.green)
            : Icon(Icons.circle, color: Colors.grey));
  }
}
