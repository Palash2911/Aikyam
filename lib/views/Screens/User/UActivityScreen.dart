import 'package:aikyam/views/widgets/UActivityPostItem.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  static const routeName = '/activity_screen';

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final auth = FirebaseAuth.instance;
  CollectionReference applyRef = FirebaseFirestore.instance.collection('Users');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    applyRef = applyRef.doc(auth.currentUser!.uid).collection("AppliedPost");
  }

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
                    stream: applyRef.snapshots(),
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
