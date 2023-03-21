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
          flexibleSpace: RoundAppBar(
            title: 'Activity',
          ),
        ),
        body: SingleChildScrollView(
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
                            if (auth.currentuser!.uid == document['NgoId'])
                            {
                              return ActivityPost();
                            }
                            else{
                              print("No post created")
                            }
                          }).toList(),
                        );
                      }
                    }
                  },
                ),
              ),
              ActivityPost(),
            ],
          ),
        ),
      ),
    );
  }
}
//home screen pe jo stream builder waise hi here,  same as home screen
//53 me return listview
// 57 la activity post instead of postitem
// 18,19 as it is,
// //after else ie line 52
// if(auth.currentuser!.uid == document['NgoId']) { 
//   else:no post found or created.
  //return activity post;