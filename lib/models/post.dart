class Post {
  String id;
  final String cid;
  final String cname;
  final String salary;
  final String title;
  final String city;
  final String state;
  final String duration;
  final String location;
  final String startDate;
  final String workinghrs;
  final List<dynamic> responsibility;
  final List<dynamic> skills;

  Post({
    required this.startDate,
    required this.id,
    required this.cid,
    required this.salary,
    required this.title,
    required this.city,
    required this.state,
    required this.duration,
    required this.location,
    required this.workinghrs,
    required this.responsibility,
    required this.skills,
    required this.cname,
  });
}
