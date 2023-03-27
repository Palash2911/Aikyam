import 'package:aikyam/models/chats.dart';
import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/providers/chat_provider.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/chatMessageBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatScreenOpen extends StatefulWidget {
  const ChatScreenOpen({
    super.key,
    required this.receiverId,
    required this.senderType,
    required this.rName,
  });
  final String receiverId;
  final String senderType;
  final String rName;

  @override
  _ChatScreenOpenState createState() => _ChatScreenOpenState();
}

class _ChatScreenOpenState extends State<ChatScreenOpen> {
  final TextEditingController _textController = TextEditingController();
  final auth = FirebaseAuth.instance;
  CollectionReference? messageRef;
  var isInit = true;
  var mssg = "";
  var isLoading = true;
  var rType = "Ngo";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      createMessageRoom();
    }
    isInit = false;
  }

  void createMessageRoom() async {
    var sname = Provider.of<Auth>(context, listen: false).uName;
    await Provider.of<ChatProvider>(context, listen: false)
        .checkSenderType(widget.receiverId)
        .then((value) async {
      rType = (!value ? "Users" : "Ngo");
      await Provider.of<ChatProvider>(context, listen: false)
          .createMessageRoom(widget.receiverId, auth.currentUser!.uid,
              widget.senderType, widget.rName, sname)
          .then((value) {
        messageRef = FirebaseFirestore.instance
            .collection(widget.senderType)
            .doc(auth.currentUser!.uid)
            .collection('Chats')
            .doc(widget.receiverId)
            .collection('Messages');
        setState(() {
          isLoading = false;
        });
      });
    });
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
          senderName: "",
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
            senderName: "",
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
          senderName: "",
        ),
      )
          .then((value) async {
        if (rType == "Users") {
          await Provider.of<ChatProvider>(context, listen: false).sendMessageU(
            Chats(
              receiverId: auth.currentUser!.uid,
              senderId: widget.receiverId,
              message: mssg,
              dateTime: DateFormat('MMM d, h:mm a').format(DateTime.now()),
              isUser: false,
              senderName: "",
            ),
          );
        } else {
          await Provider.of<ChatProvider>(context, listen: false).sendMessageN(
            Chats(
              receiverId: auth.currentUser!.uid,
              senderId: widget.receiverId,
              message: mssg,
              dateTime: DateFormat('MMM d, h:mm a').format(DateTime.now()),
              isUser: false,
              senderName: "",
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: SizedBox(
                height: 200.0,
                child: Image.asset(
                  'assets/images/loading.gif',
                  fit: BoxFit.contain,
                ),
              ),
            )
          : SafeArea(
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
                              Text(widget.rName, style: kTextPopM16),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: messageRef!
                          .orderBy('DateTime', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.data!.docs.isEmpty) {
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
                              children: snapshot.data!.docs.map((document) {
                                return MessageBubble(
                                  sender: "",
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
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send),
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
