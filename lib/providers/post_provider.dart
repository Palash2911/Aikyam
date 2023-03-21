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
      CollectionReference ngos = FirebaseFirestore.instance.collection('Ngo');
      CollectionReference posts =
          FirebaseFirestore.instance.collection('Posts');
      var p = await posts.add({
        'Name': post.ngoname,
        'NgoCity': post.ncity,
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
      List<dynamic> postId = [];
      await ngos.doc(post.ngoid).get().then((snapshot) {
        postId = snapshot['PostId'];
      });
      postId.add(post.ngoid);
      await ngos.doc(post.ngoid).update({
        'PostId': postId,
      });

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future updatePost(Post post) async {
    try {
      // var storage = FirebaseStorage.instance;
      // TaskSnapshot taskSnapshot = await storage
      //     .ref()
      //     // .child('NProfile/${post.id}') //doubt here
      //     .putFile(post.photos as File);
      // final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      CollectionReference posts =
          FirebaseFirestore.instance.collection('Posts');
      var p = await post.doc(post.id).update({
        'Description': post.description,
        'Name': post.ngoname,
        'NgoCity': post.ncity,
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

      // prefs.setBool('Profile', true);
      notifyListeners();
    } catch (e) {
      // prefs.setBool('Profile', false);
      rethrow;
    }
  }
}

Future deletePost(String id) async {
  final db = FirebaseFirestore.instance;
  await db.collection("Posts").doc(id).delete();
}
