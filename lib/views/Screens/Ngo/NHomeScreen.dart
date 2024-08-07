import 'package:aikyam/models/post.dart';
import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/providers/post_provider.dart';
import 'package:aikyam/views/constants.dart';
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
  var isLoading = true;
  var isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      _getappliedId();
    }
    isInit = false;
  }

  Future<void> _getappliedId() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<PostProvider>(context, listen: false).getAppliedID("Ngo").then((value) {
      appliedId = value;
      pp = Provider.of<Auth>(context, listen: false).profilePic;
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 85,
          flexibleSpace: const HomeAppBar(),
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: CircleAvatar(
              radius: 25.0,
              backgroundImage: pp.isNotEmpty
                  ? Image.network(pp).image
                  : const AssetImage('assets/images/ngo.png'),
            ),
          ),
        ),
        drawer: const NgoAppdrawer(),
        body: isLoading
            ? Center(
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset(
                    'assets/images/loading.gif',
                    fit: BoxFit.contain,
                  ),
                ),
              )
            : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height -
                    kBottomNavigationBarHeight,
                padding: const EdgeInsets.only(bottom: 120),
                child: RefreshIndicator(
                  onRefresh: _getappliedId,
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: postRef.orderBy("Date", descending: false).snapshots(),
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
                              } else {
                                return ListView(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children:
                                      snapshot.data!.docs.map((document) {
                                    if (appliedId.isNotEmpty) {
                                      if (appliedId.contains(document.id)) {
                                        return PostItem(
                                          post: Post(
                                            category: document["Category"],
                                            description:
                                                document["Description"],
                                            ngoid: document["NgoId"],
                                            id: document.id,
                                            noofVolunters:
                                                document['NoOfVolunteers'],
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
                                    if (document["NgoId"] ==
                                        auth.currentUser!.uid) {
                                      return const Text("");
                                    }
                                    return PostItem(
                                      post: Post(
                                        category: document["Category"],
                                        description: document["Description"],
                                        ngoid: document["NgoId"],
                                        id: document.id,
                                        noofVolunters:
                                            document['NoOfVolunteers'],
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
      ),
    );
  }
}
