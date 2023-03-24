import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/providers/ngo_provider.dart';
import 'package:aikyam/views/Screens/Ngo/NeditProfile.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/Post.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NgoProfile extends StatefulWidget {
  const NgoProfile({super.key});

  @override
  State<NgoProfile> createState() => _NgoProfileState();
}

class _NgoProfileState extends State<NgoProfile> {
  bool isNgoPov = true;  // ithe false kel ka dista chat option 
  bool _isAboutActive = true;
  bool _isWorkSelected = false;
  var profileUrl = "";
  var name = "";
  var about = "";
  var bio = "";
  var email = "";
  var phone = "";
  var type = "";
  var est = "";
  var category = "";

  void _aboutPressed() {
    setState(() {
      _isAboutActive = !_isAboutActive;
      _isWorkSelected = !_isWorkSelected;
    });
  }

  void _workPressed() {
    setState(() {
      _isWorkSelected = !_isWorkSelected;
      _isAboutActive = !_isAboutActive;
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchDetails();
  }

  void _fetchDetails() async {
    var authToken = Provider.of<Auth>(context).token;
    await Provider.of<NgoProvider>(context)
        .getNgoDetails(authToken)
        .then((value) {
      name = value!.name;
      email = value.email;
      phone = value.phone;
      profileUrl = value.firebaseUrl;
      est = value.date;
      type = value.type;
      category = value.category;
      about = value.bio;
      bio = value.bio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                              isNgoPov
                                  ? ClipRRect(
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
                                                    builder: (context) =>
                                                        NgoEditProfile()));
                                          },
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
                                              Text('Edit',
                                                  style: kTextPopB14.copyWith(
                                                      color: ksecondaryColor)),
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
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.location_on_rounded)),
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
                                              icon:
                                                  Icon(Icons.message_rounded)),
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

              // TabBar(tabs: [
              //   Tab(
              //     icon: Icon(Icons.info_outline_rounded,
              //         size: 24.0, color: kprimaryColor),
              //   ),
              //   Tab(
              //     icon: Icon(Icons.work_outlined,
              //         size: 24.0, color: kprimaryColor),
              //   ),
              // ]),
              // TabBarView(
              //   children: [
              //     _About(),
              //     _Post(),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child:
              // Container(
              //         padding: EdgeInsets.all(10.0),
              //         color: Colors.white,
              //         child: ElevatedButton.icon(
              //           style: ElevatedButton.styleFrom(
              //             elevation: 0.0,
              //             backgroundColor:
              //                 _isAboutActive ? kprimaryColor : ksecondaryColor,
              //           ),
              //           onPressed: _aboutPressed,
              //           icon: Icon(
              //             Icons.info_outline_rounded,
              //             size: 24.0,
              //             color: _isAboutActive ? ksecondaryColor : kprimaryColor,
              //           ),
              //           label: Text(
              //             'About',
              //             style: kTextPopM16.copyWith(
              //               color:
              //                   _isAboutActive ? ksecondaryColor : kprimaryColor,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.all(10.0),
              //         color: Colors.white,
              //         child: ElevatedButton.icon(
              //           style: ElevatedButton.styleFrom(
              //             elevation: 0.0,
              //             backgroundColor:
              //                 _isAboutActive ? kprimaryColor : ksecondaryColor,
              //           ),
              //           onPressed: _workPressed,
              //           icon: Icon(
              //             Icons.work,
              //             size: 24.0,
              //             color: _isAboutActive ? ksecondaryColor : kprimaryColor,
              //           ),
              //           label: Text(
              //             'Post',
              //             style: kTextPopM16.copyWith(
              //               color:
              //                   _isAboutActive ? ksecondaryColor : kprimaryColor,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
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
                  views: [_About(), _Post()],
                  onChange: (index) => print(index),
                ),
              ),
            ],
          ),
        ),
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

class _About extends StatelessWidget {
  const _About({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About', style: kTextPopB16),
          const SizedBox(height: 8),
          Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis volutpat nunc, in dignissim sapien tincidunt vel. Sed eget mauris ut sem consequat venenatis. Nunc id semper magna. Nam varius quam vel lorem luctus, vel ornare nisi ultrices.',
              style: kTextPopR14),
          const SizedBox(height: 10),
          const Divider(),
          Text('Information', style: kTextPopB16),
          const SizedBox(height: 8),
          ListTile(
            title: Text('Type', style: kTextPopM16),
            subtitle: Text('Non-Profit', style: kTextPopR14),
          ),
          ListTile(
            title: Text('Category', style: kTextPopM16),
            subtitle: Text('health,Social work,Education', style: kTextPopR14),
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
    );
  }
}
