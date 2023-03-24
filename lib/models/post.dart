class Post {
  String id;
  final String category;
  final String ngoid;
  final String description;
  final String noofVolunters;
  final String date;
  final String time;
  final String address;
  final String state;
  final String ncity;
  final String ngoname;
  final String city;
  final String driveTitle;
  final String country;
  final double likeCount;
  final List<dynamic> photos;

  Post({
    required this.category,
    required this.description,
    required this.ngoid,
    required this.id,
    required this.noofVolunters,
    required this.date,
    required this.time,
    required this.city,
    required this.driveTitle,
    required this.ncity,
    required this.ngoname,
    required this.state,
    required this.address,
    required this.country,
    required this.photos,
    required this.likeCount,
  });
}
