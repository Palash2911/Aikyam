import 'package:aikyam/views/widgets/Post2.dart';
import 'package:aikyam/views/widgets/activityPost.dart';
import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:flutter/material.dart';

class NgoActivityScreen extends StatelessWidget {
  const NgoActivityScreen({super.key});

  static const routeName = '/ngo_activity_screen';

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
              ActivityPost(
                  ngoname: 'ngoname',
                  ngocity: 'ngocity',
                  drivecity: 'drivecity',
                  driveaddress: 'driveaddress',
                  driveDate: 'driveDate',
                  applyStatus: 'applyStatus',
                  pid: 'pid'),
              PostItem(
                  ngoname: 'ngoname',
                  ngocity: 'ngocity',
                  drivecity: 'drivecity',
                  driveaddress: 'driveaddress',
                  driveDate: 'driveDate',
                  applyStatus: 'applyStatus',
                  pid: 'pid')
            ],
          ),
        ),
      ),
    );
  }
}
