import 'package:flutter/material.dart';
import 'package:aikyam/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  Future registerUser(Users user) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var storage = FirebaseStorage.instance;
      TaskSnapshot taskSnapshot = await storage
          .ref()
          .child('Profile/${user.id}')
          .putFile(user.localUrl!);
      user.firebaseUrl = await taskSnapshot.ref.getDownloadURL();
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      await users.doc(user.id).set({
        'Name': user.name,
        'Bio': user.bio,
        "PhoneNo": user.phone,
        "UID": user.id,
        "Email": user.email,
        "Gender": user.gender,
        "Occupation": user.occupation,
        "Interest": user.interest,
        "ProfilePic": user.firebaseUrl,
      });

      prefs.setBool('Profile', true);
      prefs.setString('ProfilePic', user.firebaseUrl);
      prefs.setString("UserName", user.name);
      notifyListeners();
    } catch (e) {
      prefs.setBool('Profile', false);
      prefs.setString('ProfilePic', "");
      prefs.setString("UserName", "");
      notifyListeners();
      rethrow;
    }
  }

  Future<Users?> getUserDetails(String uid) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      Users? user;

      if (uid.isNotEmpty) {
        uid = uid;
      }
      await users.doc(uid.toString()).get().then((DocumentSnapshot query) {
        Map<String, dynamic> data = query.data() as Map<String, dynamic>;
        user = Users(
          id: data["UID"],
          bio: data["Bio"],
          name: data["Name"],
          email: data["Email"],
          phone: data["PhoneNo"],
          gender: data["Gender"],
          occupation: data["Occupation"],
          interest: data["Interest"],
          localUrl: null,
          firebaseUrl: data['ProfilePic'],
        );
      });
      notifyListeners();
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future updateUser(Users user) async {
      final prefs = await SharedPreferences.getInstance();
    try {
      if (user.localUrl != null) {
        var storage = FirebaseStorage.instance;
        TaskSnapshot taskSnapshot = await storage
            .ref()
            .child('Profile/${user.id}')
            .putFile(user.localUrl!);
        user.firebaseUrl = await taskSnapshot.ref.getDownloadURL();
      }
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      await users.doc(user.id).update({
        'Name': user.name,
        'Bio': user.bio,
        "PhoneNo": user.phone,
        "UID": user.id,
        "Email": user.email,
        "Gender": user.gender,
        "Occupation": user.occupation,
        "Interest": user.interest,
        "ProfilePic": user.firebaseUrl,
      });
      prefs.setString('ProfilePic', user.firebaseUrl);
      prefs.setString("UserName", user.name);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
