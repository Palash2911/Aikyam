import 'package:aikyam/views/Screens/User/ChatScreenOpen.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/chatUser.dart';

class NgoChatScreen extends StatefulWidget {
  const NgoChatScreen({super.key});

  static const routeName = '/ngo_chat_screen';

  @override
  State<NgoChatScreen> createState() => _NgoChatScreenState();
}

class _NgoChatScreenState extends State<NgoChatScreen> {
  final auth = FirebaseAuth.instance;
  CollectionReference? chatRef;
  var isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      chatRef = FirebaseFirestore.instance
          .collection("Ngo")
          .doc(auth.currentUser!.uid)
          .collection("Chats");
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: chatRef!.snapshots(),
                    builder: (context, snapshot) {
                      {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text("Start Chatting !"),
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
                                        builder: (context) => ChatScreenOpen(
                                          receiverId: document.id,
                                          senderType: "Ngo",
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
