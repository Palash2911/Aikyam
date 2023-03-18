import 'package:aikyam/models/chats.dart';
import 'package:aikyam/providers/chatProvider.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/chatMessageBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreenOpen extends StatefulWidget {
  const ChatScreenOpen({required this.receiverId});
  final String receiverId;

  @override
  _ChatScreenOpenState createState() => _ChatScreenOpenState();
}

class _ChatScreenOpenState extends State<ChatScreenOpen> {
  final TextEditingController _textController = TextEditingController();
  final auth = FirebaseAuth.instance;
  CollectionReference messageRef =
      FirebaseFirestore.instance.collection('Ngo');
  var isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(isInit){
      messageRef = messageRef
          .doc('XoNt5kGfQcWJsXheKYHCiLbheAt1')
          .collection('Chats')
          .doc(widget.receiverId)
          .collection('Messages');
      print(auth.currentUser!.uid);
    }
    isInit = false;
    // Provider.of<ChatProvider>(context, listen: false).createChatRoom("ChatRoom", "Chatting");
  }

  void sendMessage(BuildContext ctx) async {
    await Provider.of<ChatProvider>(context, listen: false).sendMessageU(
      Chats(
        receiverId: 'XoNt5kGfQcWJsXheKYHCiLbheAt1',
        senderId: 'CvKdycC9GTkkI1q6aKjV',
        message: _textController.text,
        dateTime: DateTime.now().toString(),
        isUser: true,
      ),
    );
    await Provider.of<ChatProvider>(context, listen: false).sendMessageN(
      Chats(
        receiverId: 'CvKdycC9GTkkI1q6aKjV',
        senderId: 'XoNt5kGfQcWJsXheKYHCiLbheAt1',
        message: _textController.text,
        dateTime: DateTime.now().toString(),
        isUser: false,
      ),
    );
    _textController.clear();
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
                stream: messageRef.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
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
                            sendMessage(context);
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
