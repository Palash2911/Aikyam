import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../constants.dart';

class Post2 extends StatefulWidget {
  @override
  State<Post2> createState() => _Post2State();
}

class _Post2State extends State<Post2> {
  bool _isExpanded = false;

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kpostColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('smile foundation',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 8),
                        Text('February 17, 2023'),
                        SizedBox(width: 16),
                        Icon(Icons.location_on),
                        SizedBox(width: 8),
                        Text('Pune'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer sed leo id risus volutpat suscipit. Sed consequat magna in enim faucibus, vel volutpat risus sagittis. Donec interdum ipsum non mauris malesuada, sit amet iaculis felis auctor.',
                maxLines: _isExpanded ? null : 100,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: toggleExpand,
              child: Text(
                _isExpanded ? 'See more' : 'see less',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 16),
            Image.asset(
              'assets/images/dp.jpg',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  color: kprimaryColor,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(FeatherIcons.heart),
                        SizedBox(width: 8),
                        Text('123'),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: kprimaryColor,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(FeatherIcons.plusSquare),
                        SizedBox(width: 8),
                        Text('Apply'),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8),
                    Text('202'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
