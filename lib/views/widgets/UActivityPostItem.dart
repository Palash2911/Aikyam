import 'package:aikyam/views/Screens/Ngo/NgoProfileScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';

class UActivityPostItem extends StatefulWidget {
  final String ngoName;
  final String ngoCity;
  final String driveCity;
  final String date;
  final String time;
  final String applyStatus;
  final String pid;

  const UActivityPostItem({
    super.key,
    required this.ngoName,
    required this.ngoCity,
    required this.driveCity,
    required this.date,
    required this.time,
    required this.applyStatus,
    required this.pid,
  });

  @override
  State<UActivityPostItem> createState() => _UActivityPostItemState();
}

class _UActivityPostItemState extends State<UActivityPostItem> {
  @override
  Widget build(BuildContext context) {
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
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => ViewDetails()));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NgoProfile()));
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
                            widget.ngoName,
                            style: kTextPopM16,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(widget.ngoCity, style: kTextPopR14),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                "Title",
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
                  Text(widget.driveCity, style: kTextPopR14)
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
                      widget.date,
                      style: kTextPopR14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                  child: widget.applyStatus == "InProcess" || widget.applyStatus == "Accepted"
                      ? Text(widget.applyStatus,
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
