import 'package:aikyam/views/widgets/roundAppBar.dart';
import 'package:aikyam/views/widgets/userRequestTile.dart';
import 'package:flutter/material.dart';

class ApplicantsScreen extends StatelessWidget {
  const ApplicantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 85,
          flexibleSpace: RoundAppBar(
            title: '\t\t\t\t\tApplicants',
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
