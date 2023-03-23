import 'package:aikyam/views/Screens/User/EditProfile.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isSelected = true;
  bool _isUserPov = true;
  bool _isAboutActive = true;

  void _toggleButton() {
    setState(() {
      _isAboutActive = !_isAboutActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
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
                        SizedBox(
                          height: 36.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dip Hire',
                              style: kTextPopB24,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15.0),
                                color: kprimaryColor,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditUser()));
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
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text('edit',
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
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text('Chat',
                                                style: kTextPopB14.copyWith(
                                                    color: ksecondaryColor)),
                                          ],
                                        )
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Short info what this foundation do also the category and foundation type written by foundation',
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
                      backgroundImage: AssetImage('assets/images/dp.jpg'),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    color: kprimaryColor,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor:
                            _isAboutActive ? kprimaryColor : ksecondaryColor,
                      ),
                      onPressed: _toggleButton,
                      icon: Icon(
                        Icons.info_outline_rounded,
                        size: 24.0,
                        color: _isAboutActive ? ksecondaryColor : kprimaryColor,
                      ),
                      label: Text(
                        'About',
                        style: kTextPopM16.copyWith(
                          color:
                              _isAboutActive ? ksecondaryColor : kprimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    color: kprimaryColor,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor:
                            _isAboutActive ? kprimaryColor : ksecondaryColor,
                      ),
                      onPressed: _toggleButton,
                      icon: Icon(
                        Icons.work,
                        size: 24.0,
                        color: _isAboutActive ? ksecondaryColor : kprimaryColor,
                      ),
                      label: Text(
                        'Post',
                        style: kTextPopM16.copyWith(
                          color:
                              _isAboutActive ? ksecondaryColor : kprimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
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
                    subtitle: Text('Student', style: kTextPopR14),
                  ),
                  ListTile(
                    title: Text('Interest', style: kTextPopM16),
                    subtitle: Text('Social work', style: kTextPopR14),
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  Text('Contact', style: kTextPopB16),
                  SizedBox(height: 8),
                  ListTile(
                    title: Text('Email id', style: kTextPopM16),
                    subtitle: Text('thisisngo@gmail.com', style: kTextPopR14),
                  ),
                  ListTile(
                    title: Text('Mobile Number', style: kTextPopM16),
                    subtitle: Text('9876543210', style: kTextPopR14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
