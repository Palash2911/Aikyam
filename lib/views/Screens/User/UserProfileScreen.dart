import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/providers/user_provider.dart';
import 'package:aikyam/views/Screens/User/EditProfile.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/Post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isSelected = true;
  bool _isUserPov = true;
  bool _isAboutActive = true;
  var name = "";
  var profileUrl = "";
  var bio = "";
  var occupation = "";
  var interest = "";
  var email = "";
  var phone = "";

  void _toggleButton() {
    setState(() {
      _isAboutActive = !_isAboutActive;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchDetails();
  }

  void _fetchDetails() async {
    var authToken = Provider.of<Auth>(context).token;
    await Provider.of<UserProvider>(context)
        .getUserDetails(authToken)
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
            Container(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 110,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/post2.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 36.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              name,
                              style: kTextPopB24,
                            ),
                            ClipRRect(
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
                                                  EditUser()));
                                    },
                                    child: _isUserPov
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                size: 24.0,
                                                color: ksecondaryColor,
                                              ),
                                              const SizedBox(width: 10.0),
                                              Text('Edit',
                                                  style: kTextPopB14.copyWith(
                                                      color: ksecondaryColor)),
                                            ],
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.chat_bubble,
                                                size: 24.0,
                                                color: ksecondaryColor,
                                              ),
                                              const SizedBox(width: 10.0),
                                              Text('Chat',
                                                  style: kTextPopB14.copyWith(
                                                      color: ksecondaryColor)),
                                            ],
                                          )),
                              ),
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
                          : const AssetImage('assets/images/dp.jpg'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.blue,
              width: double.maxFinite,
              height: double.maxFinite,
              child: ContainedTabBarView(
                tabs: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    color: kprimaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 24.0,
                          color: ksecondaryColor,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'About',
                          style: kTextPopM16.copyWith(color: ksecondaryColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    color: kprimaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.work,
                          size: 24.0,
                          color: ksecondaryColor,
                        ),
                        SizedBox(width: 5.0),
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
                  _Post()
                ],
                onChange: (index) => print(index),
              ),
            ),
            _About(
                occupation: occupation,
                interest: interest,
                email: email,
                phone: phone),
            _Post()
          ],
        ),
      ),
    );
  }
}

class _About extends StatelessWidget {
  const _About({
    super.key,
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
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Divider(),
          Text('Information', style: kTextPopB16),
          SizedBox(height: 8),
          ListTile(
            title: Text('Occupation', style: kTextPopM16),
            subtitle: Text(occupation, style: kTextPopR14),
          ),
          ListTile(
            title: Text('Interest', style: kTextPopM16),
            subtitle: Text(interest, style: kTextPopR14),
          ),
          SizedBox(height: 10),
          Divider(),
          Text('Contact', style: kTextPopB16),
          SizedBox(height: 8),
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

class _Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      // add post here which ever wanted
      children: const [
        PostItem(
          ngoname: 'ngoname',
          ngocity: 'ngocity',
          drivecity: 'drivecity',
          driveaddress: 'driveaddress',
          driveDate: 'driveDate',
          applyStatus: 'applyStatus',
          pid: 'pid',
          userType: "Ngo",
          driveTime: "Time",
          category: "",
          driveTitle: "",
        ),
      ],
    );
  }
}
