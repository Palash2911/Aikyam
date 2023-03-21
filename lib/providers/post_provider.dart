import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:aikyam/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PostProvider extends ChangeNotifier {
  Future createPost(Post post) async {
    try {
      List<dynamic> postImages = [];
      if (post.photos.isNotEmpty) {
        var storage = FirebaseStorage.instance;
        TaskSnapshot taskSnapshot = await storage
            .ref()
            .child(
                'Posts/${'${post.ngoid}${DateFormat('h:mm a').format(DateTime.now())}1'}') //doubt here
            .putFile(post.photos[0]);
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        postImages.add(downloadUrl);
      }
      if (post.photos.length >= 2) {
        var storage = FirebaseStorage.instance;
        TaskSnapshot taskSnapshot = await storage
            .ref()
            .child(
                'Posts/${'${post.ngoid}${DateFormat('h:mm a').format(DateTime.now())}2'}') //doubt here
            .putFile(post.photos[1]);
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        postImages.add(downloadUrl);
      }
      if (post.photos.length == 3) {
        var storage = FirebaseStorage.instance;
        TaskSnapshot taskSnapshot = await storage
            .ref()
            .child(
                'Posts/${'${post.ngoid}${DateFormat('h:mm a').format(DateTime.now())}3'}') //doubt here
            .putFile(post.photos[2]);
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        postImages.add(downloadUrl);
      }
      CollectionReference ngos = FirebaseFirestore.instance.collection('Ngo');
      CollectionReference posts =
          FirebaseFirestore.instance.collection('Posts');
      var p = await posts.add({
        'NgoName': post.ngoname,
        'NgoCity': post.ncity,
        'Description': post.description,
        'NoOfVolunteers': post.noofVolunters,
        "Date": post.date,
        "Time": post.time,
        "Address": post.address,
        "City": post.city,
        "State": post.state,
        "NgoId": post.ngoid,
        "Country": post.country,
        "Photos": postImages,
      });

      post.id = p.id;
      List<dynamic> postId = [];
      await ngos.doc(post.ngoid).get().then((snapshot) {
        postId = snapshot['PostId'];
      });
      postId.add(post.id);
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
        'NgoName': post.ngoname,
        'NgoCity': post.ncity,
        'NoOfVolunteers': post.noofVolunters,
        "Date": post.date,
        "Time": post.time,
        "Address": post.address,
        "City": post.city,
        "State": post.state,
        "Ngoid": post.ngoid,
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
//NGO MODEL:create new feild List of dynamic  named postId, put in constuctor too;
//NGO PROVIDER: post id add in .set in register user  named PostsId
//after 31 in POST PROVIDER: fetch ngo first:specie ke jagah postid;
//in fetch add await ngos.doc().get and follow stackoverflow;
//post id add in doc()
//finally update
