import 'package:flutter/material.dart';
import 'package:aikyam/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class UserProvider extends ChangeNotifier {
  Future registerUser(Users user) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var storage = FirebaseStorage.instance;
      TaskSnapshot taskSnapshot =
          await storage.ref().child('Profile/${user.id}').putFile(user.profile);
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
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
        "ProfilePic": downloadUrl,
      });

      prefs.setBool('Profile', true);
      notifyListeners();
    } catch (e) {
      prefs.setBool('Profile', false);
      notifyListeners();
      rethrow;
    }
  }

  Future<Users?> getUserDetails(String uid) async {
    //instead of map Users user

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
            profile: File(data["ProfilePic"]));
      });

      print(user!.bio);
      return user;
    } catch (e) {
      print(e);
    }
  }
}
