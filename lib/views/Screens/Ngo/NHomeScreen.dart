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
  final auth = FirebaseAuth.instance;
  CollectionReference postRef = FirebaseFirestore.instance.collection('Posts');
  List<dynamic> appliedId = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getappliedId();
  }

  void _getappliedId() async {
    await Provider.of<PostProvider>(context).getAppliedID("Ngo").then((value) {
      appliedId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 85,
          flexibleSpace: HomeAppBar(),
        ),
        drawer: const NgoAppdrawer(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height >=
                    MediaQuery.of(context).size.height -
                        kBottomNavigationBarHeight
                ? 500
                : 300,
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
                              if(appliedId.isNotEmpty)
                                {
                                  if(appliedId.contains(document.id))
                                    {
                                      return PostItem(
                                        ngoname: document["NgoName"],
                                        ngocity: document["NgoCity"],
                                        drivecity: document["City"],
                                        driveaddress: document["Address"],
                                        driveDate: document["Date"],
                                        applyStatus: "Applied",
                                        pid: document.id,
                                        userType: "Ngo",
                                      );
                                    }
                                }
                              return PostItem(
                                ngoname: document["NgoName"],
                                ngocity: document["NgoCity"],
                                drivecity: document["City"],
                                driveaddress: document["Address"],
                                driveDate: document["Date"],
                                applyStatus: "Apply",
                                pid: document.id,
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
