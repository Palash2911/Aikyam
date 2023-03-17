import 'package:aikyam/models/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  Future createChatRoom(String name, String description) async {
    final DatabaseReference chatRoomsRef =
        FirebaseDatabase.instance.reference().child('chat_rooms');
    final String roomId = chatRoomsRef.push().key.toString();
    chatRoomsRef.child(roomId).set({
      'name': name,
      'description': description,
    });
    notifyListeners();
  }

  Future sendMessage(Chats chat) async {
    try {
      CollectionReference messageRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(chat.senderId)
          .collection('Chats')
          .doc(chat.receiverId)
          .collection('Messages');

      await messageRef.add({
        'Message': chat.message,
        'DateTime': chat.dateTime,
        'isUser': true,
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
