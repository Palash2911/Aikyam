import 'package:flutter/material.dart';
import 'package:aikyam/models/ngo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class NgoProvider extends ChangeNotifier {
  Future registerNgo(Ngo ngo) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var storage = FirebaseStorage.instance;
      TaskSnapshot taskSnapshot = await storage
          .ref()
          .child('NProfile/${ngo.id}')
          .putFile(ngo.localUrl!);
      ngo.firebaseUrl = await taskSnapshot.ref.getDownloadURL();
      CollectionReference ngos = FirebaseFirestore.instance.collection('Ngo');
      await ngos.doc(ngo.id).set({
        'PostId': ngo.postId,
        'Name': ngo.name,
        'Bio': ngo.bio,
        "PhoneNo": ngo.phone,
        "UID": ngo.id,
        "Email": ngo.email,
        "DateofEst": ngo.date,
        "City": ngo.city,
        "Zipcode": ngo.zipcode,
        "State": ngo.state,
        "IsRegistered": ngo.registered,
        "Type": ngo.type,
        "Category": ngo.category,
        "ProfilePic": ngo.firebaseUrl,
        "AppliedPostId": [],
      });

      prefs.setBool('Profile', true);
      prefs.setString('ProfilePic', ngo.firebaseUrl);
      prefs.setString("UserName", ngo.name);
      notifyListeners();
    } catch (e) {
      prefs.setBool('Profile', false);
      prefs.setString('ProfilePic', "");
      prefs.setString("UserName", "");
      rethrow;
    }
  }

  Future<Ngo?> getNgoDetails(String uid) async {
    //instead of map Users user
    try {
      CollectionReference ngos = FirebaseFirestore.instance.collection('Ngo');
      Ngo? ngo;

      if (uid.isNotEmpty) {
        uid = uid;
      }
      await ngos.doc(uid.toString()).get().then((DocumentSnapshot query) {
        Map<String, dynamic> data = query.data() as Map<String, dynamic>;

        ngo = Ngo(
          id: data["UID"],
          bio: data["Bio"],
          name: data["Name"],
          email: data["Email"],
          phone: data["PhoneNo"],
          type: data["Type"],
          date: data["DateofEst"],
          registered: data["IsRegistered"],
          city: data["City"],
          state: data["State"],
          zipcode: data["Zipcode"],
          category: data["Category"],
          postId: data["PostId"],
          localUrl: null,
          firebaseUrl: data['ProfilePic'],
        );
      });
      notifyListeners();
      return ngo;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future updateNgo(Ngo ngo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (ngo.localUrl != null) {
        var storage = FirebaseStorage.instance;
        TaskSnapshot taskSnapshot = await storage
            .ref()
            .child('NProfile/${ngo.id}')
            .putFile(ngo.localUrl!);
        ngo.firebaseUrl = await taskSnapshot.ref.getDownloadURL();
      }
      CollectionReference ngos = FirebaseFirestore.instance.collection('Ngo');
      await ngos.doc(ngo.id).update({
        'Name': ngo.name,
        'Bio': ngo.bio,
        "PhoneNo": ngo.phone,
        "UID": ngo.id,
        "Email": ngo.email,
        "DateofEst": ngo.date,
        "City": ngo.city,
        "Zipcode": ngo.zipcode,
        "State": ngo.state,
        "IsRegistered": ngo.registered,
        "Type": ngo.type,
        "Category": ngo.category,
        "ProfilePic": ngo.firebaseUrl,
      });
      prefs.setString('ProfilePic', ngo.firebaseUrl);
      prefs.setString("UserName", ngo.name);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
