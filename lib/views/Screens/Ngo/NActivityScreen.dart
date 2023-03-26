import 'package:aikyam/providers/ngo_provider.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/NactivityPost.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NgoActivityScreen extends StatefulWidget {
  const NgoActivityScreen({super.key});

  static const routeName = '/ngo_activity_screen';

  @override
  State<NgoActivityScreen> createState() => _NgoActivityScreenState();
}

class _NgoActivityScreenState extends State<NgoActivityScreen> {
  final auth = FirebaseAuth.instance;
  CollectionReference postRef = FirebaseFirestore.instance.collection('Posts');
  List<dynamic> createdId = [];
  var isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getCreatedId();
  }

  void _getCreatedId() async {
    await Provider.of<NgoProvider>(context)
        .getNgoDetails(auth.currentUser!.uid)
        .then((value) {
      createdId = value!.postId;
    });
    setState(() {
      isLoading = false;
    });
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
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height -
                      kBottomNavigationBarHeight,
                  padding: const EdgeInsets.only(bottom: 120),
                  child: Column(
                    children: [
                      createdId.isEmpty
                          ? Center(
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
                            )
                          : Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: postRef.snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return ListView(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      children:
                                          snapshot.data!.docs.map((document) {
                                        if (auth.currentUser!.uid ==
                                            document['NgoId']) {
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
                                        } else {
                                          return const Text("");
                                        }
                                      }).toList(),
                                    );
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
