import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Post extends StatelessWidget {
  const Post({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kfillbox10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 45.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Smile Foundation"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconInfo(
                          icon: FeatherIcons.calendar, text: '8 Mar, 10:30 Pm'),
                      SizedBox(
                        width: 10.0,
                      ),
                      IconInfo(icon: FeatherIcons.mapPin, text: 'Pune'),
                    ],
                  ),
                ],
              ),
              Icon(Icons.share),
            ],
          ),
          Text(
              "Lorem Ipsum is simply dummy text of the printing and sdjfjsdbf Lorem Ipsum is simply dummy text of the printing and Lorem Ipsum is simply dummy text of the printing simply dummy text of the printing and sdjfjsdbfLorem Ipsum is simply dummy Lorem Ipsum is simply dummy text of the printing and Lorem Ipsum is simply dummy text of the printing simply dummy text of the printing an fdf jfdf"),
        ],
      ),
    );
  }
}

class IconInfo extends StatelessWidget {
  const IconInfo({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 8), // Add some space between the icon and the date
        Text(text),
      ],
    );
  }
}
