import 'package:aikyam/providers/user_provider.dart';
import 'package:aikyam/views/Screens/User/ChatScreenOpen.dart';
import 'package:aikyam/views/Screens/User/EditProfile.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/UActivityPostItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    super.key,
    required this.authToken,
    required this.isUser,
  });
  final String authToken;
  final bool isUser;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isUserPov = true;
  var name = "";
  var profileUrl = "";
  var bio = "";
  var occupation = "";
  var interest = "";
  var email = "";
  var phone = "";
  var isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      _fetchDetails();
    }
    isInit = false;
  }

  void _fetchDetails() async {
    print(widget.authToken);
    await Provider.of<UserProvider>(context)
        .getUserDetails(widget.authToken)
        .then((value) {
      name = value!.name;
      email = value.email;
      phone = value.phone;
      occupation = value.occupation;
      interest = value.interest;
      profileUrl = value.firebaseUrl;
      bio = value.bio;
    });
  }

  void _chatScreen() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ChatScreenOpen(
          receiverId: widget.authToken,
          senderType: "Ngo",
          rName: name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
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
                                                const EditUser(),
                                          ),
                                        );
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
                              : CircleAvatar(
                                  backgroundColor: kprimaryColor,
                                  foregroundColor: ksecondaryColor,
                                  child: IconButton(
                                      onPressed: () {
                                        _chatScreen();
                                      },
                                      icon: const Icon(Icons.message_rounded)),
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
                  top: 60,
                  left: MediaQuery.of(context).size.width / 5 - 64,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: profileUrl.isNotEmpty
                        ? Image.network(profileUrl).image
                        : const AssetImage('assets/images/user.png'),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height,
              child: ContainedTabBarView(
                tabBarProperties:
                    const TabBarProperties(indicatorColor: Colors.transparent),
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
                          style: kTextPopM16.copyWith(color: ksecondaryColor),
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
                          style: kTextPopM16.copyWith(color: ksecondaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
                views: [
                  _About(
                      occupation: occupation,
                      interest: interest,
                      email: email,
                      phone: phone),
                  _Post(uid: widget.authToken),
                ],
                onChange: (index) {},
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
    required this.occupation,
    required this.interest,
    required this.email,
    required this.phone,
  });

  final String occupation;
  final String interest;
  final String email;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text('Information', style: kTextPopB16),
          const SizedBox(height: 8),
          ListTile(
            title: Text('Occupation', style: kTextPopM16),
            subtitle: Text(occupation, style: kTextPopR14),
          ),
          ListTile(
            title: Text('Interest', style: kTextPopM16),
            subtitle: Text(interest, style: kTextPopR14),
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

class _Post extends StatefulWidget {
  final String uid;

  const _Post({required this.uid});

  @override
  State<_Post> createState() => _PostState();
}

class _PostState extends State<_Post> {
  final auth = FirebaseAuth.instance;
  CollectionReference applyRef = FirebaseFirestore.instance.collection('Users');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    applyRef = applyRef.doc(widget.uid).collection("AppliedPost");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: applyRef.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        height: 200.0,
                        child: Image.asset(
                          'assets/images/loading.gif',
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  } else {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 300.0,
                              child: Image.asset(
                                'assets/images/noPost.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              "No Post Yet !",
                              style: kTextPopM16,
                            ),
                          ],
                        ),
                      );
                    }
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
