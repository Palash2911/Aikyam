import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  Future createChatRoom(String name, String description) async {
    final DatabaseReference chatRoomsRef = FirebaseDatabase.instance.reference().child('chat_rooms');
    final String roomId = chatRoomsRef.push().key.toString();
    chatRoomsRef.child(roomId).set({
      'name': name,
      'description': description,
    });
    notifyListeners();
  }

  void sendMessage(String roomId, String sender, String message) {
    print(sender);
    final DatabaseReference messagesRef = FirebaseDatabase.instance.reference().child('chat_rooms');
    messagesRef.child('-NQfgJuLKtQLoW3241aE').set({
      'sender': sender,
      'message': message,
    });
  }

}