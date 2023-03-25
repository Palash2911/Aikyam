import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/Post.dart';
import 'package:aikyam/views/widgets/NactivityPost.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/Post.dart';

class NgoActivityScreen extends StatefulWidget {
  const NgoActivityScreen({super.key});

  static const routeName = '/ngo_activity_screen';

  @override
  State<NgoActivityScreen> createState() => _NgoActivityScreenState();
}

class _NgoActivityScreenState extends State<NgoActivityScreen> {
  final auth = FirebaseAuth.instance;
  CollectionReference postRef = FirebaseFirestore.instance.collection('Posts');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 85,
          flexibleSpace: const RoundAppBar(
            title: 'Activity',
          ),
        ),
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
                                SizedBox(
                                  height: 20.0,
                                ),
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
                            children: snapshot.data!.docs.map((document) {
                              if (auth.currentUser!.uid == document['NgoId']) {
                                return NActivityPost(
                                  ngoname: document['NgoName'],
                                  ngocity: document['NgoCity'],
                                  drivecity: document['City'],
                                  driveaddress: document['Address'],
                                  driveDate: document['Date'],
                                  pid: document.id,
                                  title: document["Title"],
                                  time: document["Time"],
                                  date: document["Date"],
                                  ngoId: document["NgoId"],
                                );
                              }
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
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      "No Post Found !",
                                      style: kTextPopM16,
                                    ),
                                  ],
                                ),
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
