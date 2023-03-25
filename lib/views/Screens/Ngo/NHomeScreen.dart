import 'package:aikyam/models/post.dart';
import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/providers/post_provider.dart';
import 'package:aikyam/views/widgets/AppBarHome.dart';
import 'package:aikyam/views/widgets/AppDrawer.dart';
import 'package:aikyam/views/widgets/Post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NHomeScreen extends StatefulWidget {
  const NHomeScreen({super.key});

  static const routeName = '/ngo_home_screen';

  @override
  State<NHomeScreen> createState() => _NHomeScreenState();
}

class _NHomeScreenState extends State<NHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance;
  CollectionReference postRef = FirebaseFirestore.instance.collection('Posts');
  List<dynamic> appliedId = [];
  var pp = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getappliedId();
  }

  void _getappliedId() async {
    await Provider.of<PostProvider>(context).getAppliedID("Ngo").then((value) {
      appliedId = value;
      pp = Provider.of<Auth>(context, listen: false).profilePic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 85,
          flexibleSpace: HomeAppBar(),
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: CircleAvatar(
              radius: 25.0,
              backgroundImage: pp.isNotEmpty
                  ? Image.network(pp).image
                  : const AssetImage('assets/images/dp.jpg'),
            ),
          ),
        ),
        drawer: NgoAppdrawer(),
        body: SingleChildScrollView(
          child: Container(
            height:
                MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: postRef.snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text("No Post Yet !"),
                          );
                        } else {
                          return ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: snapshot.data!.docs.map((document) {
                              if (appliedId.isNotEmpty) {
                                if (appliedId.contains(document.id)) {
                                  return PostItem(
                                    post: Post(
                                      category: document["Category"],
                                      description: document["Description"],
                                      ngoid: document["NgoId"],
                                      id: document.id,
                                      noofVolunters: document['NoOfVolunteers'],
                                      date: document["Date"],
                                      time: document["Time"],
                                      city: document["City"],
                                      driveTitle: document["Title"],
                                      ncity: document["NgoCity"],
                                      ngoname: document["NgoName"],
                                      state: document["State"],
                                      address: document["Address"],
                                      country: document["Country"],
                                      photos: document["Photos"],
                                    ),
                                    applyStatus: "Applied",
                                    userType: "Ngo",
                                  );
                                }
                              }
                              return PostItem(
                                post: Post(
                                  category: document["Category"],
                                  description: document["Description"],
                                  ngoid: document["NgoId"],
                                  id: document.id,
                                  noofVolunters: document['NoOfVolunteers'],
                                  date: document["Date"],
                                  time: document["Time"],
                                  city: document["City"],
                                  driveTitle: document["Title"],
                                  ncity: document["NgoCity"],
                                  ngoname: document["NgoName"],
                                  state: document["State"],
                                  address: document["Address"],
                                  country: document["Country"],
                                  photos: document["Photos"],
                                ),
                                applyStatus: "Apply",
                                userType: "Ngo",
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
        ),
      ),
    );
  }
}
