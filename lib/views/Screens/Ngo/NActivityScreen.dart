import 'package:aikyam/views/widgets/Post2.dart';
import 'package:aikyam/views/widgets/activityPost.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/Post2.dart';

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
          child: SizedBox(
            height: 500,
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
                              if (auth.currentUser!.uid == document['NgoId']) {
                                return Text("No Post Found");
                              }
                              return const Center(
                                child: Text("No Post Found"),
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
            //   child: Column(
            // children: [
            //   ActivityPost(
            //       ngoname: 'ngoname',
            //       ngocity: 'ngocity',
            //       drivecity: 'drivecity',
            //       driveaddress: 'driveaddress',
            //       driveDate: 'driveDate',
            //       applyStatus: 'applyStatus',
            //       pid: 'pid'),
            // ],
          ),
        ),
      ),
    );
  }
}
