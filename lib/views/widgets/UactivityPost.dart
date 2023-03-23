import 'package:aikyam/views/Screens/Ngo/NApplicantsScreen.dart';
import 'package:aikyam/views/Screens/User/NgoProfileScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/PopUpMenu.dart';
import 'package:aikyam/views/widgets/fillbutton.dart';
import 'package:aikyam/views/widgets/viewPostDetailsScreen.dart';
import 'package:flutter/material.dart';

class UActivityPost extends StatefulWidget {
  final String ngoname;
  final String ngocity;
  final String drivecity;
  final String driveaddress;
  final String driveDate;
  final String pid;

  const UActivityPost({
    super.key,
    required this.ngoname,
    required this.ngocity,
    required this.drivecity,
    required this.driveaddress,
    required this.driveDate,
    required this.pid,
  });

  @override
  State<UActivityPost> createState() => _UActivityPostState();
}

class _UActivityPostState extends State<UActivityPost> {
  bool _status = true;
  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(initialPage: 0);
    bool _isApply = true;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kpostColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ViewDetails()));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NgoProfile()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        color: Colors.grey,
                        child: Image.asset('assets/images/dp.jpg'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.ngoname,
                            style: kTextPopM16,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(widget.ngocity, style: kTextPopR14),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.share,
                      size: 32.0,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                'This is title of the ngo drive its a little bit big tittle its a little bit big tittler',
                style: kTextPopM16,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(Icons.location_city),
                  SizedBox(width: 5),
                  Text('City: ', style: kTextPopB14),
                  Text('Pune', style: kTextPopR14)
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.access_time_rounded),
                  SizedBox(width: 5),
                  Text('Date and Time: ', style: kTextPopB14),
                  Expanded(
                    child: Text(
                      '19 Mar ',
                      style: kTextPopR14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 5),
                  Text('Category: ', style: kTextPopB14),
                  Text('Education', style: kTextPopR14)
                ],
              ),
              SizedBox(height: 5),
              const SizedBox(height: 16),
              Center(
                  child: _status
                      ? Text('In-progress',
                          style: kTextPopM16.copyWith(color: kprimaryColor))
                      : Text('Rejected',
                          style: kTextPopM16.copyWith(color: kprimaryColor))),
            ],
          ),
        ),
      ),
    );
  }
}
