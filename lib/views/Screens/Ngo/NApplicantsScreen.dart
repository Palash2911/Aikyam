import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:aikyam/views/widgets/userRequestTile.dart';
import 'package:flutter/material.dart';

class ApplicantsScreen extends StatefulWidget {
  const ApplicantsScreen({super.key});

  @override
  State<ApplicantsScreen> createState() => _ApplicantsScreenState();
}

class _ApplicantsScreenState extends State<ApplicantsScreen> {
  @override
  Widget build(BuildContext context) {
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
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Column(
              children: [
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
                ProfileTile(
                  name: 'Dip Hire',
                  city: 'Pune',
                  imageUrl: 'assets/images/dp.jpg',
                  onAccept: () {},
                  onReject: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
