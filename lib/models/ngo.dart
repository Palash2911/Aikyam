import 'dart:io';

class Ngo {
  final String id;
  final String bio;
  final String name;
  final String email;
  final String phone;
  final String type;
  final String date;
  final String registered;
  final String city;
  final String state;
  final String about;
  final String category;
  File? localUrl;
  final String address;
  String firebaseUrl;
  List<dynamic> postId;

  Ngo({
    required this.id,
    required this.bio,
    required this.name,
    required this.email,
    required this.phone,
    required this.type,
    required this.date,
    required this.registered,
    required this.city,
    required this.state,
    required this.about,
    required this.category,
    required this.localUrl,
    required this.firebaseUrl,
    required this.postId,
    required this.address,
  });
}
