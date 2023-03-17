import 'package:aikyam/views/Screens/User/ChatScreenOpen.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:flutter/material.dart';
import '../../widgets/chatUser.dart';

class NgoChatScreen extends StatelessWidget {
  const NgoChatScreen({super.key});

  static const routeName = '/ngo_chat_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreenOpen(
                                receiverId: 'XoNt5kGfQcWJsXheKYHCiLbheAt1',
                              )),
                    );
                  },
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/ngo.png',
                ),
                ChatListItem(
                  onTap: () {},
                  name: 'Dip',
                  message: 'Its 4 am im doin this shit',
                  isOnline: false,
                  imageUrl: 'assets/images/profile.png',
                ),
                ChatListItem(
                  onTap: () {},
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/ngo.png',
                ),
                ChatListItem(
                  onTap: () {},
                  name: 'Dip',
                  message: 'Its 4 am im doin this shit',
                  isOnline: false,
                  imageUrl: 'assets/images/profile.png',
                ),
                ChatListItem(
                  onTap: () {},
                  name: 'Dip',
                  message: 'Its 4 am im doin this shit',
                  isOnline: false,
                  imageUrl: 'assets/images/profile.png',
                ),
                ChatListItem(
                  onTap: () {},
                  name: 'Dip',
                  message: 'Its 4 am im doin this shit',
                  isOnline: false,
                  imageUrl: 'assets/images/profile.png',
                ),
                ChatListItem(
                  onTap: () {},
                  name: 'Elon Musk',
                  message: '',
                  isOnline: false,
                  imageUrl: 'assets/images/profile.png',
                ),
                ChatListItem(
                  onTap: () {},
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/ngo.png',
                ),
                ChatListItem(
                  onTap: () {},
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/ngo.png',
                ),
                ChatListItem(
                  onTap: () {},
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/ngo.png',
                ),
                ChatListItem(
                  onTap: () {},
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/ngo.png',
                ),
                ChatListItem(
                  onTap: () {},
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/dp.jpg',
                ),
                ChatListItem(
                  onTap: () {},
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/dp.jpg',
                ),
                ChatListItem(
                  onTap: () {},
                  name: 'Smile Foundation',
                  message: 'Hii I would like to ..',
                  isOnline: true,
                  imageUrl: 'assets/images/dp.jpg',
                ),
                ChatListItem(
                  onTap: () {},
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
