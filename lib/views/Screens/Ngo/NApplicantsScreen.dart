import 'package:aikyam/providers/auth_provider.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:aikyam/views/widgets/userRequestTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicantsScreen extends StatefulWidget {
  final String pid;

  const ApplicantsScreen({
    super.key,
    required this.pid,
  });

  @override
  State<ApplicantsScreen> createState() => _ApplicantsScreenState();
}

class _ApplicantsScreenState extends State<ApplicantsScreen> {
  CollectionReference? applicantRef;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    applicantRef = FirebaseFirestore.instance
        .collection('Posts')
        .doc(widget.pid)
        .collection("Applications");
  }

  @override
  Widget build(BuildContext context) {
    final authToken = Provider.of<Auth>(context, listen: false).token;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 85,
          flexibleSpace: const RoundAppBar(
            title: '\t\t\t\t\t\tApplicants',
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 500,
            margin:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: applicantRef!.snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text("No Applicants Yet !"),
                            );
                          } else {
                            return ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((document) {
                                return ProfileTile(
                                  name: document['ApplicantName'],
                                  city: document['PhoneNo'],
                                  imageUrl: document['ProfilePic'],
                                );
                              }).toList(),
                            );
                          }
                        }
                      }
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
