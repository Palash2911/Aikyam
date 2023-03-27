import 'package:aikyam/views/Screens/User/ChatScreenOpen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/chatUser.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const routeName = '/chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final auth = FirebaseAuth.instance;
  CollectionReference? chatRef;
  var isInit = true;
  var chatExists = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      fetchChat();
    }
    isInit = false;
  }

  Future<void> fetchChat() async {
    chatRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Chats");
    await chatRef!.get().then((value) {
      if (value.docs.isEmpty) {
        setState(() {
          chatExists = false;
        });
      } else {
        setState(() {
          chatExists = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: fetchChat,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            toolbarHeight: 85,
            flexibleSpace: const RoundAppBar(
              title: 'Chat',
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height -
                    kBottomNavigationBarHeight,
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: chatRef!.snapshots(),
                        builder: (context, snapshot) {
                          {
                            if (!snapshot.hasData) {
                              return Center(
                                child: Container(
                                  height: 200,
                                  margin: const EdgeInsets.only(top: 60),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/loading.gif',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              if (snapshot.data!.docs.isEmpty || !chatExists) {
                                return Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 300.0,
                                        child: Image.asset(
                                          'assets/images/startchat.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Text(
                                        "Start Chatting !",
                                        style: kTextPopM16,
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return ListView(
                                  shrinkWrap: true,
                                  children: snapshot.data!.docs.map((document) {
                                    return ChatListItem(
                                      name: document['SName'],
                                      message: document["RecentMessage"],
                                      isOnline: true,
                                      imageUrl: "assets/images/ngo.png",
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChatScreenOpen(
                                              receiverId: document.id,
                                              senderType: "Users",
                                              rName: document["SName"],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                );
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
