import 'package:aikyam/models/chats.dart';
import 'package:aikyam/providers/chatProvider.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/chatMessageBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatScreenOpen extends StatefulWidget {
  const ChatScreenOpen({
    required this.receiverId,
    required this.senderType,
  });
  final String receiverId;
  final String senderType;

  @override
  _ChatScreenOpenState createState() => _ChatScreenOpenState();
}

class _ChatScreenOpenState extends State<ChatScreenOpen> {
  final TextEditingController _textController = TextEditingController();
  final auth = FirebaseAuth.instance;
  CollectionReference? messageRef;
  var isInit = true;
  var mssg = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      messageRef = FirebaseFirestore.instance
          .collection(widget.senderType)
          .doc(auth.currentUser!.uid)
          .collection('Chats')
          .doc(widget.receiverId)
          .collection('Messages');
    }
    isInit = false;
    // Provider.of<ChatProvider>(context, listen: false).createChatRoom("ChatRoom", "Chatting");
  }

  void sendMessage(BuildContext ctx) async {
    if (widget.senderType == 'Users') {
      await Provider.of<ChatProvider>(context, listen: false)
          .sendMessageU(
        Chats(
          receiverId: widget.receiverId,
          senderId: auth.currentUser!.uid,
          message: mssg,
          dateTime: DateFormat('MMM d, h:mm a').format(DateTime.now()),
          isUser: true,
          senderName: "Palash",
        ),
      )
          .then((value) async {
        await Provider.of<ChatProvider>(context, listen: false).sendMessageN(
          Chats(
            receiverId: auth.currentUser!.uid,
            senderId: widget.receiverId,
            message: mssg,
            dateTime: DateFormat('MMM d, h:mm a').format(DateTime.now()),
            isUser: false,
            senderName: "Palash",
          ),
        );
      });
    } else {
      await Provider.of<ChatProvider>(context, listen: false)
          .sendMessageN(
        Chats(
          receiverId: widget.receiverId,
          senderId: auth.currentUser!.uid,
          message: mssg,
          dateTime: DateFormat('MMM d, h:mm a').format(DateTime.now()),
          isUser: true,
          senderName: "Palash",
        ),
      )
          .then((value) async {
        await Provider.of<ChatProvider>(context, listen: false).sendMessageU(
          Chats(
            receiverId: auth.currentUser!.uid,
            senderId: widget.receiverId,
            message: mssg,
            dateTime: DateFormat('MMM d, h:mm a').format(DateTime.now()),
            isUser: false,
            senderName: "Palash",
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        height: 70.0,
                        width: 70.0,
                        color: Colors.red,
                        child: Image.asset('assets/images/ngo.png'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Smile Foundation', style: kTextPopM16),
                        Text(
                          'Active 5 mins ago',
                          style: kTextPopR12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    messageRef!.orderBy('DateTime', descending: false).snapshots(),
                builder: (context, snapshot) {
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
                        children: snapshot.data!.docs.map((document) {
                          return MessageBubble(
                            sender: "Palash",
                            text: document['Message'],
                            isUser: document['isUser'],
                            dateTime: document['DateTime'],
                          );
                        }).toList(),
                      );
                    }
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            if (_textController.text.isNotEmpty) {
                              setState(() {
                                mssg = _textController.text;
                              });
                              sendMessage(context);
                              _textController.clear();
                            }
                          },
                        ),
                        hintText: 'Message',
                        hintStyle: kTextPopR14,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 2, color: kprimaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
