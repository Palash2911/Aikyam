import 'dart:io';

class Users {
  final String id;
  final String bio;
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String occupation;
  final String interest;
  final File? localUrl;
  String firebaseUrl;

  Users({
    required this.id,
    required this.bio,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.occupation,
    required this.interest,
    required this.localUrl,
    required this.firebaseUrl,
  });
}
