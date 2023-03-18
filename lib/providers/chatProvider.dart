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

  Future sendMessageU(Chats chat) async {
    try {
      CollectionReference messageURef = FirebaseFirestore.instance
          .collection('Users')
          .doc(chat.senderId)
          .collection('Chats')
          .doc(chat.receiverId)
          .collection('Messages');

      await messageURef.add({
        'Message': chat.message,
        'DateTime': chat.dateTime,
        'isUser': chat.isUser,
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future sendMessageN(Chats chat) async {
    try {
      CollectionReference messageNRef = FirebaseFirestore.instance
          .collection('Ngo')
          .doc(chat.senderId)
          .collection('Chats')
          .doc(chat.receiverId)
          .collection('Messages');

      await messageNRef.add({
        'Message': chat.message,
        'DateTime': chat.dateTime,
        'isUser': chat.isUser,
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
