import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isSelected = true;

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
                                child: Row(
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
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
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

            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10.0),
            //   child: Container(
            //     height: 100.0,
            //     width: 100.0,
            //     color: const Color(0xffFF0E58),
            //     child: Image.asset('assets/images/dp.jpg'),
            //   ),
            // ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    color: kprimaryColor,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(elevation: 0.0),
                      onPressed: () {},
                      icon: Icon(
                        Icons.info_outline_rounded,
                        size: 24.0,
                      ),
                      label: _isSelected
                          ? Text(
                              'About',
                              style: kTextPopM16,
                            )
                          : Text(
                              'About',
                              style: kTextPopM16,
                            ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: kprimaryColor,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor:
                            _isSelected ? kprimaryColor : ksecondaryColor,
                      ),
                      onPressed: () {},
                      icon: Icon(
                        Icons.work,
                        size: 24.0,
                      ),
                      label: Text(
                        'Post',
                        style: kTextPopM16,
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
                  Text('About', style: kTextPopB16),
                  SizedBox(height: 8),
                  Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis volutpat nunc, in dignissim sapien tincidunt vel. Sed eget mauris ut sem consequat venenatis. Nunc id semper magna. Nam varius quam vel lorem luctus, vel ornare nisi ultrices.',
                      style: kTextPopR14),
                  SizedBox(height: 10),
                  Divider(),
                  Text('Information', style: kTextPopB16),
                  SizedBox(height: 8),
                  ListTile(
                    title: Text('Type', style: kTextPopM16),
                    subtitle: Text('Non-Profit', style: kTextPopR14),
                  ),
                  ListTile(
                    title: Text('Category', style: kTextPopM16),
                    subtitle: Text('health,Social work,Education',
                        style: kTextPopR14),
                  ),
                  ListTile(
                    title: Text('Established in', style: kTextPopM16),
                    subtitle: Text(
                      '2002',
                      style: kTextPopR14,
                    ),
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
