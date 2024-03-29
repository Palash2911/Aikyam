import 'package:aikyam/models/post.dart';
import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/providers/ngo_provider.dart';
import 'package:aikyam/views/Screens/Ngo/NeditProfile.dart';
import 'package:aikyam/views/Screens/User/ChatScreenOpen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/Post.dart';
import 'package:aikyam/views/widgets/UActivityPostItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NgoProfile extends StatefulWidget {
  const NgoProfile({
    required this.authToken,
    required this.isUser,
  });
  final String authToken;
  final bool isUser;

  @override
  State<NgoProfile> createState() => _NgoProfileState();
}

class _NgoProfileState extends State<NgoProfile> {
  bool isNgoPov = true;
  var profileUrl = "";
  var name = "";
  var about = "";
  var bio = "";
  var email = "";
  var phone = "";
  var type = "";
  var est = "";
  var category = "";
  var senderId = "";
  var isInit = true;
  var isUser = "Users";
  var url = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      _fetchDetails();
    }
    isInit = false;
  }

  void _fetchDetails() async {
    senderId = Provider.of<Auth>(context).token;
    isUser = Provider.of<Auth>(context).isUser == "NGO" ? "Ngo" : "Users";
    await Provider.of<NgoProvider>(context)
        .getNgoDetails(widget.authToken)
        .catchError((e) {})
        .then((value) {
      name = value!.name;
      email = value.email;
      phone = value.phone;
      profileUrl = value.firebaseUrl;
      est = value.date;
      type = value.type;
      category = value.category;
      about = value.about;
      bio = value.bio;
      url = value.webUrl;
    });
  }

  void _chatScreen() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ChatScreenOpen(
          receiverId: widget.authToken,
          senderType: isUser,
          rName: name,
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: !widget.isUser ? const Text("NGO Profile") :  const Text('My Profile'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 110,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/cover.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 36.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                name,
                                style: kTextPopB24,
                              ),
                            ),
                            widget.isUser
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 15.0),
                                      color: kprimaryColor,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const NgoEditProfile()));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              size: 24.0,
                                              color: ksecondaryColor,
                                            ),
                                            const SizedBox(width: 10.0),
                                            Text(
                                              'Edit',
                                              style: kTextPopB14.copyWith(
                                                  color: ksecondaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: kprimaryColor,
                                        foregroundColor: ksecondaryColor,
                                        child: IconButton(
                                          onPressed: _launchUrl,
                                          icon: const Icon(Icons.link_rounded),
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      CircleAvatar(
                                        backgroundColor: kprimaryColor,
                                        foregroundColor: ksecondaryColor,
                                        child: IconButton(
                                          onPressed: () {
                                            _chatScreen();
                                          },
                                          icon:
                                              const Icon(Icons.message_rounded),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          bio,
                          style: kTextPopR14,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: MediaQuery.of(context).size.width / 5 - 54,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: SizedBox(
                        height: 90.0,
                        width: 90.0,
                        child: profileUrl.isNotEmpty
                            ? Image.network(
                                profileUrl,
                                fit: BoxFit.cover,
                              )
                            : Image.asset('assets/images/ngo.png',
                                fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height + 200,
                  child: ContainedTabBarView(
                    tabBarProperties: const TabBarProperties(
                        indicatorColor: Colors.transparent),
                    tabs: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        color: kprimaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 24.0,
                              color: ksecondaryColor,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              'About',
                              style:
                                  kTextPopM16.copyWith(color: ksecondaryColor),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        color: kprimaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.work,
                              size: 24.0,
                              color: ksecondaryColor,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              'Post',
                              style:
                                  kTextPopM16.copyWith(color: ksecondaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                    views: [
                      _About(
                        about: about,
                        type: type,
                        category: category,
                        estd: est,
                        email: email,
                        phone: phone,
                      ),
                      isNgoPov
                          ? _Post(
                              authToken: widget.authToken,
                            )
                          : PostItem(
                              userType: 'userType',
                              post: Post(
                                  category: 'category',
                                  description: 'description',
                                  ngoid: 'ngoid',
                                  id: 'id',
                                  noofVolunters: 'noofVolunters',
                                  date: 'date',
                                  time: 'time',
                                  city: 'city',
                                  driveTitle: 'driveTitle',
                                  ncity: 'ncity',
                                  ngoname: 'ngoname',
                                  state: 'state',
                                  address: 'address',
                                  country: 'country',
                                  photos: []),
                              applyStatus: 'applyStatus'),
                    ],
                    onChange: (index) {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Post extends StatefulWidget {
  final String authToken;

  const _Post({required this.authToken});
  @override
  State<_Post> createState() => _PostState();
}

class _PostState extends State<_Post> {
  CollectionReference applyRef = FirebaseFirestore.instance.collection('Ngo');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    applyRef = applyRef.doc(widget.authToken).collection("AppliedPost");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 400,
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: applyRef.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 220.0,
                              child: Image.asset(
                                'assets/images/noPost.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              "No Post Applied Yet !",
                              style: kTextPopM16,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map((document) {
                          return UActivityPostItem(
                            ngoName: document["NgoName"],
                            ngoCity: document["NgoCity"],
                            driveCity: document["City"],
                            date: document["Date"],
                            time: document["Time"],
                            applyStatus: document['ApplicationStatus'],
                            pid: document.id,
                          );
                        }).toList(),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _About extends StatelessWidget {
  const _About({
    required this.about,
    required this.type,
    required this.category,
    required this.estd,
    required this.email,
    required this.phone,
  });
  final String about;
  final String type;
  final String category;
  final String estd;
  final String email;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About', style: kTextPopB16),
          const SizedBox(height: 8),
          Text(about, style: kTextPopR14),
          const SizedBox(height: 10),
          const Divider(),
          Text('Information', style: kTextPopB16),
          const SizedBox(height: 8),
          ListTile(
            title: Text('Type', style: kTextPopM16),
            subtitle: Text(type, style: kTextPopR14),
          ),
          ListTile(
            title: Text('Category', style: kTextPopM16),
            subtitle: Text(category, style: kTextPopR14),
          ),
          ListTile(
            title: Text('Established in', style: kTextPopM16),
            subtitle: Text(
              estd,
              style: kTextPopR14,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          Text('Contact', style: kTextPopB16),
          const SizedBox(height: 8),
          ListTile(
            title: Text('Email id', style: kTextPopM16),
            subtitle: Text(email, style: kTextPopR14),
          ),
          ListTile(
            title: Text('Mobile Number', style: kTextPopM16),
            subtitle: Text("+91 $phone", style: kTextPopR14),
          ),
        ],
      ),
    );
  }
}
