import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final String name;
  final String message;
  final bool isOnline;
  final String imageUrl;
  final Function() onTap;

  const ChatListItem({
    Key? key,
    required this.name,
    required this.message,
    required this.isOnline,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
        leading: CircleAvatar(
          radius: 25.0,
          backgroundImage: AssetImage(imageUrl),
        ),
        title: Text(
          name,
          style: kTextPopB14
        ),
        subtitle: Text(message,style: kTextPopR12,),
        trailing: isOnline
            ? Icon(Icons.circle, color: Colors.green)
            : Icon(Icons.circle, color: Colors.grey));
  }
}
