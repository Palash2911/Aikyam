import 'package:aikyam/views/widgets/AppBarHome.dart';
import 'package:aikyam/views/widgets/AppDrawer.dart';
import 'package:aikyam/views/widgets/Post2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance;
  CollectionReference postRef = FirebaseFirestore.instance.collection('Posts');
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
            icon: const CircleAvatar(
              radius: 25.0,
              backgroundImage: AssetImage('assets/images/dp.jpg'),
            ),
          ),
        ),
        drawer: const UserAppdrawer(),
        body: SingleChildScrollView(
          child: Container(
            height:
                MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
            margin: EdgeInsets.only(top: 20, bottom: 120),
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
                              return PostItem(
                                ngoname: document["NgoName"],
                                ngocity: document["NgoCity"],
                                drivecity: document["City"],
                                driveaddress: document["Address"],
                                driveDate: document["Date"],
                                applyStatus: "Apply",
                                pid: document.id,
                                userType: "User",
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
