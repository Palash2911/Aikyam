class Post {
  String id;
  final String ngoid;
  final String description;
  final String noofVolunters;
  final String date;
  final String time;
  final String address;
  final String state;
  final String city;
  final String country;
  final List<dynamic> photos;

  Post({
    required this.description,
    required this.ngoid,
    required this.id,
    required this.noofVolunters,
    required this.date,
    required this.time,
    required this.city,
    required this.state,
    required this.address,
    required this.country,
    required this.photos,
  });
}

// post madhe ngo id;
//baki feild by dip, 
//final listfile photos
//create post provider and add in main.dart
//createpost function in post provider
//similar to registeruser function name Post in post provider
//@override
  // Future<bool> updateUser(String name, String phoneNo, String gender) async {  //edit user and editngo instead ofupdateuser
  //   try {
  //     CollectionReference users =
  //         FirebaseFirestore.instance.collection('Users');
  //     users.doc(_auth.currentUser?.uid).update({
  //       "Name": name,
  //       "Gender": gender,
  //       "PhoneNo": phoneNo,
  //     });
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }}
  
//