import 'package:aikyam/models/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  Future createMessageRoom(String receiverId, String senderId, String userType,
      String RName, String SName) async {
    print(RName + SName);
    try {
      if (userType == "Users") {
        CollectionReference chatRef = FirebaseFirestore.instance
            .collection('Users')
            .doc(senderId)
            .collection('Chats');

        await chatRef.get().then((value) async {
          if (value.docs.isEmpty) {
            await chatRef.doc(receiverId).set({
              'RecentMessage': "",
              "SName": RName,
            }).then((value) async {
              chatRef = FirebaseFirestore.instance
                  .collection('Ngo')
                  .doc(receiverId)
                  .collection('Chats');
              await chatRef.doc(senderId).set({
                'RecentMessage': "",
                "SName": SName,
              });
            });
          } else {
            await chatRef.doc(receiverId).get().then((value) async {
              if (!value.exists) {
                await chatRef.doc(receiverId).set({
                  'RecentMessage': "",
                  "SName": RName,
                }).then((value) async {
                  chatRef = FirebaseFirestore.instance
                      .collection('Ngo')
                      .doc(receiverId)
                      .collection('Chats');
                  await chatRef.doc(senderId).set({
                    'RecentMessage': "",
                    "SName": SName,
                  });
                });
              }
            });
          }
        });
      } else {
        CollectionReference chatRef = FirebaseFirestore.instance
            .collection('Ngo')
            .doc(senderId)
            .collection('Chats');
        await chatRef.get().then((value) async {
          if (value.docs.isEmpty) {
            await chatRef.doc(receiverId).set({
              'RecentMessage': "",
              "SName": RName,
            }).then((value) async {
              chatRef = FirebaseFirestore.instance
                  .collection('Ngo')
                  .doc(receiverId)
                  .collection('Chats');
              await chatRef.doc(senderId).set({
                'RecentMessage': "",
                "SName": SName,
              });
            });
          } else {
            await chatRef.doc(receiverId).get().then((value) async {
              if (!value.exists) {
                await chatRef.doc(receiverId).set({
                  'RecentMessage': "",
                  "SName": RName,
                }).then((value) async {
                  chatRef = FirebaseFirestore.instance
                      .collection('Ngo')
                      .doc(receiverId)
                      .collection('Chats');
                  await chatRef.doc(senderId).set({
                    'RecentMessage': "",
                    "SName": SName,
                  });
                });
              }
            });
          }
        });
      }
    } catch (e) {
      rethrow;
    }
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

      CollectionReference recentRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(chat.senderId)
          .collection('Chats');
      await recentRef.doc(chat.receiverId).update({
        'RecentMessage': chat.message,
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkSenderType(String id) async {
    var isUser = false;
    CollectionReference typeRef = FirebaseFirestore.instance.collection('Ngo');
    await typeRef.doc(id).get().then((value) {
      if (value.exists) {
        isUser = true;
      }
    });
    return isUser;
  }

  Future sendMessageN(Chats chat) async {
    print(chat.isUser);
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
      await recentRef.doc(chat.receiverId).update({
        'RecentMessage': chat.message,
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
