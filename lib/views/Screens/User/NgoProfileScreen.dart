import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';

class NgoProfile extends StatefulWidget {
  const NgoProfile({super.key});

  @override
  State<NgoProfile> createState() => _NgoProfileState();
}

class _NgoProfileState extends State<NgoProfile> {
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
                              'Smile Foundation',
                              style: kTextPopB24,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: kprimaryColor,
                                  foregroundColor: ksecondaryColor,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.location_on_rounded)),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                CircleAvatar(
                                  backgroundColor: kprimaryColor,
                                  foregroundColor: ksecondaryColor,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.link_rounded)),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                CircleAvatar(
                                  backgroundColor: kprimaryColor,
                                  foregroundColor: ksecondaryColor,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.message_rounded)),
                                ),
                              ],
                            )
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
                    top: 50,
                    left: MediaQuery.of(context).size.width / 5 - 64,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        color: const Color(0xffFF0E58),
                        child: Image.asset('assets/images/dp.jpg'),
                      ),
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
