import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  var _isUser = "";
  var _token;
  final _auth = FirebaseAuth.instance;
  var verificationId = '';
  var _profileCreated = false;

  bool get isAuth {
    return _auth.currentUser?.uid != null ? true : false;
  }

  bool get isProfile {
    return _profileCreated;
  }

  String get isUser {
    return _isUser;
  }

  String get token {
    return _token;
  }

  Future<void> authenticate(String phoneNo) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await _auth.signInWithCredential(credential).then((value) {});
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print("Invalid Number");
          } else {
            print(e);
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
        },
      );
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    try {
      var cred = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otp,
        ),
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('UID', _auth.currentUser!.uid);
      notifyListeners();
      return cred.user != null ? true : false;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future chooseUserType(String user) async {
    _isUser = user;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('UserType', user);
    prefs.setBool("Profile", false);
  }

  Future registerUser(String bio, String name, String phone, String email,
      String gender, String occupation, String interest, String profilePic) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      await users.doc(_auth.currentUser!.uid).set({
        'Name': name,
        'Bio': bio,
        "PhoneNo": phone,
        "UID": _auth.currentUser!.uid,
        "Email": email,
        "Gender": gender,
        "Occupation": occupation,
        "Interest": interest,
        "ProfilePic": profilePic,
      });
      final prefs = await SharedPreferences.getInstance();
      _profileCreated = true;
      prefs.setBool('Profile', _profileCreated);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('UID')) {
      return;
    }
    _token = prefs.getString('UID');
    _isUser = prefs.getString('UserType')!;
    _profileCreated = prefs.getBool('Profile')!;
    notifyListeners();
  }
}