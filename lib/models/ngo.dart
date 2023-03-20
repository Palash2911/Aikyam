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
  final String zipcode;
  final String category;
  final File profile;
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
    required this.zipcode,
    required this.category,
    required this.profile,
    required this.postId,
  });
}
