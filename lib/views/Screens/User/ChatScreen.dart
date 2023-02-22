import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:flutter/material.dart';

import '../../widgets/chatUser.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static const routeName = '/chat_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 85,
          flexibleSpace: RoundAppBar(
            title: 'Chat',
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: ListView(
              children: [
                ChatListItem(
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/dp.jpg',
                ),
                ChatListItem(
                  name: 'Dip',
                  message: 'Its 4 am im doin this shit',
                  isOnline: false,
                  imageUrl: 'assets/images/profile.png',
                ),
                ChatListItem(
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/dp.jpg',
                ),
                ChatListItem(
                  name: 'Dip',
                  message: 'Its 4 am im doin this shit',
                  isOnline: false,
                  imageUrl: 'assets/images/profile.png',
                ),
                ChatListItem(
                  name: 'Dip',
                  message: 'Its 4 am im doin this shit',
                  isOnline: false,
                  imageUrl: 'assets/images/profile.png',
                ),
                ChatListItem(
                  name: 'Dip',
                  message: 'Its 4 am im doin this shit',
                  isOnline: false,
                  imageUrl: 'assets/images/profile.png',
                ),
                ChatListItem(
                  name: 'Elon Musk',
                  message: '',
                  isOnline: false,
                  imageUrl: 'assets/images/profile.png',
                ),
                ChatListItem(
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/dp.jpg',
                ),
                ChatListItem(
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/dp.jpg',
                ),
                ChatListItem(
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/dp.jpg',
                ),
                ChatListItem(
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/dp.jpg',
                ),
                ChatListItem(
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/dp.jpg',
                ),
                ChatListItem(
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/dp.jpg',
                ),
                ChatListItem(
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/dp.jpg',
                ),
                ChatListItem(
                  name: 'Elon Musk',
                  message: '',
                  isOnline: false,
                  imageUrl: 'assets/images/profile.png',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
