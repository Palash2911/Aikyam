import 'package:flutter/material.dart';
import 'package:aikyam/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostProvider extends ChangeNotifier {
  Future createPost(Post post) async {
    try {
      // var storage = FirebaseStorage.instance;
      // TaskSnapshot taskSnapshot = await storage
      //     .ref()
      //     // .child('NProfile/${post.id}') //doubt here
      //     .putFile(post.photos as File);
      // final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      CollectionReference posts =
          FirebaseFirestore.instance.collection('Posts');
      var p = await posts.add({
        'Description': post.description,
        'NoOfVolunteers': post.noofVolunters,
        "Date": post.date,
        "Time": post.time,
        "Address": post.address,
        "City": post.city,
        "State": post.state,
        "Ngoid": post.ngoid,
        // "Uid": post.id,
        "Country": post.country,
        "Photos": post.photos,
      });
      post.id = p.id;
      // prefs.setBool('Profile', true);
      notifyListeners();
    } catch (e) {
      // prefs.setBool('Profile', false);
      rethrow;
    }
  }

  // Future<Post?> getUserDetails(String uid) async {
  //   //instead of map Users user

  //   try {
  //     CollectionReference ngos = FirebaseFirestore.instance.collection('Post');
  //     Post? post;

  //     if (uid.isNotEmpty) {
  //       uid = uid;
  //     }
  //     await ngos.doc(uid.toString()).get().then((DocumentSnapshot query) {
  //       Map<String, dynamic> data = query.data() as Map<String, dynamic>;

  //       posts = Post(
  //           id: data["UID"],
  //           date: data["DateofEst"],
  //           city: data["City"],
  //           state: data["State"],
  //           photos: (data["Photos"])) as CollectionReference<Post?>;
  //     });

  //     print(post!.description);
  //     return post;
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
