import 'package:aikyam/models/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {

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

      CollectionReference recentRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(chat.senderId)
          .collection('Chats');

      if (chat.isUser) {
        await recentRef.doc(chat.receiverId).update({
          'RecentMessage': chat.message,
        });
      }
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

      CollectionReference recentRef = FirebaseFirestore.instance
          .collection('Ngo')
          .doc(chat.senderId)
          .collection('Chats');
      
      if(chat.isUser)
        {
          await recentRef.doc(chat.receiverId).update({
            'RecentMessage': chat.message,
          });
        }

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
